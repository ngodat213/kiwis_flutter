import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/expense/expense_controller.dart';
import 'package:kiwis_flutter/views/expense/widgets/latest_entry_item.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_trainling_iconbutton.dart';

import 'package:velocity_x/velocity_x.dart';

class LatestEntriesListView extends GetView<ExpenseController> {
  const LatestEntriesListView({
    this.height,
    super.key,
  });

  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? Get.height * 0.45,
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
                  onTap: () => controller.onTapEntries(context),
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
