import 'package:flutter/material.dart';
import 'package:glossy/glossy.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/models/plan.model.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import 'package:kiwis_flutter/widgets/app_bar/custom_app_bar.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

import 'plan_controller.dart';

class PlanView extends BaseView<PlanController> {
  PlanView({super.key});

  /// Section Widget
  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(Get.height * 0.13),
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
            text:
                controller.argGroupId != null ? "Group plan".tr : "My plan".tr,
            margin: EdgeInsets.only(left: 16.h),
          ),
          actions: [
            AppbarLeadingIconbutton(
              imagePath: ImageConstant.svgPlus,
              onTap: () => controller.showContentCreatePlan(context),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: Get.height - Get.height * 0.13,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            controller: controller.tabController,
            indicatorColor: appTheme.green600,
            labelColor: appTheme.green600,
            dividerColor: Colors.transparent,
            tabs: [
              Tab(text: "In Progress"),
              Tab(text: "My Plans"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                Column(
                  children: controller.plans
                      .where((plan) => plan.isStart == true)
                      .map((plan) => InProgressItem(plan: plan))
                      .toList(),
                ).pOnly(top: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.plans.length,
                    itemBuilder: (context, index) {
                      final plan = controller.plans[index];
                      if (plan.isStart != true) {
                        return _buildPlanItem(context, plan);
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanItem(BuildContext context, PlanModel plan) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          plan.thumbnail?.imageUrl != null
              ? CustomImageView(
                  imagePath: plan.thumbnail?.imageUrl,
                  width: Get.width * 0.13,
                  height: Get.width * 0.13,
                  fit: BoxFit.cover,
                  radius: BorderRadius.circular(10),
                  placeHolder: ImageConstant.imgNoData,
                ).pOnly(right: 16)
              : CustomImageView(
                  imagePath: ImageConstant.imgNoData,
                  width: Get.width * 0.13,
                  height: Get.width * 0.13,
                  fit: BoxFit.cover,
                  radius: BorderRadius.circular(10),
                ).pOnly(right: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              plan.name
                  .toString()
                  .text
                  .bold
                  .textStyle(theme.textTheme.titleMedium)
                  .make(),
              '${DateFormat('dd/MM/yyyy').format(plan.startDate ?? DateTime.now())} - ${DateFormat('dd/MM/yyyy').format(plan.endDate ?? DateTime.now())}'
                  .text
                  .textStyle(theme.textTheme.bodySmall)
                  .make(),
              plan.startDate!.difference(DateTime.now()).inDays >= 0
                  ? 'Time remaining ${plan.startDate?.difference(DateTime.now()).inDays} days'
                      .text
                      .textStyle(theme.textTheme.labelSmall)
                      .make()
                  : 'In progress'
                      .tr
                      .text
                      .textStyle(theme.textTheme.labelSmall)
                      .make(),
            ],
          ),
        ],
      ).p(16),
    ).marginOnly(bottom: 8).onTap(
          () => controller.showContentPlanDetail(context, plan),
        );
  }
}

class InProgressItem extends GetView<PlanController> {
  const InProgressItem({
    super.key,
    required this.plan,
  });

  final PlanModel plan;

  @override
  Widget build(BuildContext context) {
    return GlossyContainer(
      width: Get.width,
      height: Get.height * 0.18,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32.h),
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            plan.name
                .toString()
                .text
                .bold
                .textStyle(theme.textTheme.titleMedium)
                .make(),
            SizedBox(height: 8),
            "Task: ${plan.tasks?.length}"
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
                      '50%'.tr.text.textStyle(theme.textTheme.bodySmall).make(),
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
    ).onTap(() => controller.showContentPlanDetail(context, plan));
  }
}
