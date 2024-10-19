import 'package:get/get.dart';

import 'invoce_controller.dart';

class InvoceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoceController>(
      () => InvoceController(),
    );
  }
}
