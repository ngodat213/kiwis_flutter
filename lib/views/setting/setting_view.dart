import 'package:flutter/material.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';

import '../controllers/setting_controller.dart';

class SettingView extends BaseView<SettingController> {
  SettingView({super.key});
  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SettingView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SettingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
