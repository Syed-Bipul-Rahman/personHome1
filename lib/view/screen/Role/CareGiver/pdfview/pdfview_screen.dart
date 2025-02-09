import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:home_health_app/service/api_constants.dart';
import 'package:home_health_app/view/base/custom_page_loading.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PdfviewScreen extends StatefulWidget {
  const PdfviewScreen({super.key});

  @override
  State<PdfviewScreen> createState() => _PdfviewScreenState();
}

class _PdfviewScreenState extends State<PdfviewScreen> {
  String mediaUrl = '';
  bool isLoading = true;
  String localPath = '';
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    mediaUrl =ApiConstants.baseUrl+ Get.parameters['mediaUrl']!;
    print('mediaUrl: $mediaUrl');
    loadPdf();
  }

  Future<void> loadPdf() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await http.get(Uri.parse(mediaUrl));

      if (response.statusCode == 200) {

        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/temp.pdf');

        await file.writeAsBytes(response.bodyBytes);

        setState(() {
          localPath = file.path;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load PDF: Server returned ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading PDF: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text('PDF Viewer'),
      ),
      body: Stack(
        children: [
          if (isLoading)
            const Center(
              child: CustomPageLoading(),
            )
          else if (errorMessage.isNotEmpty)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: loadPdf,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          else
            PDFView(
              filePath: localPath,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: true,
              pageFling: true,
              pageSnap: true,
              fitPolicy: FitPolicy.BOTH,
              onError: (error) {
                setState(() {
                  errorMessage = error.toString();
                });
              },
              onPageError: (page, error) {
                print('Error loading page $page: $error');
              },
            ),
        ],
      ),
    );
  }
}