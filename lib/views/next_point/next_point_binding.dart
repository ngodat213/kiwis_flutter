import 'package:get/get.dart';

import 'next_point_controller.dart';

class NextPointBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NextPointController>(
      () => NextPointController(),
    );
  }
}
