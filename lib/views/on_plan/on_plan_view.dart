import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'on_plan_controller.dart';

class OnPlanView extends GetView<OnPlanController> {
  const OnPlanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OnPlanView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OnPlanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
