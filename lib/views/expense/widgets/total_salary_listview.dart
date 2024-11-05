import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';

import 'package:kiwis_flutter/views/expense/expense_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class TotalSalaryListView extends GetView<ExpenseController> {
  const TotalSalaryListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  width: Get.width * 0.7,
                  height: Get.height * 0.15,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: appTheme.green600,
                    borderRadius: BorderRadius.circular(16.h),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(IconlyBold.wallet, color: Colors.white),
                      "Total Salary"
                          .tr
                          .text
                          .textStyle(theme.textTheme.titleLarge)
                          .make(),
                      Spacer(),
                      "\$ 100,000"
                          .text
                          .lg
                          .bold
                          .textStyle(
                            theme.textTheme.displayLarge!.copyWith(
                              color: Colors.white,
                            ),
                          )
                          .make(),
                    ],
                  ),
                ).paddingOnly(left: 32.h),
                Container(
                  width: Get.width * 0.3,
                  height: Get.height * 0.15,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: appTheme.green600,
                    borderRadius: BorderRadius.circular(16.h),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(IconlyBold.wallet, color: Colors.white),
                      "Total Expense"
                          .tr
                          .text
                          .textStyle(theme.textTheme.titleLarge)
                          .make(),
                      Spacer(),
                      "\$ 100,000"
                          .text
                          .lg
                          .bold
                          .textStyle(
                            theme.textTheme.displayLarge!.copyWith(
                              color: Colors.white,
                            ),
                          )
                          .make(),
                    ],
                  ),
                ).paddingOnly(left: 8.h),
                Container(
                  width: Get.width * 0.3,
                  height: Get.height * 0.15,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: appTheme.green600,
                    borderRadius: BorderRadius.circular(16.h),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(IconlyBold.wallet, color: Colors.white),
                      "Total Monthly"
                          .tr
                          .text
                          .textStyle(theme.textTheme.titleLarge)
                          .make(),
                      Spacer(),
                      "\$ 100,000"
                          .text
                          .lg
                          .bold
                          .textStyle(
                            theme.textTheme.displayLarge!.copyWith(
                              color: Colors.white,
                            ),
                          )
                          .make(),
                    ],
                  ),
                ).paddingOnly(left: 8.h, right: 32.h)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
