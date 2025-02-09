class ApiConstants {
  static const String baseUrl = "https://sayed3050.sobhoy.com";

  //============================ >> User Auth << =================================
  static const String signInEndPoint = "/v1/auth/login";
  static const String signUpEndPoint = "/v1/auth/register";
  static const String verifyEmailEndPoint = "/v1/auth/verify-email";
  static const String forgotPasswordEndPoint = "/v1/auth/forgot-password";
  static const String setNewPasswordEndPoint = "/v1/auth/reset-password";


  //============================ >> Category << =================================
  static const String allCategoryEndPoint = "/v1/category";
  static const String singleCategoryEndPoint = "/v1/category/signleCategory";

  //============================ >> Job << =================================
  static const String jobPostEndPoint = "/v1/jobpost";
  static const String singleJobPostEndPoint = "/v1/jobpost/signlePost";
  static const String applyJobEndPoint = "/v1/jobapply/applyedjob";

  //============================ >> Training << =================================
  static const String trainingEndPoint = "/v1/training";
  static const String tutorialEndPoint = "/v1/tutorial";

  //============================ >> Privacy policy << =================================
  static const String privacyPolicyEndPoint = "/v1/privacy/getPrivacy";
  static const String termsConditionsEndPoint = "/v1/termsCondition/getTermsCondition";
  static const String aboutUsEndPoint = "/v1/aboutUS/getAbout";

  //============================ >> Inbox << =================================
  static const String chatListEndPoint = "/v1/chating/chatlist";
  static const String sentMessageEndPoint = "/v1/chating/messages";
  static const String allMessageEndPoint = "/v1/chating/messages";


  //============================ >> task << =================================

  static const String createTaskEndPoint = "/v1/booking/create";

  //============================ >> Booking << =================================
  static const String myBookingEndPoint = "/v1/booking/mybooking";
  static const String myBookingDetailsEndPoint = "/v1/booking";


  //============================ >> Notification << =================================
  static const String myNotificationEndPoint = "/v1/notifications/particularNotification";
  static const String singleNotificationEndPoint = "/v1/notifications/bookings";

  //=====================================>>   Booking  <<========================================
  static const String acceptBookingEndPoint = "/v1/booking/accept";
  static const String singleBookingEndPoint = "/v1/booking";
  static const String cancelBookingEndPoint = "/v1/booking/cancel";
  static const String caregiverAcceptedBookingEndPoint = "/v1/booking/acceptedBooking";
  static const String caregiverCompletedBookingEndPoint = "/v1/booking/getCompletedBookings";


  //=====================================>>   work  <<========================================
static const String startWorkPostEndPoint = "/v1/booking/startWork";
static const String sendPaymentRequestEndPoint = "/v1/payments/sendPaymentRequest";

//=============================== Wallet =================================
static const String walletEndPoint = "/v1/payments/getCaregiverVouchers";

//=============================== Make payment =================================
static const String makePaymentEndPoint = "/v1/payments/processUserPayment";

//=============================== Withdraw  =================================
static const String caregiverWithdrawEndPoint = "/v1/withdraw/sendWithdrawRequest";

//=============================== Profile  =================================
static const String profileEndPoint = "/v1/users";

//=============================== Change Password  =================================
static const String changePasswordEndPoint = "/v1/auth/change-password";

//=============================== Notification  =================================
static const String notificationEndPoint = "/v1/notifications/particularNotification";

//=============================== Matching Controller =================================
static const String matchingEndPoint = "/v1/booking/matching?minRange=";

//=============================== Fill up profile =================================
static const String fillUpProfileEndPoint = "/v1/users";
static const String locationUpdateEndPoint = "/v1/location/update";
static const String requestHistorylist = "/v1/withdraw/getParticularWithdrawRequests";


}
