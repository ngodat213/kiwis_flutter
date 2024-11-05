import 'package:get/get.dart';

import 'entries_controller.dart';

class EntriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EntriesController>(
      () => EntriesController(),
    );
  }
}
