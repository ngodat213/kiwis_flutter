import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/plan/plan_controller.dart';
import 'package:kiwis_flutter/widgets/base_appbar.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';
import 'package:kiwis_flutter/widgets/custom_text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';

class PlanDetailContent extends GetView<PlanController> {
  const PlanDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseAppBar(
        context: context,
        title: "Plan detail".tr,
        actions: [
          "Save"
              .tr
              .text
              .textStyle(theme.textTheme.titleSmall)
              .bold
              .make()
              .onTap(() {
            controller.createPlan(context);
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
                    height: Get.height,
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Title"
                            .tr
                            .text
                            .bold
                            .textStyle(theme.textTheme.titleLarge)
                            .make()
                            .pOnly(bottom: 8),
                        CustomTextFormField(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 23.h, vertical: 23.h),
                          controller: controller.titleTEC,
                          hintText: controller.currentPlan.value!.name,
                        ),
                        SizedBox(height: 10),
                        "Description"
                            .tr
                            .text
                            .bold
                            .textStyle(theme.textTheme.titleLarge)
                            .make()
                            .pOnly(bottom: 8),
                        CustomTextFormField(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 23.h, vertical: 23.h),
                          controller: controller.descriptionTEC,
                          hintText: "Description",
                        ),
                        SizedBox(height: 10),
                        "Budget"
                            .tr
                            .text
                            .bold
                            .textStyle(theme.textTheme.titleLarge)
                            .make()
                            .pOnly(bottom: 8),
                        CustomTextFormField(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 23.h, vertical: 23.h),
                          controller: controller.budgetTEC,
                          hintText: controller.currentPlan.value!.totalCost
                              .toString(),
                        ),
                        SizedBox(height: 10),
                        // ListView.builder(
                        //   itemCount: controller
                        //       .currentPlan.value!.planLocations!.length,
                        //   itemBuilder: (context, index) {
                        //     return;
                        //   },
                        // ),
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
