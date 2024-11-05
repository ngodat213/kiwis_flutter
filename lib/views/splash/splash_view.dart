import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/app_export.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';

import 'splash_controller.dart';

class SplashScreen extends BaseView<SplashController> {
  SplashScreen({super.key});
  @override
  Widget body(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 28.h,
              width: 28.h,
              decoration: BoxDecoration(
                color: appTheme.green300,
                borderRadius: BorderRadiusStyle.customBorderTL14,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "k".tr,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.h),
            Text(
              "kiwis".tr,
              style: theme.textTheme.headlineMedium,
            )
          ],
        ),
      ),
    );
  }
}
