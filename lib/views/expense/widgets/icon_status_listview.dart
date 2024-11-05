import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';

import 'package:kiwis_flutter/views/expense/expense_controller.dart';

class IconStatusListView extends GetView<ExpenseController> {
  const IconStatusListView({
    super.key,
    required this.controller,
  });

  final ExpenseController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.h, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIconStatusWidget(
            icon: IconlyBold.plus,
            title: "Savings".tr,
            onTap: controller.onTapSavingOnPressed,
          ),
          _buildIconStatusWidget(
            icon: IconlyBold.notification,
            title: "Remind".tr,
            onTap: controller.onTapRemindPressed,
          ),
          _buildIconStatusWidget(
            icon: IconlyBold.wallet,
            title: "Budget".tr,
            onTap: controller.onTapBudgetPressed,
          ),
        ],
      ),
    );
  }

  Widget _buildIconStatusWidget({
    required Function() onTap,
    required IconData icon,
    required String title,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width * 0.25,
        height: Get.height * 0.05,
        decoration: BoxDecoration(
          color: appTheme.blueA200,
          borderRadius: BorderRadius.circular(16.h),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 6.h),
            title.tr.text
                .textStyle(theme.textTheme.labelMedium)
                .bold
                .white
                .make(),
          ],
        ),
      ),
    );
  }
}
