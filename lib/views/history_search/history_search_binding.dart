import 'package:get/get.dart';

import 'history_search_controller.dart';

class HistorySearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistorySearchController>(
      () => HistorySearchController(),
    );
  }
}
