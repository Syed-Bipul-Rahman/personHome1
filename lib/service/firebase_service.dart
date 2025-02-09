import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/app_constants.dart';
import '../helpers/prefs_helpers.dart';
import '../helpers/route.dart';


FlutterLocalNotificationsPlugin fln = FlutterLocalNotificationsPlugin();

class NotificationHelper {

  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static Future<void> getFcmToken() async {
    String? fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken != null) {
      PrefsHelper.setString(AppConstants.fcmToken, fcmToken);
    }
    print('FCM Token: $fcmToken');
  }

  //==================Request for permission and Generate FCM token=================
  static init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseMessaging messaging = FirebaseMessaging.instance;


    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint(
        'User granted permission==================>>>>>>>>>>>>: ${settings.authorizationStatus}');

    String? token = await messaging.getToken();

    //  SharePrefsHelper.setString(SharedPreferenceValue.fcmToken, token!);

    debugPrint('FCM TOKEN <<<<<<<=====>>>>>>> $token');
  }

  //==================Listen Firebase Notification in every State of the app=================

  static firebaseListenNotification({  required BuildContext context}) async {
    FirebaseMessaging.instance.subscribeToTopic('signedInUsers');
//============>>>>>Listen Notification when the app is in foreground state<<<<<<<===========

    FirebaseMessaging.onMessage.listen((message) {
      // debugPrint(
      //     "Firebase onMessage=============================>>>>>>>>>>>>>>>>>>${message.data}");
      //
      //
      initLocalNotification(message: message);

      print("Notification full  title======>${message.notification!.title.toString()}");
      // print("Notification type======>${message.data['type'].toString()}");
      if (message.data.isNotEmpty) {
        // Extract the 'type' field from the 'data' map
        String? type = message.data['type'];
        print("Notification type: $type");
      }

      showTextNotification(
        title: message.notification!.title!,
        body: message.notification!.body!,

      );
    });

//============>>>>>Listen Notification when the app is in BackGround state<<<<<<<===========

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(message: message);
    });

//============>>>>>Listen Notification when the app is in Terminated state<<<<<<<===========

    RemoteMessage? terminatedMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    if (terminatedMessage != null) {
      //handleMessage(message: terminatedMessage);
    }
  }

  //============================Initialize Local Notification=======================

  static Future<void> initLocalNotification(
      {required RemoteMessage message}) async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings("@mipmap/ic_launcher");

    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    fln
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await fln.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse? paylod) {
        debugPrint("==================>>>>>>>>>paylod hitted");
        handleMessage(message: message);
      },
    );
  }


  static handleMessage({required RemoteMessage message}) {
    Map<String, dynamic> data = message.data;

    String type = data["type"];
print("Notification type======>${data['type'].toString()}");

    // if(type == "booking") {
    //   Get.toNamed(AppRoutes.userNotificationScreen);
    // }

  }

// <-------------------------- Show Text Notification  --------------------------->
  static Future<void> showTextNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'notification', // meta-data android value
      'notification', // meta-data android value
      playSound: true,
      importance: Importance.low,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await fln.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}