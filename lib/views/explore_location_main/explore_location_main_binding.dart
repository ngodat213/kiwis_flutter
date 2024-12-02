import 'package:get/get.dart';

import 'explore_location_main_controller.dart';

class ExploreLocationMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExploreLocationMainController>(
      () => ExploreLocationMainController(),
    );
  }
}
