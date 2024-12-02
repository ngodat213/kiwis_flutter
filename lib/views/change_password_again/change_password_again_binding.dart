import 'package:get/get.dart';

import 'change_password_again_controller.dart';

class ChangePasswordAgainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordAgainController>(
      () => ChangePasswordAgainController(),
    );
  }
}
