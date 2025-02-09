import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/job/job_post_model.dart';
import '../../service/api_client.dart';
import '../../service/api_constants.dart';
import '../../utils/app_strings.dart';

class JobPostsController extends GetxController {
  RxList<String> jobTitles = <String>[].obs;
  RxList<String> jobIds = <String>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobPosts();
  }

  //all job posts
//   fetchJobPosts() async {
//     isLoading.value = true;
//
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String? accessToken = prefs.getString(AppStrings.accessToken);
//
//     if (accessToken == null) {
//       Get.snackbar(AppStrings.errorTextSpecial.tr, "Unauthorized access");
//       isLoading.value = false;
//       return;
//     }
//
//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $accessToken'
//     };
//
//     var response = await ApiClient.getData(
//       ApiConstants.jobPostEndPoint,
//       headers: headers,
//     );
//
//     if (response.statusCode == 200) {
//       isLoading.value = false;
//       print('Response for job=------------->: ${response.body}');
// // var decodedResponse = jsonDecode(response.body['data']['attributes']['results']);
//       // Parse response using the model
//       var jobPostsResponse = JobPostsResponse.fromJson(response.body['data']['attributes']);
//
//
//       // for (var job in jobPostsResponse  ) {
//       //   jobTitles.add(job.title);
//       //   jobIds.add(job.id);
//       // }
//
//     } else {
//       var message = response.body['message'] ?? "Unknown error";
//       Get.snackbar(AppStrings.errorTextSpecial.tr, message);
//     }
//     isLoading.value = false;
//   }

  fetchJobPosts() async {
    isLoading.value = true;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString(AppStrings.accessToken);

    if (accessToken == null) {
      Get.snackbar(AppStrings.errorTextSpecial.tr, "Unauthorized access");
      isLoading.value = false;
      return;
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    var response = await ApiClient.getData(
      ApiConstants.jobPostEndPoint,
      headers: headers,
    );

    if (response.statusCode == 200) {
      isLoading.value = false;
      print('Response for job=------------->: ${response.body}');

      // Access the results array correctly
      var results = response.body['data']['attributes']['results'] as List;

      // Map each result to a JobPostsResponse object
      var jobPosts =
          results.map((job) => JobPostsResponse.fromJson(job)).toList();

      // Now you can populate your lists
      for (var job in jobPosts) {
        jobTitles.add(job.title);
        jobIds.add(job.id);
      }
    } else {
      var message = response.body['message'] ?? "Unknown error";
      Get.snackbar(AppStrings.errorTextSpecial.tr, message);
    }
    isLoading.value = false;
  }
}
