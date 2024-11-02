import 'package:kiwis_flutter/core/app_export.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';

class HomeController extends BaseController {
  /// Variables

  /// Handle
  void notificationOnPressed() {
    Get.toNamed(Routes.NOTIFICATION_CENTER);
  }

  void detailPostOnPressed() {
    Get.toNamed(Routes.DETAIL_POST);
  }
}
