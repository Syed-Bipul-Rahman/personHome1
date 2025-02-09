
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:home_health_app/view/screen/Role/CareGiver/jobListScreen.dart';
import 'package:home_health_app/view/screen/Role/CareGiver/pdfview/pdfview_screen.dart';
import 'package:home_health_app/view/screen/Role/CareGiver/wallet/caregiver_wallet_screen.dart';
import 'package:home_health_app/view/screen/Role/User/carePlan/care_plan_screen.dart';
import 'package:home_health_app/view/screen/Role/User/message/message_screen.dart';
import 'package:home_health_app/view/screen/Role/User/profile/profile_screen.dart';
import 'package:home_health_app/view/screen/Splash/onboarding_screen.dart';
import 'package:home_health_app/view/screen/Splash/splash_screen.dart';
import 'package:home_health_app/view/screen/auth/ForgotPassword/forgotPassword_screen.dart';
import 'package:home_health_app/view/screen/auth/join_as_screen.dart';


import '../Stripe Payment/stripe_payment_screen.dart';
import '../view/screen/Location/location_picker_screen.dart';
import '../view/screen/Role/CareGiver/booking/booking_details_screen.dart';
import '../view/screen/Role/CareGiver/booking/payment/request_payment_screen.dart';
import '../view/screen/Role/CareGiver/care_giver_home_Screen.dart';
import '../view/screen/Role/CareGiver/caregiver_profile_screen.dart';
import '../view/screen/Role/CareGiver/clients/care_giver_client_screen.dart';
import '../view/screen/Role/CareGiver/clients/care_giver_info_screen.dart';

import '../view/screen/Role/CareGiver/notificationDetails/notification_details_screen.dart';
import '../view/screen/Role/CareGiver/notificationDetails/shift_details_clock_out_Screen.dart';
import '../view/screen/Role/CareGiver/notificationDetails/shift_details_no_screen.dart';
import '../view/screen/Role/CareGiver/training/care_giver_training_screen.dart';
import '../view/screen/Role/CareGiver/training/training_details_screen.dart';
import '../view/screen/Role/CareGiver/tutorials/care_giver_tutorial_screen.dart';
import '../view/screen/Role/CareGiver/wallet/withdraw/caregiver_withdraw_screen.dart';
import '../view/screen/Role/CareGiver/wallet/withdraw_requests/caregiver_withdraw_request_screen.dart';
import '../view/screen/Role/CareGiver/work_under_review_screen.dart';
import '../view/screen/Role/User/cardDetails/card_details_screen.dart';
import '../view/screen/Role/User/carePlan/care_plan_details_screen.dart';
import '../view/screen/Role/User/category/addTask/add_task_screen.dart';
import '../view/screen/Role/User/category/all_category_screen.dart';
import '../view/screen/Role/User/category/sub_category_screen.dart';
import '../view/screen/Role/User/job/apply_job_step_one_screen.dart';
import '../view/screen/Role/User/job/apply_job_step_three_screen.dart';
import '../view/screen/Role/User/job/apply_job_step_two_screen.dart';
import '../view/screen/Role/User/job/job_details_screen.dart';
import '../view/screen/Role/User/matching/matching_screen.dart';
import '../view/screen/Role/User/message/message_inbox_screen.dart';
import '../view/screen/Role/User/notification/notification_details_screen.dart';
import '../view/screen/Role/User/notification/notification_screen.dart';
import '../view/screen/Role/User/payment/payment_screen.dart';
import '../view/screen/Role/User/profile/matching_distance_screen.dart';
import '../view/screen/Role/User/profile/personal_information_screen.dart';
import '../view/screen/Role/User/userHome/user_home_page_screen.dart';
import '../view/screen/auth/ForgotPassword/set_new_password_screen.dart';
import '../view/screen/auth/sign_in/signIn_screen.dart';
import '../view/screen/auth/sign_up/sign_up_screen.dart';
import '../view/screen/auth/verify_email/verify_screen.dart';
import '../view/screen/profile_info/fill_up_profile_info_screen.dart';
import '../view/screen/settings/aboutus/aboutUs_screen.dart';
import '../view/screen/settings/cancellationPolicy/cancellationPolicy.dart';
import '../view/screen/settings/chnagePassword/changePassword_screen.dart';
import '../view/screen/settings/contactUs/contactUs_screen.dart';
import '../view/screen/settings/privacyPolicy/privacy_policy_screen.dart';
import '../view/screen/settings/settings_screen.dart';
import '../view/screen/settings/termsConditions/terms_condition_screen.dart';


class AppRoutes{
  static String splashScreen = "/splash_screen";
  static String onboardingScreen = "/Onboarding_screen";

  static String joinAsScreen = "/joinAsScreen";
  static String signUpScreen = "/signUpScreen";
  static String signInScreen = "/signInScreen";
  static String verifyCodeScreen = "/verifyEmailScreen";
  static String fillUpProfileInfoScreen = "/fillUpProfileInfoScreen";
  static String forgotPasswordScreen = "/forgotPasswordScreen";

  static String userHomePageScreen = "/userHomePageScreen";
  static String carePlanScreen = "/carePlanScreen";
  static String messageScreen = "/messageScreen";
  static String profileScreen = "/profileScreen";
  static String caregiverProfileScreen = "/caregiverProfileScreen";


  static String allCategoryScreen = "/allCategoryScreen";
  static String subCategoryScreen = "/subCategoryScreen";
  static String addTaskScreen = "/addTaskScreen";


  static String cardDetailsScreen = "/cardDetailsScreen";
  static String jobDetailsScreen = "/jobDetailsScreen";
  static String applyJobStepOneScreen = "/applyJobStepOneScreen";
  static String applyJobStepTwoScreen = "/applyJobStepTwoScreen";
  static String applyJobStepThreeScreen = "/applyJobStepThreeScreen";


  static String carePlanDetailsScreen = "/carePlanDetailsScreen";
  static String messageInboxScreen = "/messageInboxScreen";


  static String personalInformationScreen = "/personalInformationScreen";
  static String matchingDistanceScreen = "/matchingDistanceScreen";



//caregiver
static String careGiverHomeScreen = "/careGiverHomeScreen";
static String careGiverClientScreen = "/careGiverClientScreen";
static String careGiverInfoScreen = "/careGiverInfoScreen";
static String careGiverTrainingScreen = "/careGiverTrainingScreen";
static String trainingDetailsScreen = "/trainingDetailsScreen";
static String careGiverTutorialScreen = "/careGiverTutorialScreen";

static String shiftDetailsScreen = "/shiftDetailsScreen";
static String bookingDetailsScreen = "/bookingDetailsScreen";

//settings
static String settingScreen = "/settingScreen";
static String changePasswordScreen = "/changePasswordScreen";
static String termsConditionScreen = "/termsConditionScreen";
static String privacyPolicyScreen = "/privacyPolicyScreen";
static String aboutUsScreen = "/aboutUsScreen";
static String helpAndSupportScreen = "/helpAndSupportScreen";
static String contactUsScreen = "/contactUsScreen";

static String workUnderReviewScreen = "/workUnderReviewScreen";
static String shiftDetailsClockOutScreen = "/shiftDetailsClockOutScreen";
static String shiftDetailsNoScreen = "/shiftDetailsNoScreen";
static String setNewPasswordScreen = "/setNewPasswordScreen";

static String jobListScreen = "/jobListScreen";
static String requestPaymentScreen = "/requestPaymentScreen";
static String caregiverWalletScreen = "/caregiverWalletScreen";
static String caregiverWithDrawScreen = "/caregiverWithDrawScreen";

static String notificationScreen = "/notificationScreen";
static String notificationDetailsScreen = "/notificationDetailsScreen";

static String paymentScreen = "/paymentScreen";
static String caregiverListScreen = "/caregiverListScreen";
static String caregiverWithdrawHIstoryScreen = "/caregiverWithdrawHIstoryScreen";
static String locationPickerScreen = "/locationPickerScreen";


static String pdfViewScreen = "/pdfViewScreen";





 static List<GetPage> page=[

   //SplashScreen
   GetPage(name:splashScreen, page: ()=>const SplashScreen(),transition: Transition.noTransition),
   GetPage(name:locationPickerScreen, page: ()=> LocationPickerScreen(),transition: Transition.noTransition),
   GetPage(name:onboardingScreen, page: ()=> OnboardingScreen(),transition: Transition.noTransition),
   GetPage(name:joinAsScreen, page: ()=>JoinAsScreen(),transition: Transition.noTransition),

   //Auth
   GetPage(name:signUpScreen, page: ()=> SignUpScreen(),transition: Transition.noTransition),
   GetPage(name:signInScreen, page: ()=> SignInScreen(),transition: Transition.noTransition),
   GetPage(name:verifyCodeScreen, page: ()=> VerifyCodeScreen(),transition: Transition.noTransition),
   GetPage(name:forgotPasswordScreen, page: ()=> ForgotPasswordScreen(),transition: Transition.noTransition),

    //FillUpProfileInfo
   GetPage(name:fillUpProfileInfoScreen, page: ()=> FillUpProfileInfoScreen(),transition: Transition.noTransition),

  //User
  GetPage(name:userHomePageScreen, page: ()=> UserHomePageScreen(),transition: Transition.noTransition),
  GetPage(name:carePlanScreen, page: ()=> CarePlanScreen(),transition: Transition.noTransition),
  GetPage(name:profileScreen, page: ()=> ProfileScreen(),transition: Transition.noTransition),

//category
  GetPage(name:allCategoryScreen, page: ()=> AllCategory(),transition: Transition.noTransition),
  GetPage(name:subCategoryScreen, page: ()=> SubCategoryScreen(),transition: Transition.noTransition),
  GetPage(name:addTaskScreen, page: ()=> AddTaskScreen(),transition: Transition.noTransition),


  GetPage(name:cardDetailsScreen, page: ()=> CardDetailsScreen(),transition: Transition.noTransition),
  GetPage(name:jobDetailsScreen, page: ()=> JobDetailsScreen(),transition: Transition.noTransition),
  GetPage(name:applyJobStepOneScreen, page: ()=> ApplyJobStepOneScreen(),transition: Transition.noTransition),
  GetPage(name:applyJobStepTwoScreen, page: ()=> ApplyJobStepTwoScreen(),transition: Transition.noTransition),
  GetPage(name:applyJobStepThreeScreen, page: ()=> ApplyJobStepThreeScreen(),transition: Transition.noTransition),

  GetPage(name:carePlanDetailsScreen, page: ()=> CarePlanDetailsScreen(),transition: Transition.noTransition),

   //message
  GetPage(name:messageScreen, page: ()=> MessageScreen(),transition: Transition.noTransition),
  GetPage(name:messageInboxScreen, page: ()=> MessageInboxScreen(),transition: Transition.noTransition),

   //profile information
  GetPage(name:personalInformationScreen, page: ()=> PersonalInformationScreen(),transition: Transition.noTransition),
  GetPage(name:matchingDistanceScreen, page: ()=> MatchingDistanceScreen(),transition: Transition.noTransition),

  //caregiver
  GetPage(name:careGiverHomeScreen, page: ()=> CareGiverHomeScreen(),transition: Transition.noTransition),
  GetPage(name:careGiverClientScreen, page: ()=> CareGiverClientScreen(),transition: Transition.noTransition),
  GetPage(name:careGiverInfoScreen, page: ()=> CareGiverInfoScreen(),transition: Transition.noTransition),
  GetPage(name:careGiverTrainingScreen, page: ()=> CareGiverTrainingScreen(),transition: Transition.noTransition),
  GetPage(name:trainingDetailsScreen, page: ()=> TrainingDetailsScreen(),transition: Transition.noTransition),
  GetPage(name:careGiverTutorialScreen, page: ()=> CareGiverTutorialScreen(),transition: Transition.noTransition),
  GetPage(name:shiftDetailsScreen, page: ()=> NotificationDetailsScreen(),transition: Transition.noTransition),

  GetPage(name:settingScreen, page: ()=> SettingScreen(),transition: Transition.noTransition),
  GetPage(name:changePasswordScreen, page: ()=> ChangePasswordScreen(),transition: Transition.noTransition),
  GetPage(name:changePasswordScreen, page: ()=> TermsandConditionsScreen(),transition: Transition.noTransition),
  GetPage(name:privacyPolicyScreen, page: ()=> PrivacyPolicyScreen(),transition: Transition.noTransition),
  GetPage(name:aboutUsScreen, page: ()=> AboutUsScreen(),transition: Transition.noTransition),
  GetPage(name:helpAndSupportScreen, page: ()=> HelpAndSupportScreen(),transition: Transition.noTransition),
  GetPage(name:contactUsScreen, page: ()=> ContactUsScreen(),transition: Transition.noTransition),


  GetPage(name:workUnderReviewScreen, page: ()=> WorkUnderReviewScreen(),transition: Transition.noTransition),
  GetPage(name:shiftDetailsClockOutScreen, page: ()=> ShiftDetailsClockOutScreen(),transition: Transition.noTransition),
  GetPage(name:caregiverProfileScreen, page: ()=> CaregiverProfileScreen(),transition: Transition.noTransition),
  GetPage(name:termsConditionScreen, page: ()=> TermsandConditionsScreen(),transition: Transition.noTransition),
  GetPage(name:shiftDetailsNoScreen, page: ()=> ShiftDetailsNoScreen(),transition: Transition.noTransition),

  GetPage(name:setNewPasswordScreen, page: ()=> SetNewPasswordScreen(),transition: Transition.noTransition),

   GetPage(name:jobListScreen, page: ()=> JobListScreen(),transition: Transition.noTransition),
   GetPage(name:bookingDetailsScreen, page: ()=> BookingDetailsScreen()),
   GetPage(name:requestPaymentScreen, page: ()=> RequestPaymentScreen()),
   GetPage(name:caregiverWalletScreen, page: ()=> CaregiverWalletScreen()),
   GetPage(name:caregiverWithDrawScreen, page: ()=> CaregiverWithDrawScreen()),


   GetPage(name:notificationScreen, page: ()=> NotificationScreen()),
   GetPage(name:notificationDetailsScreen, page: ()=> UserNotificationDetailsScreen()),

   GetPage(name:paymentScreen, page: ()=> PaymentScreen()),
   GetPage(name:caregiverListScreen, page: ()=> CaregiverListScreen()),
   GetPage(name:caregiverWithdrawHIstoryScreen, page: ()=> CaregiverWithdrawHIstoryScreen()),

   GetPage(name:pdfViewScreen, page: ()=> PdfviewScreen()),


  ];

}