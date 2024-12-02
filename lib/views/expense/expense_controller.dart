import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/expense/widgets/add_expense_content.dart';
import 'package:kiwis_flutter/views/expense/widgets/latest_entries_content.dart';
import 'package:kiwis_flutter/views/expense/widgets/saving_content.dart';
import 'package:kiwis_flutter/views/expense/widgets/total_expense_content.dart';

class ExpenseController extends BaseController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;

  void onTapRemindPressed() {}
  void onTapBudgetPressed() {}

  @override
  void onInit() async {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  void onTapAddIncome(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddExpenseContent(),
    );
  }

  void onTapEntries(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => EntriesView(),
    );
  }

  void onTapSaving(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SavingContent(),
    );
  }

  void onTabTotalExpense(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => TotalExpenseContent(),
    );
  }
}
