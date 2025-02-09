import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import the provided model
import '../../models/job/single_job_post_model.dart';
import '../../service/api_client.dart';
import '../../service/api_constants.dart';
import '../../utils/app_strings.dart';

class SingleJobPostsController extends GetxController {
  Rx<JobPostAttributes> jobPost = Rx<JobPostAttributes>(JobPostAttributes(
    title: '',
    description: '',
    salary: 0,
    location: '',
    companyName: '',
    jobType: '',
    category: '',
    jobRequirements: [],
    qualifications: [],
    postedAt: DateTime.now(),
    id: '',
  ));
  RxBool isLoading = false.obs;

  // Fetch single job post based on postid
  fetchSingleJobPost(String postid) async {
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
      '${ApiConstants.singleJobPostEndPoint}/$postid',
      headers: headers,
    );

    if (response.statusCode == 200) {
      isLoading.value = false;

      // Parse the response using the model
      var jobPostResponse = JobPostResponse.fromJson(response.body);
      print('Single job post: ${jobPostResponse.data.attributes.title}');

      // Set the response to the jobPost variable
      jobPost.value = jobPostResponse.data.attributes;
    } else {
      var message = response.body['message'] ?? "Unknown error";
      Get.snackbar(AppStrings.errorTextSpecial.tr, message);
    }

    isLoading.value = false;
  }
}
