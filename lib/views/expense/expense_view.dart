import 'package:flutter/material.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';

import 'expense_controller.dart';

class ExpenseView extends BaseView<ExpenseController> {
  @override
  bool get isNavigationBar => true;

  ExpenseView({super.key});
  @override
  Widget body(BuildContext context) {
    return Text(
      'ExpenseView is working',
      style: TextStyle(fontSize: 20),
    );
  }
}
