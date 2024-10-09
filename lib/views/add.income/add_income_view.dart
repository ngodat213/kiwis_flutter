import 'package:flutter/material.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';

import 'add_income_controller.dart';

class AddIncomeView extends BaseView<AddIncomeController> {
  AddIncomeView({super.key});
  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddIncomeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddIncomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
