// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDVbFX2dyL4dpaPHHAvhNVp9ARnLKtY9ic',
    appId: '1:607558856662:web:72b913f5f912433a67be77',
    messagingSenderId: '607558856662',
    projectId: 'home-health-157b6',
    authDomain: 'home-health-157b6.firebaseapp.com',
    storageBucket: 'home-health-157b6.firebasestorage.app',
    measurementId: 'G-SZ4LCG2F29',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDW2OLqc0JrJcf4NXpRhJ_Q1fWxEOVdnZM',
    appId: '1:607558856662:android:051f6e0955dd391167be77',
    messagingSenderId: '607558856662',
    projectId: 'home-health-157b6',
    storageBucket: 'home-health-157b6.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBohMNzaLBRtoEkicWraTP4KeWcm5qmaME',
    appId: '1:607558856662:ios:6bf5d8582f3c15e367be77',
    messagingSenderId: '607558856662',
    projectId: 'home-health-157b6',
    storageBucket: 'home-health-157b6.firebasestorage.app',
    iosBundleId: 'com.example.homeHealthApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBohMNzaLBRtoEkicWraTP4KeWcm5qmaME',
    appId: '1:607558856662:ios:6bf5d8582f3c15e367be77',
    messagingSenderId: '607558856662',
    projectId: 'home-health-157b6',
    storageBucket: 'home-health-157b6.firebasestorage.app',
    iosBundleId: 'com.example.homeHealthApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDVbFX2dyL4dpaPHHAvhNVp9ARnLKtY9ic',
    appId: '1:607558856662:web:9dce5f9f3c6c6d3967be77',
    messagingSenderId: '607558856662',
    projectId: 'home-health-157b6',
    authDomain: 'home-health-157b6.firebaseapp.com',
    storageBucket: 'home-health-157b6.firebasestorage.app',
    measurementId: 'G-7KKEDBMZQ3',
  );
}
