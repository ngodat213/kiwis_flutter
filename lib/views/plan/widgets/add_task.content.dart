import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/plan/plan_controller.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_trainling_iconbutton.dart';
import 'package:kiwis_flutter/widgets/base_appbar.dart';
import 'package:kiwis_flutter/widgets/custom_text_form_field.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'package:velocity_x/velocity_x.dart';

class AddTaskContent extends GetView<PlanController> {
  const AddTaskContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseAppBar(
        context: context,
        title: "Add Task".tr,
        actions: [
          "Save"
              .tr
              .text
              .textStyle(theme.textTheme.titleSmall)
              .make()
              .onTap(() {}),
        ],
      ),
      body: SizedBox(
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
                          controller: controller.titleTEC,
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
                          controller: controller.descriptionTEC,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 23.h, vertical: 12.h),
                        ),
                        SizedBox(height: 16),
                        "Budget"
                            .tr
                            .text
                            .bold
                            .textStyle(theme.textTheme.titleMedium)
                            .make(),
                        SizedBox(height: 4),
                        CustomTextFormField(
                          height: Get.height * 0.06,
                          hintText: "Enter your budget".tr,
                          controller: controller.budgetTEC,
                          textInputType: TextInputType.number,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 23.h, vertical: 12.h),
                        ),
                        SizedBox(height: 16),
                        "Date *"
                            .tr
                            .text
                            .bold
                            .textStyle(theme.textTheme.titleMedium)
                            .make(),
                        SizedBox(height: 4),
                        TimePickerSpinnerPopUp(
                          mode: CupertinoDatePickerMode.date,
                          initTime: DateTime.now(),
                          minTime:
                              DateTime.now().subtract(const Duration(days: 10)),
                          maxTime: DateTime.now().add(const Duration(days: 10)),
                          barrierColor: Colors.black12,
                          minuteInterval: 1,
                          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                          cancelText: 'Cancel',
                          confirmText: 'OK',
                          pressType: PressType.singlePress,
                          timeWidgetBuilder: (dataTime) {
                            return Container(
                              width: Get.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 23.h, vertical: 12.h),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.onPrimary
                                    .withOpacity(0.05),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DateFormat('dd / MM / yyyy')
                                      .format(dataTime)
                                      .text
                                      .textStyle(theme.textTheme.bodySmall)
                                      .make(),
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    color: theme.colorScheme.onPrimary
                                        .withOpacity(0.5),
                                  ),
                                ],
                              ),
                            );
                          },
                          timeFormat: 'dd/MM/yyyy',
                          onChange: (dateTime) {},
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Start time *"
                                    .tr
                                    .text
                                    .bold
                                    .textStyle(theme.textTheme.titleMedium)
                                    .make(),
                                SizedBox(height: 4),
                                TimePickerSpinnerPopUp(
                                  mode: CupertinoDatePickerMode.time,
                                  initTime: DateTime.now(),
                                  minTime: DateTime.now()
                                      .subtract(const Duration(days: 10)),
                                  maxTime: DateTime.now()
                                      .add(const Duration(days: 10)),
                                  barrierColor: Colors.black12,
                                  minuteInterval: 1,
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 10, 12, 10),
                                  cancelText: 'Cancel',
                                  confirmText: 'OK',
                                  pressType: PressType.singlePress,
                                  timeWidgetBuilder: (dataTime) {
                                    return Container(
                                      width: Get.width * 0.4,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 23.h, vertical: 12.h),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.onPrimary
                                            .withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          DateFormat('HH : mm')
                                              .format(dataTime)
                                              .text
                                              .textStyle(
                                                  theme.textTheme.bodySmall)
                                              .make(),
                                          Icon(
                                            Icons.schedule_outlined,
                                            color: theme.colorScheme.onPrimary
                                                .withOpacity(0.5),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  timeFormat: 'HH:mm',
                                  onChange: (dateTime) {},
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "End time *"
                                    .tr
                                    .text
                                    .bold
                                    .textStyle(theme.textTheme.titleMedium)
                                    .make(),
                                SizedBox(height: 4),
                                TimePickerSpinnerPopUp(
                                  mode: CupertinoDatePickerMode.time,
                                  initTime: DateTime.now(),
                                  minTime: DateTime.now()
                                      .subtract(const Duration(days: 10)),
                                  maxTime: DateTime.now()
                                      .add(const Duration(days: 10)),
                                  barrierColor: Colors.black12,
                                  minuteInterval: 1,
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 10, 12, 10),
                                  cancelText: 'Cancel',
                                  confirmText: 'OK',
                                  pressType: PressType.singlePress,
                                  timeWidgetBuilder: (dataTime) {
                                    return Container(
                                      width: Get.width * 0.4,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 23.h, vertical: 12.h),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.onPrimary
                                            .withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          DateFormat('HH : mm')
                                              .format(dataTime)
                                              .text
                                              .textStyle(
                                                  theme.textTheme.bodySmall)
                                              .make(),
                                          Icon(
                                            Icons.schedule_outlined,
                                            color: theme.colorScheme.onPrimary
                                                .withOpacity(0.5),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  timeFormat: 'HH:mm',
                                  onChange: (dateTime) {},
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        "Location"
                            .tr
                            .text
                            .bold
                            .textStyle(theme.textTheme.titleMedium)
                            .make(),
                        SizedBox(height: 4),
                        Container(
                          width: Get.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 23.h, vertical: 12.h),
                          decoration: BoxDecoration(
                            color:
                                theme.colorScheme.onPrimary.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "Choose your location"
                                  .tr
                                  .text
                                  .textStyle(theme.textTheme.bodySmall)
                                  .make(),
                              Icon(Icons.location_on_outlined,
                                  color: theme.colorScheme.onPrimary
                                      .withOpacity(0.5)),
                            ],
                          ),
                        )
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
