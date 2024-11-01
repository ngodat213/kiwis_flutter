import 'package:get/get.dart';

import 'change_language_buttomsheet_controller.dart';

class ChangeListViewButtomsheetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeListViewController>(
      () => ChangeListViewController(),
    );
  }
}
