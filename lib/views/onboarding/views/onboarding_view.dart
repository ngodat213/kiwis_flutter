import 'package:flutter/material.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends BaseView<OnboardingController> {
  OnboardingView({super.key});
  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OnboardingView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OnboardingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
