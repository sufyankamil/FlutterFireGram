// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyDVuTZLUuxHnK773xKcpsEoAL8fEx6dVV8',
    appId: '1:529354454444:web:be33f4beb8cc78cbc97609',
    messagingSenderId: '529354454444',
    projectId: 'instagram-clone-e3603',
    authDomain: 'instagram-clone-e3603.firebaseapp.com',
    storageBucket: 'instagram-clone-e3603.appspot.com',
    measurementId: 'G-61Q395WQG3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCzCyJEId5iQEIK-N8co1lQ-N6SFCzp7_Y',
    appId: '1:529354454444:android:5099acc8a8adaf8bc97609',
    messagingSenderId: '529354454444',
    projectId: 'instagram-clone-e3603',
    storageBucket: 'instagram-clone-e3603.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCTPHNSJA3_yPZvVx-9wVQszEB9VW5AFJM',
    appId: '1:529354454444:ios:3545c3cb16263931c97609',
    messagingSenderId: '529354454444',
    projectId: 'instagram-clone-e3603',
    storageBucket: 'instagram-clone-e3603.appspot.com',
    iosBundleId: 'com.exampl.instagramClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCTPHNSJA3_yPZvVx-9wVQszEB9VW5AFJM',
    appId: '1:529354454444:ios:8f074d71a8b66a52c97609',
    messagingSenderId: '529354454444',
    projectId: 'instagram-clone-e3603',
    storageBucket: 'instagram-clone-e3603.appspot.com',
    iosBundleId: 'com.example.instagramClone.RunnerTests',
  );
}