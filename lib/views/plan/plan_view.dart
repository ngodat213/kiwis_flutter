import 'package:flutter/material.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import 'package:kiwis_flutter/widgets/app_bar/custom_app_bar.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

import 'plan_controller.dart';

class PlanView extends BaseView<PlanController> {
  PlanView({super.key});

  /// Section Widget
  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(Get.height * 0.13), // Set desired height
      child: Container(
        padding: EdgeInsets.only(top: 23),
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
            text: "My plan".tr,
            margin: EdgeInsets.only(left: 16.h),
          ),
          actions: [
            AppbarLeadingIconbutton(
              imagePath: ImageConstant.svgPlus,
              onTap: () => controller.onTapCreatePlan(context),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: Get.height,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "In Progress"
              .tr
              .text
              .bold
              .textStyle(theme.textTheme.titleLarge)
              .make()
              .pOnly(bottom: 4),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32.h),
            width: Get.width,
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Đà lạt trip"
                    .tr
                    .text
                    .bold
                    .textStyle(theme.textTheme.titleMedium)
                    .make(),
                SizedBox(height: 8),
                "On location: Bảo Lộc"
                    .tr
                    .text
                    .textStyle(theme.textTheme.bodySmall)
                    .make(),
                SizedBox(height: 16),
                Container(
                  width: Get.width * 0.7,
                  child: Column(
                    children: [
                      LinearProgressIndicator(
                        value: 0.5,
                        color: theme.colorScheme.primary,
                        backgroundColor: theme.colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          '50%'
                              .tr
                              .text
                              .textStyle(theme.textTheme.bodySmall)
                              .make(),
                          'Location: Bảo Lộc'
                              .tr
                              .text
                              .textStyle(theme.textTheme.bodySmall)
                              .make(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
          "My Plans"
              .tr
              .text
              .bold
              .textStyle(theme.textTheme.titleLarge)
              .make()
              .pOnly(bottom: 4),
          Expanded(
            child: ListView.builder(
              itemCount: controller.plans.length,
              itemBuilder: (context, index) {
                final plan = controller.plans[index];
                return Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    onTap: () => controller.onPressedPlanDetail(context, plan),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    leading: Container(
                      width: 3,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    title: plan.name
                        .toString()
                        .text
                        .bold
                        .textStyle(theme.textTheme.titleMedium)
                        .make(),
                    subtitle:
                        '${DateFormat('dd/MM/yyyy').format(plan.startDate ?? DateTime.now())} - ${DateFormat('dd/MM/yyyy').format(plan.endDate ?? DateTime.now())}'
                            .text
                            .textStyle(theme.textTheme.bodySmall)
                            .make(),
                    trailing:
                        'Time remaining ${plan.startDate?.difference(DateTime.now()).inDays} days'
                            .text
                            .textStyle(theme.textTheme.labelSmall)
                            .make(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
