import 'package:flutter/material.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';

import '../controllers/reminder_controller.dart';

class ReminderView extends BaseView<ReminderController> {
  ReminderView({super.key});
  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReminderView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ReminderView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
