import 'package:flutter/material.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';

import '../controllers/splash_controller.dart';

class SplashView extends BaseView<SplashController> {
  SplashView({super.key});
  @override
  Widget body(BuildContext context) {
    return Center(
      child: Text(
        'SplashView is working',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
