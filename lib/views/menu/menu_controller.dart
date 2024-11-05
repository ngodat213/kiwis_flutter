import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';

class MenuController extends BaseController {
  /// Handle
  void onPressedChangeLanguage() {
    Get.toNamed(Routes.CHANGE_LANGUAGE);
  }

  // void onPressedAbout() {
  //   Get.to(Routes.ABOUT);
  // }

  void onPressedLogout() {
    Get.to(Routes.SIGN_IN);
  }
}
