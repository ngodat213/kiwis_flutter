import 'package:flutter/material.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';

import '../controllers/total_expense_controller.dart';

class TotalExpenseView extends BaseView<TotalExpenseController> {
  TotalExpenseView({super.key});
  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TotalExpenseView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TotalExpenseView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
