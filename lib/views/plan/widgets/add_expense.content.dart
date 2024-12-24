import 'package:flutter/material.dart';
import 'package:glossy/glossy.dart';
import 'package:kiwis_flutter/core/constants/app.button_style.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/plan/plan_controller.dart';
import 'package:kiwis_flutter/widgets/base_appbar.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';
import 'package:kiwis_flutter/widgets/custom_text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';

class AddExpenseContent extends GetView<PlanController> {
  AddExpenseContent({
    super.key,
    this.expenseId,
  });
  final String? expenseId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseAppBar(
        context: context,
        title: "Add Expense".tr,
        actions: [
          "Save"
              .tr
              .text
              .textStyle(theme.textTheme.titleSmall)
              .make()
              .onTap(() => controller.handleCreateExpense()),
        ],
      ),
      body: Obx(() {
        return SizedBox(
          width: double.maxFinite,
          child: Container(
            height: Get.height,
            child: Stack(
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
                      width: Get.width,
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 32),
                          "Title *"
                              .tr
                              .text
                              .bold
                              .textStyle(theme.textTheme.titleMedium)
                              .make(),
                          SizedBox(height: 4),
                          CustomTextFormField(
                            height: Get.height * 0.06,
                            hintText: "Enter your title".tr,
                            controller: controller.taskTitleTEC,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 23.h, vertical: 12.h),
                          ),
                          SizedBox(height: 16),
                          "Description"
                              .tr
                              .text
                              .bold
                              .textStyle(theme.textTheme.titleMedium)
                              .make(),
                          SizedBox(height: 4),
                          CustomTextFormField(
                            height: Get.height * 0.06,
                            hintText: "Enter your description".tr,
                            maxLines: 5,
                            controller: controller.taskDescriptionTEC,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 23.h, vertical: 12.h),
                          ),
                          SizedBox(height: 16),
                          "Amount *"
                              .tr
                              .text
                              .bold
                              .textStyle(theme.textTheme.titleMedium)
                              .make(),
                          SizedBox(height: 4),
                          CustomTextFormField(
                            height: Get.height * 0.06,
                            hintText: "Enter your amount".tr,
                            controller: controller.taskBudgetTEC,
                            textInputType: TextInputType.number,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 23.h, vertical: 12.h),
                          ),
                          SizedBox(height: 16),
                          if (controller.currentPlan.value?.groupId != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    "Select user"
                                        .tr
                                        .text
                                        .textStyle(theme.textTheme.titleMedium)
                                        .bold
                                        .make(),
                                    'Add'
                                        .tr
                                        .text
                                        .textStyle(theme.textTheme.titleMedium)
                                        .bold
                                        .make()
                                        .onTap(
                                          () => controller.showDialog(
                                            Dialog(
                                              insetPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 24),
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: GlossyContainer(
                                                width: Get.width + 32,
                                                height: Get.height * 0.5,
                                                borderRadius:
                                                    BorderRadius.circular(36),
                                                child: Column(
                                                  children: [
                                                    SelectUserShareCostWidget(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                  ],
                                ),
                                'Default all members *'
                                    .tr
                                    .text
                                    .thin
                                    .textStyle(theme.textTheme.bodySmall)
                                    .make(),
                              ],
                            ),
                          SizedBox(height: 16),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Obx(
                              () => Row(
                                children:
                                    controller.selectedShareCosts.map((friend) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 52.h,
                                          width: 52.h,
                                          child: CustomImageView(
                                            imagePath:
                                                friend.user?.avatar?.imageUrl ??
                                                    AppValues.defaultAvatar,
                                            height: 47.h,
                                            width: 47.h,
                                            radius: BorderRadius.circular(100),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        friend.user!.fullName.text
                                            .maxLines(1)
                                            .ellipsis
                                            .textStyle(
                                              theme.textTheme.titleSmall!
                                                  .copyWith(
                                                color: theme
                                                    .colorScheme.onPrimary
                                                    .withOpacity(1),
                                              ),
                                            )
                                            .make()
                                            .w(52.h),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class SelectUserShareCostWidget extends GetView<PlanController> {
  const SelectUserShareCostWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.5,
      child: Column(
        children: [
          SizedBox(height: 16),
          "Select user"
              .tr
              .text
              .textStyle(theme.textTheme.titleLarge)
              .bold
              .make(),
          SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: controller.userPlans.length,
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final friend = controller.userPlans[index];
                return ListTile(
                  onTap: () {
                    controller.onPressedAddRomveFriend(friend);
                  },
                  leading: CustomImageView(
                    imagePath: friend.user?.avatar?.imageUrl ??
                        AppValues.defaultAvatar,
                    height: 47.h,
                    width: 47.h,
                    radius: BorderRadius.circular(100),
                    fit: BoxFit.cover,
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      friend.user!.fullName.text
                          .textStyle(
                            theme.textTheme.titleSmall!.copyWith(
                              color: theme.colorScheme.onPrimary.withOpacity(1),
                            ),
                          )
                          .make(),
                    ],
                  ),
                  trailing: Obx(
                    () => controller.selectedShareCosts.contains(friend)
                        ? CustomImageView(
                            imagePath: ImageConstant.svgCheckCircle,
                            height: 24.h,
                            width: 24.h,
                          )
                        : CustomImageView(
                            imagePath: ImageConstant.svgCircle,
                            height: 24.h,
                            width: 24.h,
                          ),
                  ),
                );
              },
            ),
          ),
          CustomElevatedButton(
            text: "Confirm",
            buttonStyle: CustomButtonStyles.fillGreen,
            onPressed: () => {
              Get.back(),
            },
          ).paddingAll(16),
        ],
      ),
    );
  }
}