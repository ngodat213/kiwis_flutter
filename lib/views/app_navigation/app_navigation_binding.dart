import 'package:get/get.dart';

import 'app_navigation_controller.dart';

class AppNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppNavigationController>(
      () => AppNavigationController(),
    );
  }
}
