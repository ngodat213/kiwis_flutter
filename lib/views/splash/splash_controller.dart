import 'package:get/get.dart';
import 'package:kiwis_flutter/app/routes/app_pages.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/core/constants/app.value.dart';
import 'package:kiwis_flutter/services/services.dart';

class SplashController extends BaseController {
  @override
  void onInit() async {
    await delayScreen();
    super.onInit();
  }

  Future<void> delayScreen() async {
    Future.delayed(Duration(seconds: AppValues.splashScreenDelaySeconds),
        () async {
      Get.offNamed(Routes.SIGN_IN);
      if (await AuthServices.isAuthenticated()) {
        Get.offNamed(Routes.MAIN);
      } else {
        Get.offNamed(Routes.SIGN_IN);
      }
    });
  }
}
