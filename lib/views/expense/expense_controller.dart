import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';

class ExpenseController extends BaseController {
  void onTapSavingOnPressed() {}
  void onTapRemindPressed() {}
  void onTapBudgetPressed() {}

  void onTapEntriesPressed() {
    Get.toNamed(Routes.ENTRIES);
  }
}
