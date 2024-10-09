import 'package:get/get.dart';

import 'add_income_controller.dart';

class AddIncomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddIncomeController>(
      () => AddIncomeController(),
    );
  }
}
