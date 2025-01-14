import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/models/task.model.dart';
import 'package:kiwis_flutter/services/socket.service.dart';
import 'package:kiwis_flutter/views/plan/plan_controller.dart';
import 'package:kiwis_flutter/widgets/base_appbar.dart';
import 'package:kiwis_flutter/widgets/custom_text_form_field.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'package:velocity_x/velocity_x.dart';

class AddTaskContent extends GetView<PlanController> {
  AddTaskContent({
    super.key,
    this.task,
  });
  final TaskModel? task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseAppBar(
        context: context,
        title: task != null ? "Edit Task".tr : "Add Task".tr,
        actions: [
          "Save"
              .tr
              .text
              .textStyle(theme.textTheme.titleSmall)
              .make()
              .onTap(() => controller.handleCreateTask()),
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
                            controller: controller.taskBudgetTEC,
                            textInputType: TextInputType.number,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 23.h, vertical: 12.h),
                          ),
                          SizedBox(height: 16),
                          TaskTimeWidget(),
                          SizedBox(height: 16),
                          "Location"
                              .tr
                              .text
                              .bold
                              .textStyle(theme.textTheme.titleMedium)
                              .make(),
                          SizedBox(height: 10),
                          Container(
                            width: Get.width,
                            padding: EdgeInsets.symmetric(horizontal: 23.h),
                            decoration: BoxDecoration(
                              color:
                                  theme.colorScheme.onPrimary.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              onTap: () {
                                controller.showContentChooseLocation(context);
                              },
                              contentPadding: EdgeInsets.zero,
                              title:
                                  controller.planLocationChanged.value?.name !=
                                          null
                                      ? controller.planLocationChanged.value!
                                          .name!.text.bold.ellipsis
                                          .textStyle(theme.textTheme.bodySmall)
                                          .make()
                                      : "Choose your location"
                                          .tr
                                          .text
                                          .textStyle(theme.textTheme.bodySmall)
                                          .make(),
                              subtitle: controller.planLocationChanged.value
                                  ?.address?.text.ellipsis
                                  .textStyle(theme.textTheme.bodySmall)
                                  .make(),
                              trailing: Icon(Icons.location_on_outlined,
                                  color: theme.colorScheme.onPrimary
                                      .withOpacity(0.5)),
                            ),
                          ),
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

class TaskTimeWidget extends GetView<PlanController> {
  const TaskTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
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
                      initTime: controller.taskStartTime.value,
                      minTime: SocketService.currentPlan.value.startDate,
                      maxTime: SocketService.currentPlan.value.endDate,
                      barrierColor: Colors.black12,
                      minuteInterval: 1,
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                      cancelText: 'Cancel',
                      confirmText: 'OK',
                      pressType: PressType.singlePress,
                      timeWidgetBuilder: (dataTime) {
                        return DateItemWidget(dataTime: dataTime);
                      },
                      timeFormat: 'dd/MM/yyyy',
                      onChange: (dateTime) {
                        controller.taskEndTime.value = dateTime;
                        controller.taskStartTime.value = dateTime;
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
                      initTime: controller.taskStartTime.value,
                      barrierColor: Colors.black12,
                      minuteInterval: 1,
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                      cancelText: 'Cancel',
                      confirmText: 'OK',
                      pressType: PressType.singlePress,
                      timeWidgetBuilder: (dataTime) {
                        return TimeItemWidget(dataTime: dataTime);
                      },
                      timeFormat: 'HH:mm',
                      onChange: (dateTime) {
                        controller.taskStartTime.value = DateTime(
                          controller.taskStartTime.value.year,
                          controller.taskStartTime.value.month,
                          controller.taskStartTime.value.day,
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
                      initTime: controller.taskEndTime.value,
                      minTime: controller.taskStartTime.value,
                      maxTime: SocketService.currentPlan.value.endDate,
                      barrierColor: Colors.black12,
                      minuteInterval: 1,
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                      cancelText: 'Cancel',
                      confirmText: 'OK',
                      pressType: PressType.singlePress,
                      timeWidgetBuilder: (dataTime) {
                        return DateItemWidget(dataTime: dataTime);
                      },
                      timeFormat: 'dd/MM/yyyy',
                      onChange: (dateTime) {
                        controller.taskEndTime.value = DateTime(
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
                      initTime: controller.taskEndTime.value,
                      barrierColor: Colors.black12,
                      minuteInterval: 1,
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                      cancelText: 'Cancel',
                      confirmText: 'OK',
                      pressType: PressType.singlePress,
                      timeWidgetBuilder: (dataTime) {
                        return TimeItemWidget(dataTime: dataTime);
                      },
                      timeFormat: 'HH:mm',
                      onChange: (dateTime) {
                        controller.taskEndTime.value = DateTime(
                          controller.taskEndTime.value.year,
                          controller.taskEndTime.value.month,
                          controller.taskEndTime.value.day,
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
      );
    });
  }
}

class TimeItemWidget extends StatelessWidget {
  const TimeItemWidget({
    super.key,
    required this.dataTime,
  });

  final DateTime dataTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.3,
      padding: EdgeInsets.symmetric(horizontal: 23.h, vertical: 12.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DateFormat('HH : mm')
              .format(dataTime)
              .text
              .textStyle(theme.textTheme.bodySmall)
              .make(),
          Icon(
            Icons.access_time_outlined,
            color: theme.colorScheme.onPrimary.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}

class DateItemWidget extends StatelessWidget {
  const DateItemWidget({
    super.key,
    required this.dataTime,
  });

  final DateTime dataTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.6,
      padding: EdgeInsets.symmetric(horizontal: 23.h, vertical: 12.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DateFormat('dd / MM / yyyy')
              .format(dataTime)
              .text
              .textStyle(theme.textTheme.bodySmall)
              .make(),
          Icon(
            Icons.calendar_month_outlined,
            color: theme.colorScheme.onPrimary.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
