// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'firebase_options.dart';
import 'firebase_options.dart';

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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDh-LFUeeI87jkNg1WwbHIfUOEvNV4Uybc',
    appId: '1:753514310648:web:ae6b9fe903383f45ec040d',
    messagingSenderId: '753514310648',
    projectId: 'classw6-d9fc6',
    authDomain: 'classw6-d9fc6.firebaseapp.com',
    storageBucket: 'classw6-d9fc6.firebasestorage.app',
    measurementId: 'G-C9BC1L0C5E',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBnOQJ9gdtWs8cQm0Y67WTJgt30CYQszSQ',
    appId: '1:753514310648:ios:13adefdc9b994de8ec040d',
    messagingSenderId: '753514310648',
    projectId: 'classw6-d9fc6',
    storageBucket: 'classw6-d9fc6.firebasestorage.app',
    iosBundleId: 'com.example.project14Firebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBnOQJ9gdtWs8cQm0Y67WTJgt30CYQszSQ',
    appId: '1:753514310648:ios:13adefdc9b994de8ec040d',
    messagingSenderId: '753514310648',
    projectId: 'classw6-d9fc6',
    storageBucket: 'classw6-d9fc6.firebasestorage.app',
    iosBundleId: 'com.example.project14Firebase',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDh-LFUeeI87jkNg1WwbHIfUOEvNV4Uybc',
    appId: '1:753514310648:web:cbd0f5f168fab0b3ec040d',
    messagingSenderId: '753514310648',
    projectId: 'classw6-d9fc6',
    authDomain: 'classw6-d9fc6.firebaseapp.com',
    storageBucket: 'classw6-d9fc6.firebasestorage.app',
    measurementId: 'G-J1TZMDQ3B7',
  );

}