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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAcoYJsbO7-IEjwPz_LWrPJg5hBRVLEth4',
    appId: '1:531040244474:web:ef93c1e5ddd138446b6f43',
    messagingSenderId: '531040244474',
    projectId: 'zer0kcal',
    authDomain: 'zer0kcal.firebaseapp.com',
    storageBucket: 'zer0kcal.firebasestorage.app',
    measurementId: 'G-KVB7NJEEFT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAmSpNguNm5fLeylUb7zYijjCgNof3yCCg',
    appId: '1:531040244474:android:caadcd857953c6456b6f43',
    messagingSenderId: '531040244474',
    projectId: 'zer0kcal',
    storageBucket: 'zer0kcal.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAnUDFkrBa9It5qK_8xVcubCU4zwS_lspI',
    appId: '1:531040244474:ios:e6c214c70a4c2fbf6b6f43',
    messagingSenderId: '531040244474',
    projectId: 'zer0kcal',
    storageBucket: 'zer0kcal.firebasestorage.app',
    iosBundleId: 'com.jylee.zer0kcal',
  );
}
