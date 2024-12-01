import 'package:get/get.dart';
import 'package:kiwis_flutter/app/routes/app_pages.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/core/constants/app.value.dart';
import 'package:kiwis_flutter/requests/user.request.dart';
import 'package:kiwis_flutter/services/services.dart';

class SplashController extends BaseController {
  UserRequest _userRequest = UserRequest();
  @override
  void onInit() async {
    await delayScreen();
    super.onInit();
  }

  Future<void> delayScreen() async {
    Future.delayed(Duration(seconds: AppValues.splashScreenDelaySeconds),
        () async {
      if (await AuthServices.getAuthBearerToken() == "") {
        Get.offNamed(Routes.SIGN_IN);
      } else {
        final response = await _userRequest.getCurrentUser();
        if (response.allGood) {
          AuthServices.saveUser(response.body);
          Get.offNamed(Routes.MAIN);
        }
      }
    });
  }
}
