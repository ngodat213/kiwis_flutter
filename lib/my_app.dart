import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/app_export.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      translations: AppLocalization(),
      locale: Get.deviceLocale,
      getPages: AppPages.routes,
      fallbackLocale: Locale('en', 'US'),
      title: 'kiwis_flutter',
      initialRoute: AppPages.INITIAL,
    );
  }
}
