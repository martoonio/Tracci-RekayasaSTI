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
    apiKey: 'AIzaSyDpROO3WN04QMGym0iheu5RNFs-6zqoQT0',
    appId: '1:170779542490:web:2ab6f2aa630bd60559f6e3',
    messagingSenderId: '170779542490',
    projectId: 'rekayasasti-tracci',
    authDomain: 'rekayasasti-tracci.firebaseapp.com',
    databaseURL:
        'https://rekayasasti-tracci-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'rekayasasti-tracci.appspot.com',
    measurementId: 'G-7RNXMHG5LM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB0cdz-1owf0epv04XUTImPiuyrS8R6zIg',
    appId: '1:170779542490:android:c7b4a8e295894de959f6e3',
    messagingSenderId: '170779542490',
    projectId: 'rekayasasti-tracci',
    databaseURL:
        'https://rekayasasti-tracci-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'rekayasasti-tracci.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDn2mjgnFia44zmV8C-KqYAh8tuD_LAkUM',
    appId: '1:170779542490:ios:6892f5178a0fc67e59f6e3',
    messagingSenderId: '170779542490',
    projectId: 'rekayasasti-tracci',
    databaseURL:
        'https://rekayasasti-tracci-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'rekayasasti-tracci.appspot.com',
    iosBundleId: 'com.example.tracci',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDn2mjgnFia44zmV8C-KqYAh8tuD_LAkUM',
    appId: '1:170779542490:ios:6892f5178a0fc67e59f6e3',
    messagingSenderId: '170779542490',
    projectId: 'rekayasasti-tracci',
    databaseURL:
        'https://rekayasasti-tracci-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'rekayasasti-tracci.appspot.com',
    iosBundleId: 'com.example.tracci',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDpROO3WN04QMGym0iheu5RNFs-6zqoQT0',
    appId: '1:170779542490:web:ee1e3953ecf5243f59f6e3',
    messagingSenderId: '170779542490',
    projectId: 'rekayasasti-tracci',
    authDomain: 'rekayasasti-tracci.firebaseapp.com',
    databaseURL:
        'https://rekayasasti-tracci-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'rekayasasti-tracci.appspot.com',
    measurementId: 'G-K9PZKWRGTB',
  );
}
