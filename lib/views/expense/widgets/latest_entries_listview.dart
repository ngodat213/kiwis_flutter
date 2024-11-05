import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/expense/expense_controller.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_trainling_iconbutton.dart';

import 'package:velocity_x/velocity_x.dart';

class LatestEntriesListView extends GetView<ExpenseController> {
  const LatestEntriesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.45,
      margin: EdgeInsets.symmetric(horizontal: 32.h),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "Latest Entries"
                    .tr
                    .text
                    .textStyle(theme.textTheme.titleLarge)
                    .bold
                    .white
                    .make(),
                AppbarTrailingIconbutton(
                  onTap: () => controller.onTapEntriesPressed(),
                  imagePath: ImageConstant.svgMore,
                ),
              ],
            ),
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

class LatestEntryItem extends StatelessWidget {
  const LatestEntryItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.5,
            color: theme.colorScheme.onPrimary.withOpacity(0.05),
          ),
        ),
      ),
      child: Row(
        children: [
          AppbarTrailingIconbutton(
            // onTap: () => controller.showModalCalenderSheet(context),
            imagePath: ImageConstant.svgDollar,
          ).marginOnly(right: 8.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Total Salary"
                  .tr
                  .text
                  .textStyle(theme.textTheme.titleLarge)
                  .make(),
              "20 Feb 2024"
                  .tr
                  .text
                  .thin
                  .textStyle(theme.textTheme.titleSmall)
                  .white
                  .make(),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              "+ \$20 + VAT 0.5%"
                  .tr
                  .text
                  .textStyle(theme.textTheme.titleLarge)
                  .make(),
              "Google Pay"
                  .tr
                  .text
                  .thin
                  .textStyle(theme.textTheme.titleSmall)
                  .white
                  .make(),
            ],
          ),
        ],
      ),
    );
  }
}
