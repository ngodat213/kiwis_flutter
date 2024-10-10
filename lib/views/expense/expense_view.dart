import 'package:flutter/material.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';

import '../controllers/expense_controller.dart';

class ExpenseView extends BaseView<ExpenseController> {
  ExpenseView({super.key});
  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExpenseView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ExpenseView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
