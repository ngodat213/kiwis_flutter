import 'package:flutter/material.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/expense/expense_controller.dart';
import 'package:kiwis_flutter/views/expense/widgets/latest_entry_item.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_trainling_iconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/custom_app_bar.dart';

import 'package:velocity_x/velocity_x.dart';

class EntriesView extends BaseView<ExpenseController> {
  EntriesView({super.key});

  /// Section Widget
  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(Get.height * 0.09), // Set desired height
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 16), // Adjust padding as needed
        child: CustomAppBar(
          leadingWidth: 44.h,
          leading: AppbarLeadingIconbutton(
            imagePath: ImageConstant.imgArrowLeftOnprimary,
            onTap: () {
              Get.back();
            },
          ),
          title: AppbarTitle(
            text: "Entries".tr,
            margin: EdgeInsets.only(left: 16.h),
          ),
          actions: [
            AppbarTrailingIconbutton(
              imagePath: ImageConstant.svgPlus,
              margin: EdgeInsets.only(right: 8.h),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      height: Get.height,
      margin: EdgeInsets.symmetric(horizontal: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16.h),
            child: "Latest Entries"
                .tr
                .text
                .textStyle(theme.textTheme.titleLarge)
                .bold
                .white
                .make(),
          ),
          Expanded(
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) => LatestEntryItem().paddingOnly(
                bottom: 8.h,
              ),
            ),
          )
        ],
      ),
    );
  }
}
