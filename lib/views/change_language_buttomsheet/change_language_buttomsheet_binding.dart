import 'package:get/get.dart';

import 'change_language_buttomsheet_controller.dart';

class ChangeLanguageButtomsheetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeLanguageButtomsheetController>(
      () => ChangeLanguageButtomsheetController(),
    );
  }
}
