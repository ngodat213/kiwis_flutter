import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:kiwis_flutter/core/app_export.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_trainling_iconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/custom_app_bar.dart';
import 'package:velocity_x/velocity_x.dart';

import 'expense_controller.dart';

class ExpenseScreen extends BaseView<ExpenseController> {
  @override
  bool get isNavigationBar => true;

  ExpenseScreen({super.key});
  @override
  Widget body(BuildContext context) {
    return Container(
      height: Get.height,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: _buildHeaderSection(),
          ),
          Container(
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        width: Get.width * 0.7,
                        height: Get.height * 0.15,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.h, vertical: 16.h),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.h, vertical: 16.h),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.h, vertical: 16.h),
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
                      ).paddingOnly(left: 8.h)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildHeaderSection() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 16.0, vertical: 16), // Adjust padding as needed
      child: CustomAppBar(
        title: AppbarTitle(
          text: "Expense".tr,
          margin: EdgeInsets.only(left: 16.h),
        ),
        actions: [
          AppbarTrailingIconbutton(
            // onTap: () => controller.showModalCalenderSheet(context),
            imagePath: ImageConstant.svgCalander,
            margin: EdgeInsets.only(right: 8.h),
          ),
          AppbarTrailingIconbutton(
            // onTap: () => controller.showModalSettingChatRoomSheet(context),
            imagePath: ImageConstant.svgMore,
            margin: EdgeInsets.only(right: 8.h),
          ),
        ],
      ),
    );
  }
}
