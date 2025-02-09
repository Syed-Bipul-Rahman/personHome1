import '../models/language_model.dart';

class AppConstants{
  static String APP_NAME = "Home Health Care";
  static String isLogged = "IsLogged";
  static String fcmToken = "fcmToken";

  static String caregiverImageUrl = "caregiverImageUrl";
  static String caregiverName = "caregiverName";


  // Share preference Key
  static String THEME ="theme";
  static const String LANGUAGE_CODE = 'language_code';
  static const String COUNTRY_CODE = 'country_code';
  static RegExp emailValidator = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp passwordValidator = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
  );
  static List<LanguageModel> languages = [
    LanguageModel( languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(languageName: 'French', countryCode: 'FR', languageCode: 'fr'),

  ];

//=================>> App Data from User fpr Car Rental App <<=============================
  static const String bearerToken = "BearerToken";
  static String role = "Role";
  static String startTimeKey = "jobStartTime";

}
enum Status { loading, completed, error, internetError }
enum Role {user, driver, agency}