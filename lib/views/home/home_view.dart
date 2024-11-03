import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/views/home/widgets/home_content.dart';

import 'home_controller.dart';

class HomeScreen extends BaseView<HomeController> {
  HomeScreen({super.key});

  @override
  bool get isNavigationBar => true;

  @override
  Widget body(BuildContext context) {
    return HomeContent(
      notificationOnPressed: controller.notificationOnPressed,
      detailPostOnPressed: controller.detailPostOnPressed,
      cameraController: controller.cameraController,
      isCameraInitialized: controller.isCameraInitialized,
      isFlashOn: controller.isFlashOn,
      toggleFlash: controller.toggleFlash,
      takePicture: controller.takePicture,
      toggleRotate: controller.toggleRotate,
    );
  }
}
