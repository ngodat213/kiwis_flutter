import 'package:flutter/material.dart';
import 'package:kiwis_flutter/app/routes/app_pages.dart';
import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:kiwis_flutter/managers/manager.dart';
import 'package:get/get.dart';
import 'package:kiwis_flutter/views/splash/bindings/splash_binding.dart';
import 'package:kiwis_flutter/views/splash/views/splash_view.dart';

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
      initialRoute: ManagerRoutes.destinationDetailScreen,
      initialBinding: SplashBinding(),
      theme: ThemeData(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.primaryColor,
        ),
      ),
      home: SplashView(),
    );
  }
}
