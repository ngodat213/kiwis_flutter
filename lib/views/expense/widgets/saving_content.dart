import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/expense/expense_controller.dart';
import 'package:kiwis_flutter/views/expense/widgets/latest_entries_listview.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import 'package:kiwis_flutter/widgets/app_bar/custom_app_bar.dart';

import 'package:velocity_x/velocity_x.dart';

class SavingContent extends BaseView<ExpenseController> {
  SavingContent({super.key});

  /// Section Widget
  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(Get.height * 0.09 + 23),
      child: Container(
        padding: EdgeInsets.only(top: 23),
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
            text: "Add".tr,
            margin: EdgeInsets.only(left: 16.h),
          ),
        ),
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 32),
      height: Get.height,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  IconlyLight.plus,
                  color: Colors.white,
                ),
              ).paddingOnly(left: 32, right: 16),
              GestureDetector(
                onTap: () => controller.onTapAddIncome(context),
                child: Container(
                  height: Get.height * 0.1,
                  padding: EdgeInsets.symmetric(horizontal: 23),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        IconlyLight.wallet,
                        color: Colors.white,
                      ).paddingOnly(bottom: 8),
                      "Add Income"
                          .tr
                          .text
                          .textStyle(theme.textTheme.displayLarge)
                          .center
                          .white
                          .make(),
                    ],
                  ),
                ).paddingOnly(right: 16),
              ),
              GestureDetector(
                onTap: () => controller.onTapAddIncome(context),
                child: Container(
                  height: Get.height * 0.1,
                  padding: EdgeInsets.symmetric(horizontal: 23),
                  decoration: BoxDecoration(
                    color: appTheme.blue500,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        IconlyLight.wallet,
                        color: Colors.white,
                      ).paddingOnly(bottom: 8),
                      "Add Expense"
                          .tr
                          .text
                          .textStyle(theme.textTheme.displayLarge)
                          .center
                          .white
                          .make(),
                    ],
                  ),
                ),
              ),
            ],
          ).paddingOnly(bottom: 32),
          LatestEntriesListView(
            height: Get.height * 0.7,
          )
        ],
      ),
    );
  }
}
