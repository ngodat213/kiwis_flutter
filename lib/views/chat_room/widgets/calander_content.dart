import 'package:flutter/material.dart';

import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_trainling_iconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/custom_app_bar.dart';

class CalenderContent extends StatelessWidget {
  const CalenderContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(Get.height * 0.09),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: CustomAppBar(
          leadingWidth: 44.h,
          leading: AppbarLeadingIconbutton(
            imagePath: ImageConstant.imgArrowLeftOnprimary,
            onTap: () {
              Get.back();
            },
          ),
          title: AppbarTitle(
            text: "Calender".tr,
            margin: EdgeInsets.only(left: 16.h),
          ),
          actions: [
            AppbarTrailingIconbutton(
              imagePath: ImageConstant.svgCalander,
              margin: EdgeInsets.only(right: 8.h),
            ),
            AppbarTrailingIconbutton(
              imagePath: ImageConstant.svgMore,
              margin: EdgeInsets.only(right: 8.h),
            ),
          ],
        ),
      ),
    );
  }
}
