import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:kiwis_flutter/my_app.dart';
import 'package:kiwis_flutter/services/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'firebase_options.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      //setting up firebase notifications
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await LocalizeAndTranslate.init(
        defaultType: LocalizationDefaultType.asDefined,
        supportedLocales: AppLanguages.codes,
        assetLoader: const AssetLoaderRootBundleJson('assets/locales/'),
      );
      await LocalStorageService.getPrefs();

      // Run app!
      runApp(
        const LocalizedApp(
          child: MyApp(),
        ),
      );
    },
    (error, stackTrace) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    },
  );
}
