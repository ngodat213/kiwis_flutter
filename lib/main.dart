import 'dart:async';
import 'firebase_options.dart';

import 'package:kiwis_flutter/my_app.dart';
import 'package:kiwis_flutter/services/services.dart';
import 'package:kiwis_flutter/services/map.service.dart';
import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:kiwis_flutter/services/geolocator.service.dart';
import 'package:kiwis_flutter/services/notification.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

void main() async {
  await dotenv.load(fileName: ".env");
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

      await Get.putAsync(() => GeolocatorService().init());
      await Get.putAsync(() => MapService().init());
      await Get.putAsync(() => NotificationService().init());
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
