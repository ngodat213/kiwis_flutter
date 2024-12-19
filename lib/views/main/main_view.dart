import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../../core/constants/app_export.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/views/main/main_controller.dart';

class MainView extends BaseView<MainController> {
  MainView({super.key});

  @override
  Widget? bottomNavigationBar() {
    return Obx(
      () => Container(
        child: CrystalNavigationBar(
          paddingR: EdgeInsets.only(left: 45.h, right: 45.h, top: 5.h),
          currentIndex: controller.currentIndex.value,
          unselectedItemColor: Colors.white70,
          backgroundColor: Colors.black.withOpacity(0.1),
          outlineBorderColor: Colors.grey.withOpacity(0.4),
          indicatorColor: Colors.black.withOpacity(0.1),
          marginR: EdgeInsets.symmetric(horizontal: 70.h, vertical: 20.h),
          onTap: (index) {
            controller.currentIndex.value = index;
          },
          items: [
            /// Home
            CrystalNavigationBarItem(
              icon: IconlyBold.home,
              unselectedIcon: IconlyLight.home,
              selectedColor: appTheme.green600,
            ),

            /// Search
            CrystalNavigationBarItem(
              icon: IconlyBold.chat,
              unselectedIcon: IconlyLight.chat,
              selectedColor: appTheme.green600,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
      () => controller
          .mainScreenModel.value.screens[controller.currentIndex.value],
    );
  }
}
