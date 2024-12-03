import 'package:flutter/material.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';

import 'saving_expense_controller.dart';

class SavingExpenseView extends BaseView<SavingExpenseController> {
  SavingExpenseView({super.key});
  @override
  Widget body(BuildContext context) {
    return Text(
      'SavingExpenseView is working',
      style: TextStyle(fontSize: 20),
    );
  }
}
