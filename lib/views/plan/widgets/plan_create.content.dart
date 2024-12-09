import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/models/plan.model.dart';
import 'package:kiwis_flutter/views/plan/plan_controller.dart';
import 'package:kiwis_flutter/widgets/base_appbar.dart';
import 'package:kiwis_flutter/widgets/calendar_table.dart';
import 'package:kiwis_flutter/widgets/custom_text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';

class PlanCreateContent extends GetView<PlanController> {
  const PlanCreateContent({
    super.key,
    this.isEdit = false,
    this.plan,
  });
  final bool isEdit;
  final PlanModel? plan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseAppBar(
        context: context,
        title: isEdit == true ? "Edit plan".tr : "Create plan".tr,
        actions: [
          "Save"
              .tr
              .text
              .textStyle(theme.textTheme.titleSmall)
              .bold
              .make()
              .onTap(() {
            if (isEdit) {
              controller.editPlan(context);
            } else {
              controller.createPlan(context);
            }
          }),
        ],
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: Container(
          height: Get.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgEllipse2005,
                height: 280.h,
                width: 274.h,
                alignment: Alignment.topRight,
              ),
              CustomImageView(
                imagePath: ImageConstant.imgEllipse2006Green600516x342,
                height: 340.h,
                width: 240.h,
                alignment: Alignment.bottomLeft,
              ),
              SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Select Date"
                            .tr
                            .text
                            .bold
                            .textStyle(theme.textTheme.titleLarge)
                            .make()
                            .pOnly(bottom: 4),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: theme.colorScheme.onPrimary,
                          ),
                          child: CustomTableCalendar(
                            firstDay: DateTime.now(),
                            lastDay: DateTime.now().add(Duration(days: 365)),
                            focusedDay: controller.focusedDay,
                            startDay: controller.startDay,
                            endDay: controller.endDay,
                          ),
                        ),
                        SizedBox(height: 16),
                        "Plan Title"
                            .tr
                            .text
                            .bold
                            .textStyle(theme.textTheme.titleLarge)
                            .make()
                            .pOnly(bottom: 4),
                        CustomTextFormField(
                          hintText: "Group name",
                          height: 56 + 16,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 23.h, vertical: 23.h),
                          boxDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.h),
                          ),
                          controller: controller.titleTEC,
                        ).marginOnly(bottom: 16),
                        SizedBox(height: 16),
                        "Plan Description"
                            .tr
                            .text
                            .bold
                            .textStyle(theme.textTheme.titleLarge)
                            .make()
                            .pOnly(bottom: 4),
                        CustomTextFormField(
                          controller: controller.descriptionTEC,
                          hintText: "Plan Description",
                          height: 32,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 23.h, vertical: 12.h),
                          boxDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.h),
                          ),
                          maxLines: 4,
                        ),
                        SizedBox(height: 16),
                        "Budget"
                            .tr
                            .text
                            .bold
                            .textStyle(theme.textTheme.titleLarge)
                            .make()
                            .pOnly(bottom: 4),
                        CustomTextFormField(
                          controller: controller.budgetTEC,
                          textInputType: TextInputType.number,
                          hintText: "Budget",
                          height: 64,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 23.h, vertical: 23.h),
                          boxDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.h),
                          ),
                        ),
                        SizedBox(height: 150),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
