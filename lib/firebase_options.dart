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
    apiKey: 'AIzaSyAFSRWQPs9n8UZGhe3uucCsoXOCJw4cfe8',
    appId: '1:431668434379:web:5d6b65c30574eaa749924e',
    messagingSenderId: '431668434379',
    projectId: 'chat-app-6d741',
    authDomain: 'chat-app-6d741.firebaseapp.com',
    storageBucket: 'chat-app-6d741.appspot.com',
    measurementId: 'G-R32J81J50M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDdVT7X47BqYG69u1PJqa3xZJqcxQFGHoE',
    appId: '1:431668434379:android:c9f6b96284da438a49924e',
    messagingSenderId: '431668434379',
    projectId: 'chat-app-6d741',
    storageBucket: 'chat-app-6d741.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDymTt_WzMF5KUS3bAKISn6ZPa_lQBh2oU',
    appId: '1:431668434379:ios:a04885720c48678e49924e',
    messagingSenderId: '431668434379',
    projectId: 'chat-app-6d741',
    storageBucket: 'chat-app-6d741.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDymTt_WzMF5KUS3bAKISn6ZPa_lQBh2oU',
    appId: '1:431668434379:ios:a04885720c48678e49924e',
    messagingSenderId: '431668434379',
    projectId: 'chat-app-6d741',
    storageBucket: 'chat-app-6d741.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAFSRWQPs9n8UZGhe3uucCsoXOCJw4cfe8',
    appId: '1:431668434379:web:2b1a270276597cd349924e',
    messagingSenderId: '431668434379',
    projectId: 'chat-app-6d741',
    authDomain: 'chat-app-6d741.firebaseapp.com',
    storageBucket: 'chat-app-6d741.appspot.com',
    measurementId: 'G-FFG7MW3C8J',
  );
}
