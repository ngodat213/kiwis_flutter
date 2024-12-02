import 'package:get/get.dart';

import 'change_password_success_controller.dart';

class ChangePasswordSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordSuccessController>(
      () => ChangePasswordSuccessController(),
    );
  }
}
