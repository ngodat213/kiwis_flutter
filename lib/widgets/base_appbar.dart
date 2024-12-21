import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import 'package:kiwis_flutter/widgets/app_bar/custom_app_bar.dart';

PreferredSizeWidget baseAppBar({
  required BuildContext context,
  required String title,
  List<Widget>? actions,
  void Function()? onBack,
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(Get.height * 0.13),
    child: Container(
      padding: EdgeInsets.only(top: 23),
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: CustomAppBar(
        leadingWidth: 44.h,
        leading: AppbarLeadingIconbutton(
          imagePath: ImageConstant.imgArrowLeftOnprimary,
          onTap: () => onBack != null ? onBack() : Get.back(),
        ),
        title: AppbarTitle(
          text: title.tr,
          margin: EdgeInsets.only(left: 16.h),
        ),
        actions: actions,
      ),
    ),
  );
}
