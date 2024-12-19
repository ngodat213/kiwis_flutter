import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/models/plan.model.dart';
import 'package:kiwis_flutter/views/plan/plan_controller.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import 'package:kiwis_flutter/widgets/app_bar/custom_app_bar.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';
import 'package:kiwis_flutter/widgets/custom_icon_button.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../widgets/custom_text_form_field.dart';

class PlanCreateContent extends BaseView<PlanController> {
  PlanCreateContent({
    super.key,
    this.isEdit = false,
    this.plan,
  });
  final bool isEdit;
  final PlanModel? plan;

  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(Get.height * 0.13),
      child: Container(
        padding: EdgeInsets.only(top: 23),
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        color: Colors.transparent,
        child: CustomAppBar(
          leadingWidth: 44.h,
          leading: AppbarLeadingIconbutton(
            imagePath: ImageConstant.imgArrowLeftOnprimary,
            onTap: () {
              Get.back();
            },
          ),
          title: AppbarTitle(
            text: isEdit == true ? "Edit plan".tr : "Create plan".tr,
            margin: EdgeInsets.only(left: 16.h),
          ),
          actions: [
            "Add"
                .tr
                .text
                .bold
                .textStyle(theme.textTheme.titleSmall)
                .make()
                .onTap(() => controller.onPressedAddTask(context)),
          ],
        ),
      ),
    );
  }

  Widget? floatingActionButton(BuildContext context) {
    return CustomElevatedButton(
      text: controller.currentStep.value == 2 ? "Next" : "Done",
      buttonTextStyle: theme.textTheme.titleSmall!.copyWith(
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        color: appTheme.green600,
        borderRadius: BorderRadius.circular(10),
      ),
      width: Get.width * 0.9,
      onPressed: () {
        controller.currentStep.value++;
      },
    ).marginSymmetric(horizontal: 32, vertical: 16);
  }

  @override
  Widget body(BuildContext context) {
    return SizedBox(
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
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomStepper(),
                        controller.steps[controller.currentStep.value],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleWidget extends GetView<PlanController> {
  const ScheduleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: Column(
        children: [
          DatePicker(
            DateTime.now(),
            height: 90,
            width: 70,
            initialSelectedDate: DateTime.now(),
            selectionColor: appTheme.green600.withOpacity(0.7),
            selectedTextColor: Colors.white,
            dateTextStyle: theme.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
            dayTextStyle: theme.textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w400,
            ),
            monthTextStyle: theme.textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return index != 5
                    ? SizedBox(
                        width: Get.width,
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 8),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.onPrimary
                                    .withOpacity(.05),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(Icons.access_time),
                                title: Text("Day $index"),
                                subtitle: Text("10:00 - 12:00"),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(height: 64);
              },
            ),
          )
        ],
      ),
    );
  }
}

class DetailWidget extends GetView<PlanController> {
  const DetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () {
            return Container(
              width: Get.width * 0.9,
              height: 200,
              decoration: BoxDecoration(
                color: appTheme.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: controller.imageFile.value == null
                  ? Center(
                      child: CustomIconButton(
                        height: 48.h,
                        width: 48.h,
                        padding: EdgeInsets.all(12.h),
                        decoration: IconButtonStyleHelper.fillOnPrimaryTL241,
                        child: CustomImageView(
                          imagePath: ImageConstant.svgImage,
                        ),
                      ),
                    )
                  : CustomImageView(
                      imageBytes: controller.imageFile.value!.readAsBytesSync(),
                      width: Get.width * 0.9,
                      height: 200,
                      fit: BoxFit.cover,
                      radius: BorderRadius.circular(10),
                      imageType: ImageType.file,
                    ),
            ).onTap(() {
              controller.pickImage();
            });
          },
        ),
        SizedBox(height: 32),
        "Title".tr.text.bold.textStyle(theme.textTheme.titleMedium).make(),
        SizedBox(height: 4),
        CustomTextFormField(
          height: Get.height * 0.06,
          hintText: "Title".tr,
          controller: controller.titleTEC,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 23.h, vertical: 12.h),
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
          hintText: "Description".tr,
          maxLines: 5,
          controller: controller.descriptionTEC,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 23.h, vertical: 12.h),
        ),
        SizedBox(height: 16),
        "Budget".tr.text.bold.textStyle(theme.textTheme.titleMedium).make(),
        SizedBox(height: 4),
        CustomTextFormField(
          height: Get.height * 0.06,
          hintText: "Budget".tr,
          controller: controller.budgetTEC,
          textInputType: TextInputType.number,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 23.h, vertical: 12.h),
        ),
      ],
    );
  }
}

class TimeWidget extends GetView<PlanController> {
  const TimeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Container(
            width: Get.width,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Start date"
                        .tr
                        .text
                        .bold
                        .textStyle(theme.textTheme.titleMedium)
                        .make()
                        .pOnly(bottom: 8),
                    TimePickerSpinnerPopUp(
                      mode: CupertinoDatePickerMode.date,
                      initTime: DateTime.now().add(const Duration(hours: 1)),
                      minTime: DateTime.now(),
                      barrierColor: Colors.black12,
                      minuteInterval: 1,
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                      cancelText: 'Cancel',
                      confirmText: 'OK',
                      pressType: PressType.singlePress,
                      timeWidgetBuilder: (dataTime) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.onPrimary
                                    .withOpacity(0.05),
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(
                                  color: appTheme.black.withOpacity(0.1),
                                  width: 2,
                                ),
                              ),
                              child: DateFormat('dd / MM / yyyy')
                                  .format(dataTime)
                                  .text
                                  .textStyle(theme.textTheme.titleMedium)
                                  .bold
                                  .make(),
                            ),
                          ],
                        );
                      },
                      timeFormat: 'dd/MM/yyyy',
                      onChange: (dateTime) {
                        controller.startDay.value = DateTime(
                          dateTime.year,
                          dateTime.month,
                          dateTime.day,
                        );
                      },
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Start time"
                        .tr
                        .text
                        .bold
                        .textStyle(theme.textTheme.titleMedium)
                        .make()
                        .pOnly(bottom: 8),
                    TimePickerSpinnerPopUp(
                      mode: CupertinoDatePickerMode.time,
                      initTime: DateTime.now(),
                      barrierColor: Colors.black12,
                      minuteInterval: 1,
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                      cancelText: 'Cancel',
                      confirmText: 'OK',
                      pressType: PressType.singlePress,
                      timeWidgetBuilder: (dataTime) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.onPrimary
                                    .withOpacity(0.05),
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(
                                  color: appTheme.black.withOpacity(0.1),
                                  width: 2,
                                ),
                              ),
                              child: DateFormat('HH : mm')
                                  .format(dataTime)
                                  .text
                                  .textStyle(theme.textTheme.titleMedium)
                                  .bold
                                  .make(),
                            ),
                          ],
                        );
                      },
                      timeFormat: 'HH:mm',
                      onChange: (dateTime) {
                        controller.startDay.value = DateTime(
                          controller.startDay.value.year,
                          controller.startDay.value.month,
                          controller.startDay.value.day,
                          dateTime.hour,
                          dateTime.minute,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          DottedLine(
            direction: Axis.horizontal,
            lineThickness: 1,
            dashLength: 4,
            dashGapLength: 2,
            dashColor: appTheme.black.withOpacity(0.1),
          ),
          SizedBox(height: 10),
          Container(
            width: Get.width,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "End date"
                        .tr
                        .text
                        .bold
                        .textStyle(theme.textTheme.titleMedium)
                        .make()
                        .pOnly(bottom: 8),
                    TimePickerSpinnerPopUp(
                      mode: CupertinoDatePickerMode.date,
                      initTime: controller.startDay.value
                          .add(const Duration(hours: 1)),
                      minTime: controller.startDay.value,
                      barrierColor: Colors.black12,
                      minuteInterval: 1,
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                      cancelText: 'Cancel',
                      confirmText: 'OK',
                      pressType: PressType.singlePress,
                      timeWidgetBuilder: (dataTime) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.onPrimary
                                    .withOpacity(0.05),
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(
                                  color: appTheme.black.withOpacity(0.1),
                                  width: 2,
                                ),
                              ),
                              child: DateFormat('dd / MM / yyyy')
                                  .format(dataTime)
                                  .text
                                  .textStyle(theme.textTheme.titleMedium)
                                  .bold
                                  .make(),
                            ),
                          ],
                        );
                      },
                      timeFormat: 'dd/MM/yyyy',
                      onChange: (dateTime) {
                        controller.endDay.value = DateTime(
                          dateTime.year,
                          dateTime.month,
                          dateTime.day,
                        );
                      },
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "End time"
                        .tr
                        .text
                        .bold
                        .textStyle(theme.textTheme.titleMedium)
                        .make()
                        .pOnly(bottom: 8),
                    TimePickerSpinnerPopUp(
                      mode: CupertinoDatePickerMode.time,
                      initTime: DateTime.now(),
                      minTime: controller.startDay.value,
                      barrierColor: Colors.black12,
                      minuteInterval: 1,
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                      cancelText: 'Cancel',
                      confirmText: 'OK',
                      pressType: PressType.singlePress,
                      timeWidgetBuilder: (dataTime) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.onPrimary
                                    .withOpacity(0.05),
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(
                                  color: appTheme.black.withOpacity(0.1),
                                  width: 2,
                                ),
                              ),
                              child: DateFormat('HH : mm')
                                  .format(dataTime)
                                  .text
                                  .textStyle(theme.textTheme.titleMedium)
                                  .bold
                                  .make(),
                            ),
                          ],
                        );
                      },
                      timeFormat: 'HH:mm',
                      onChange: (dateTime) {
                        controller.endDay.value = DateTime(
                          controller.endDay.value.year,
                          controller.endDay.value.month,
                          controller.endDay.value.day,
                          dateTime.hour,
                          dateTime.minute,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomStepper extends GetView<PlanController> {
  const CustomStepper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => EasyStepper(
        activeStep: controller.currentStep.value,
        lineStyle: LineStyle(
          lineLength: 50,
          activeLineColor: appTheme.blue500,
          finishedLineColor: appTheme.green600.withOpacity(0.5),
          defaultLineColor: appTheme.black.withOpacity(0.5),
          lineSpace: 0.5,
          lineWidth: 5,
          unreachedLineType: LineType.dashed,
        ),
        stepRadius: 18,
        activeStepIconColor: appTheme.black,
        borderThickness: 0,
        showLoadingAnimation: false,
        steps: [
          EasyStep(
            customStep: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: controller.currentStep.value >= 0
                    ? appTheme.green600
                    : theme.colorScheme.onPrimary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(child: Text("1")),
            ),
            customTitle: const Text(
              'Time',
              textAlign: TextAlign.center,
            ),
          ),
          EasyStep(
            customStep: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: controller.currentStep.value >= 1
                    ? appTheme.green600
                    : appTheme.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(child: Text("2")),
            ),
            customTitle: const Text(
              'Details',
              textAlign: TextAlign.center,
            ),
          ),
          EasyStep(
            customStep: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: controller.currentStep.value >= 2
                    ? appTheme.green600
                    : theme.colorScheme.onPrimary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(child: Text("3")),
            ),
            customTitle: const Text(
              'Enjoy',
              textAlign: TextAlign.center,
            ),
          ),
        ],
        onStepReached: (index) => controller.currentStep.value = index,
      ),
    );
  }
}
