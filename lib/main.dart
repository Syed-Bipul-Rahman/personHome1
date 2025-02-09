import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:home_health_app/service/firebase_service.dart';
import 'package:home_health_app/themes/light_theme.dart';
import 'package:home_health_app/utils/app_constants.dart';
import 'package:home_health_app/utils/message.dart';
import 'controller/settings/localization_controller.dart';
import 'controller/settings/theme_controller.dart';
import 'firebase_options.dart';
import 'helpers/di.dart' as di;
import 'helpers/route.dart';
import 'package:home_health_app/Stripe Payment/keys.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishableKey;
  await Stripe.instance.applySettings();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Map<String, Map<String, String>> _languages = await di.init();
  try {
    if (GetPlatform.isMobile) {
      final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (remoteMessage != null) {
      }

      print('Call Firebase Init');
      await NotificationHelper.init();

      // await NotificationHelper.init(flutterLocalNotificationsPlugin);
      // FirebaseMessaging.onBackgroundMessage(NotificationHelper.firebaseMessagingBackgroundHandler);

    }
  }catch(e) {}
  NotificationHelper.getFcmToken();

  runApp(MyApp(
    languages: _languages,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.languages});

  final Map<String, Map<String, String>> languages;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return ScreenUtilInit(
            designSize: const Size(393, 852),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return GetMaterialApp(
                title: AppConstants.APP_NAME,
                debugShowCheckedModeBanner: false,
                navigatorKey: Get.key,
                theme: light(),
                defaultTransition: Transition.topLevel,
                locale: localizeController.locale,
                translations: Messages(languages: languages),
                fallbackLocale: Locale(AppConstants.languages[0].languageCode,
                    AppConstants.languages[0].countryCode),
                transitionDuration: const Duration(milliseconds: 500),
                getPages: AppRoutes.page,
                initialRoute: AppRoutes.splashScreen,
                // initialRoute: AppRoutes.onboardingScreen,
                // Ensure that the 'home' widget is not duplicated within the navigation stack.
              );
            });
      });
    });
  }
}
