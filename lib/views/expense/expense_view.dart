import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/views/expense/widgets/group_expense_listview.dart';
import 'package:kiwis_flutter/views/expense/widgets/icon_status_listview.dart';
import 'package:kiwis_flutter/views/expense/widgets/latest_entries_listview.dart';
import 'package:kiwis_flutter/views/expense/widgets/total_salary_listview.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_trainling_iconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/custom_app_bar.dart';

import 'expense_controller.dart';

class ExpenseScreen extends BaseView<ExpenseController> {
  @override
  bool get isNavigationBar => true;

  ExpenseScreen({super.key});
  @override
  Widget body(BuildContext context) {
    return Container(
      height: Get.height,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: _buildHeaderSection(),
          ),
          TotalSalaryListView(),
          GroupExpenseListView(controller: controller),
          IconStatusListView(controller: controller),
          LatestEntriesListView(),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildHeaderSection() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 16.0, vertical: 16), // Adjust padding as needed
      child: CustomAppBar(
        title: AppbarTitle(
          text: "Expense".tr,
          margin: EdgeInsets.only(left: 16.h),
        ),
      ),
    );
  }
}
