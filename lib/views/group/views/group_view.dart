import 'package:flutter/material.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';

import '../controllers/group_controller.dart';

class GroupView extends BaseView<GroupController> {
  GroupView({super.key});
  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GroupView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GroupView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
