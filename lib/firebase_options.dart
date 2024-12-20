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
    apiKey: 'AIzaSyB79BQ6BMBRHs49ZK7RHzfP4TVrFMhx8UE',
    appId: '1:693145877062:web:4cbd76e2495848f314a847',
    messagingSenderId: '693145877062',
    projectId: 'kiwis-flutter',
    authDomain: 'kiwis-flutter.firebaseapp.com',
    storageBucket: 'kiwis-flutter.appspot.com',
    measurementId: 'G-4Q3C7EWBW2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDLQRqqV6xiZmPqUTgx0eVaFgvWsQVwwl8',
    appId: '1:693145877062:android:0d97ba1d11d52e7f14a847',
    messagingSenderId: '693145877062',
    projectId: 'kiwis-flutter',
    storageBucket: 'kiwis-flutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAN0pjYF48HV_5vLzVmsgLOKuk7m7L7FCk',
    appId: '1:693145877062:ios:af84d779a7fa77bb14a847',
    messagingSenderId: '693145877062',
    projectId: 'kiwis-flutter',
    storageBucket: 'kiwis-flutter.appspot.com',
    iosBundleId: 'com.example.kiwisFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAN0pjYF48HV_5vLzVmsgLOKuk7m7L7FCk',
    appId: '1:693145877062:ios:af84d779a7fa77bb14a847',
    messagingSenderId: '693145877062',
    projectId: 'kiwis-flutter',
    storageBucket: 'kiwis-flutter.appspot.com',
    iosBundleId: 'com.example.kiwisFlutter',
  );
}
