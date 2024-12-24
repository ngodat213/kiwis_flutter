import 'package:get/get.dart';
import 'package:kiwis_flutter/views/home/home_controller.dart';

import 'on_plan_controller.dart';

class OnPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OnPlanController>(
      OnPlanController(),
    );
    Get.put<HomeController>(
      HomeController(),
    );
  }
}
