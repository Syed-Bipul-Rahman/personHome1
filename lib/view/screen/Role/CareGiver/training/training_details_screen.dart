import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_health_app/view/base/custom_page_loading.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import '../../../../../helpers/route.dart';
import '../../../../../service/api_constants.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/style.dart';
import '../../../../base/care_giver_app_bar.dart';
import '../../../../base/custom_text.dart';

class TrainingDetailsScreen extends StatefulWidget {
  const TrainingDetailsScreen({super.key});

  @override
  State<TrainingDetailsScreen> createState() => _TrainingDetailsScreenState();
}

class _TrainingDetailsScreenState extends State<TrainingDetailsScreen> {
  var mediaUrl = '';
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    mediaUrl = Get.parameters['mediaUrl']!;
    print('mediaUrl: $mediaUrl');
    _initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> _initializePlayer() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      _videoPlayerController = VideoPlayerController.network(ApiConstants.baseUrl+mediaUrl);
      await _videoPlayerController!.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: false,
        looping: false,
        aspectRatio: _videoPlayerController!.value.aspectRatio,
        placeholder: Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
        ),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.0.w),
              child: CustomText(
                text: errorMessage,
                fontSize: 14.sp,
                color: Colors.red,
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      );

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error loading video: ${e.toString()}';
      });
    }
  }

  Widget _buildVideoPlayer() {
    if (_isLoading) {
      return Center(
        child: CustomPageLoading(),
      );
    } else if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: _errorMessage!,
                fontSize: 14.sp,
                color: Colors.red,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: _initializePlayer,
                child: CustomText(
                  text: 'Retry',
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    } else if (_chewieController != null) {
      return AspectRatio(
        aspectRatio: _videoPlayerController!.value.aspectRatio,
        child: Chewie(controller: _chewieController!),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "View Training",
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18.w),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 250.h,
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: _buildVideoPlayer(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}