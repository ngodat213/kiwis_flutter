import 'package:get/get.dart';
import 'package:kiwis_flutter/controllers/location_search.controller.dart';

import 'plan_controller.dart';

class PlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlanController>(
      () => PlanController(),
    );
    Get.lazyPut<LocationSearchController>(
      () => LocationSearchController(),
    );
  }
}
