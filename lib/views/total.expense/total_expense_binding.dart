import 'package:get/get.dart';

import '../controllers/total_expense_controller.dart';

class TotalExpenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TotalExpenseController>(
      () => TotalExpenseController(),
    );
  }
}
