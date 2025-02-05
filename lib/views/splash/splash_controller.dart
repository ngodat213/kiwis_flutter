import 'package:get/get.dart';
import 'package:kiwis_flutter/app/routes/app_pages.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/core/constants/app.value.dart';
import 'package:kiwis_flutter/requests/user.request.dart';
import 'package:kiwis_flutter/services/notification.service.dart';
import 'package:kiwis_flutter/services/services.dart';
import 'package:kiwis_flutter/services/socket.service.dart';

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
        try {
          final response = await _userRequest.getCurrentUser();
          if (response.allGood) {
            AuthServices.saveUser(response.body);
            await NotificationService().initializeFirebaseMessaging();
            await Get.putAsync(
                () => SocketService().init(userId: response.body['userId']));
            Get.offNamed(Routes.MAIN);
          } else {
            Get.offNamed(Routes.SIGN_IN);
          }
        } catch (e) {
          Get.offNamed(Routes.SIGN_IN);
        }
      }
    });
  }
}
