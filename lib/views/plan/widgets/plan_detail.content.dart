import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/plan/plan_controller.dart';
import 'package:kiwis_flutter/views/plan/widgets/location.card.dart';
import 'package:kiwis_flutter/widgets/base_appbar.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';
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
              .onTap(() => controller.updateAllPlanLocation()),
        ],
      ),
      floatingActionButton: CustomElevatedButton(
        width: Get.width * 0.9,
        text: "Start now",
        onPressed: () => controller.toOnPlan(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                        Container(
                          width: Get.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 23.h, vertical: 23.h),
                          decoration: BoxDecoration(
                            color:
                                theme.colorScheme.onPrimary.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: VStack([
                            HStack([
                              controller.currentPlan.value!.name!.text.bold
                                  .textStyle(theme.textTheme.titleLarge)
                                  .make(),
                              Spacer(),
                              (controller.currentPlan.value!.totalCost!
                                          .toString() +
                                      ' VNĐ')
                                  .text
                                  .bold
                                  .textStyle(theme.textTheme.titleSmall)
                                  .make(),
                            ]),
                            // controller.currentPlan.value!.description!.text.textStyle(theme.textTheme.bodySmall).make(),
                            controller.currentPlan.value!.planLocations!.isEmpty
                                ? "No location"
                                    .tr
                                    .text
                                    .textStyle(theme.textTheme.bodySmall)
                                    .make()
                                : '${controller.currentPlan.value!.planLocations!.length} locations'
                                    .tr
                                    .text
                                    .textStyle(theme.textTheme.bodySmall)
                                    .make(),
                            SizedBox(height: 10),

                            SizedBox(height: 32),
                            HStack([
                              '${DateFormat('dd/MM/yyyy').format(controller.currentPlan.value!.startDate ?? DateTime.now())} - ${DateFormat('dd/MM/yyyy').format(controller.currentPlan.value!.endDate ?? DateTime.now())}'
                                  .text
                                  .textStyle(theme.textTheme.bodySmall)
                                  .make(),
                              Spacer(),
                              'Edit plan'
                                  .tr
                                  .text
                                  .textStyle(theme.textTheme.titleSmall)
                                  .make()
                                  .onTap(() {
                                controller.onTapEditPlan(context);
                              }),
                            ]),
                          ]),
                        ),
                        SizedBox(height: 10),
                        HStack([
                          'Locations'
                              .tr
                              .text
                              .textStyle(theme.textTheme.titleLarge)
                              .bold
                              .make(),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              controller.onPressedChooseLocation(context);
                            },
                            child: 'Add location'
                                .tr
                                .text
                                .textStyle(theme.textTheme.titleSmall)
                                .make(),
                          ),
                        ]),
                        SizedBox(height: 10),
                        Obx(() {
                          if (controller
                              .currentPlan.value!.planLocations!.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgNoData,
                                    width: Get.width * 0.5,
                                    height: Get.width * 0.5,
                                  ),
                                  "No location"
                                      .tr
                                      .text
                                      .bold
                                      .textStyle(theme.textTheme.titleLarge)
                                      .make(),
                                ],
                              ),
                            );
                          }
                          return Expanded(
                            child: ListView.builder(
                              itemCount: controller
                                  .currentPlan.value!.planLocations!.length,
                              itemBuilder: (context, index) {
                                return LocationCard(
                                  index: index,
                                  isLast: index ==
                                      controller.currentPlan.value!
                                              .planLocations!.length -
                                          1,
                                  planLocation: controller
                                      .currentPlan.value!.planLocations![index],
                                ).marginOnly(bottom: 10);
                              },
                            ),
                          );
                        }),
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
