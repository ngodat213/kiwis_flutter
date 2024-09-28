import 'package:flutter/material.dart';
import 'package:kiwis_flutter/app/routes/app_pages.dart';
import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:get/get.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      initialRoute: AppPages.INITIAL,
      theme: ThemeData(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.colorWhite,
        ),
      ),
    );
  }
}
