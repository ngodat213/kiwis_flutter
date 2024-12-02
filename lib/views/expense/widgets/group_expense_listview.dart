import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';

import 'package:kiwis_flutter/views/expense/expense_controller.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_trainling_iconbutton.dart';
import 'package:velocity_x/velocity_x.dart';

class GroupExpenseListView extends StatelessWidget {
  const GroupExpenseListView({
    super.key,
    required this.controller,
  });

  final ExpenseController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16.h, left: 32.h, right: 32.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "Group & User"
                    .tr
                    .text
                    .textStyle(theme.textTheme.titleLarge)
                    .bold
                    .white
                    .make(),
                AppbarTrailingIconbutton(
                  // onTap: () => controller.showModalCalenderSheet(context),
                  imagePath: ImageConstant.svgMore,
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GroupExpenseItem().marginOnly(left: 24.h),
                GroupExpenseItem(),
                GroupExpenseItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GroupExpenseItem extends StatelessWidget {
  const GroupExpenseItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.5,
      height: Get.height * 0.12,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 8.h,
      ),
      margin: EdgeInsets.only(left: 8.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(16.h),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgAvatar,
                width: 24.h,
                height: 24.h,
              ).paddingOnly(right: 8.h),
              "DMT".tr.text.bold.textStyle(theme.textTheme.titleLarge).make(),
            ],
          ),
          Spacer(),
          Row(
            children: [
              "Total: "
                  .tr
                  .text
                  .bold
                  .textStyle(theme.textTheme.titleLarge)
                  .make(),
              "\$ 100.000"
                  .tr
                  .text
                  .bold
                  .white
                  .textStyle(theme.textTheme.displaySmall)
                  .make(),
            ],
          ),
          Spacer(),
          Row(
            children: [
              "Pending: "
                  .tr
                  .text
                  .bold
                  .textStyle(theme.textTheme.titleSmall)
                  .make(),
              "\$ 111.111"
                  .tr
                  .text
                  .bold
                  .white
                  .textStyle(theme.textTheme.displaySmall)
                  .make(),
            ],
          ),
        ],
      ),
    );
  }
}
