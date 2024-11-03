import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../../core/app_export.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/views/main/main_controller.dart';

class MainView extends BaseView<MainController> {
  MainView({super.key});

  @override
  Widget? bottomNavigationBar() {
    return Obx(
      () => Container(
        child: CrystalNavigationBar(
          marginR: EdgeInsets.symmetric(horizontal: 16.h, vertical: 20.h),
          // itemPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          currentIndex: controller.currentIndex.value,
          unselectedItemColor: Colors.white70,
          backgroundColor: Colors.black.withOpacity(0.1),
          // outlineBorderColor: Colors.black.withOpacity(0.1),
          onTap: (index) {
            controller.currentIndex.value = index;
          },
          items: [
            /// Home
            CrystalNavigationBarItem(
              icon: IconlyBold.home,
              unselectedIcon: IconlyLight.home,
              selectedColor: appTheme.green60001,
            ),

            /// Favourite
            CrystalNavigationBarItem(
              icon: IconlyBold.chart,
              unselectedIcon: IconlyLight.chart,
              selectedColor: appTheme.green60001,
            ),

            /// Search
            CrystalNavigationBarItem(
              icon: IconlyBold.chat,
              unselectedIcon: IconlyLight.chat,
              selectedColor: appTheme.green60001,
            ),

            /// Profile
            CrystalNavigationBarItem(
              icon: IconlyBold.setting,
              unselectedIcon: IconlyLight.setting,
              selectedColor: appTheme.green60001,
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
