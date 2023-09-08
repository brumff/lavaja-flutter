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
    apiKey: 'AIzaSyB_sz2GfNvsGySyDMAdpGYhkmj7kKt9wBg',
    appId: '1:398186825013:web:02106fb10ce6a1ec01b87c',
    messagingSenderId: '398186825013',
    projectId: 'lavaja-392623',
    authDomain: 'lavaja-392623.firebaseapp.com',
    storageBucket: 'lavaja-392623.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC09y2KXxYaA2J4YXBACdhIAu1BaLkLN30',
    appId: '1:398186825013:android:041dd1dd943b232501b87c',
    messagingSenderId: '398186825013',
    projectId: 'lavaja-392623',
    storageBucket: 'lavaja-392623.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCKl2D1vxRqts7tI_tlxK2NH6SjruBY5bI',
    appId: '1:398186825013:ios:1673c2dd3d92afdd01b87c',
    messagingSenderId: '398186825013',
    projectId: 'lavaja-392623',
    storageBucket: 'lavaja-392623.appspot.com',
    iosClientId: '398186825013-021pi0ek892f9nin2npbpm998g7ehfr6.apps.googleusercontent.com',
    iosBundleId: 'com.example.lavaja',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCKl2D1vxRqts7tI_tlxK2NH6SjruBY5bI',
    appId: '1:398186825013:ios:1673c2dd3d92afdd01b87c',
    messagingSenderId: '398186825013',
    projectId: 'lavaja-392623',
    storageBucket: 'lavaja-392623.appspot.com',
    iosClientId: '398186825013-021pi0ek892f9nin2npbpm998g7ehfr6.apps.googleusercontent.com',
    iosBundleId: 'com.example.lavaja',
  );
}
