import 'package:get/get.dart';

import 'saving_expense_controller.dart';

class SavingExpenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SavingExpenseController>(
      () => SavingExpenseController(),
    );
  }
}
