import 'package:get/get.dart';

import 'on_plan_controller.dart';

class OnPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OnPlanController>(
      OnPlanController(),
    );
  }
}
