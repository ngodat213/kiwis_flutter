import 'package:get/get.dart';
import 'package:kiwis_flutter/app/routes/app_pages.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';

class SplashController extends BaseController {
  var screenDelay = 3;

  @override
  void onInit() async {
    await delayScreen();
    super.onInit();
  }

  Future<void> delayScreen() async {
    Future.delayed(Duration(seconds: screenDelay), () async {
      Get.offNamed(Routes.SIGN_IN);
      // if (await BaseSharedPreferences.getStringValue(
      //         ManagerKeyStorage.accessToken) !=
      //     "") {
      // } else {
      //   Get.offNamed(ManagerRoutes.onboarding);
      // }
    });
  }
}
