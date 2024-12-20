import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/models/plan_location.model.dart';
import 'package:kiwis_flutter/views/plan/plan_controller.dart';
import 'package:kiwis_flutter/widgets/base_appbar.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';
import 'package:kiwis_flutter/widgets/custom_icon_button.dart';
import 'package:velocity_x/velocity_x.dart';

class PlanDetailContent extends GetView<PlanController> {
  const PlanDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseAppBar(
        context: context,
        title: controller.currentPlan.value!.name!.tr,
        actions: [
          "Save".tr.text.textStyle(theme.textTheme.titleSmall).bold.make()
          // .onTap(() => controller.updateAllPlanLocation()),
        ],
      ),
      floatingActionButton: CustomElevatedButton(
        width: Get.width * 0.9,
        text: "Start now",
        buttonTextStyle: theme.textTheme.titleSmall!.copyWith(
          color: Colors.white,
        ),
        decoration: BoxDecoration(
          color: appTheme.green600,
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () => controller.toOnPlan(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SizedBox(
        width: double.maxFinite,
        child: Container(
          height: Get.height + Get.height * .13,
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
                    height: Get.height + 64,
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.currentPlan.value?.thumbnail?.imageUrl !=
                                null
                            ? CustomImageView(
                                imagePath: controller
                                    .currentPlan.value!.thumbnail!.imageUrl!,
                                width: Get.width * 0.9,
                                height: 200,
                                fit: BoxFit.cover,
                                radius: BorderRadius.circular(10),
                                placeHolder: ImageConstant.imgNoData,
                              )
                            : SizedBox(),
                        SizedBox(height: 10),
                        controller.currentPlan.value!.description!.text.ellipsis
                            .maxLines(5)
                            .textStyle(theme.textTheme.bodyMedium)
                            .make(),
                        SizedBox(height: 10),
                        CustomIconButton(
                          child: Column(
                            children: [
                              Icon(Icons.map),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        HStack([
                          'Schedules'
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
                            child: 'Add'
                                .tr
                                .text
                                .textStyle(theme.textTheme.titleSmall)
                                .make()
                                .onTap(
                                    () => controller.onPressedAddTask(context)),
                          ),
                        ]),
                        SizedBox(height: 10),
                        ScheduleWidget(),
                        SizedBox(height: 64),
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

class ScheduleWidget extends GetView<PlanController> {
  const ScheduleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.55,
      child: Column(
        children: [
          DatePicker(
            controller.currentPlan.value!.startDate!,
            height: 100,
            width: 70,
            initialSelectedDate: controller.currentPlan.value!.startDate!,
            daysCount: controller.currentPlan.value!.endDate!
                    .difference(controller.currentPlan.value!.startDate!)
                    .inDays +
                1,
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
            onDateChange: (date) {
              controller.getTasksByDate(date);
            },
          ),
          SizedBox(height: 16),
          Obx(() => Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.tasks.length,
                  itemBuilder: (context, index) {
                    var currentTask = controller.tasks[index];
                    return index != controller.tasks.length
                        ? buildTimelineItem(
                            taskId: currentTask.taskId!,
                            context: context,
                            time: DateFormat('HH:mm').format(
                                DateTime.tryParse(currentTask.startDate!)!),
                            title: currentTask.title!,
                            description: currentTask.description!,
                            budget: currentTask.totalCost ?? null,
                            startDate:
                                DateTime.tryParse(currentTask.startDate!)!,
                            endDate: DateTime.tryParse(currentTask.endDate!)!,
                            isActive: false,
                            location: currentTask.planLocation,
                          )
                        : SizedBox(height: 64);
                  },
                ),
              )),
        ],
      ),
    );
  }

  Widget buildTimelineItem({
    required String taskId,
    required BuildContext context,
    required String time,
    required String title,
    required String description,
    int? budget,
    required DateTime startDate,
    required DateTime endDate,
    bool isActive = false,
    PlanLocationModel? location,
    List<String>? avatars,
  }) {
    final theme = Theme.of(context);
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Indicator + Line
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                child: Container(
                  width: 2,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Content Card
          Expanded(
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: isActive
                    ? Colors.blue[50]
                    : theme.colorScheme.onPrimary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium,
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 16,
                          ),
                          Text(
                            DateFormat(' dd/MM/yyyy - ')
                                .format(startDate)
                                .toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium,
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy').format(endDate).toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                          ),
                          Text(
                            DateFormat(' HH:mm - ')
                                .format(startDate)
                                .toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium,
                          ),
                          Text(
                            DateFormat('HH:mm').format(endDate).toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      budget != null
                          ? Row(
                              children: [
                                Icon(
                                  Icons.money,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${budget} VNĐ",
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            )
                          : SizedBox(),
                      location != null
                          ? Row(
                              children: [
                                Icon(Icons.map, size: 16),
                                Text(
                                  location.name!,
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            )
                          : SizedBox(),
                      if (avatars != null && avatars.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: avatars.map((url) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(url),
                                  radius: 12,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    flex: 1,
                    child: Icon(
                      Icons.delete,
                      size: 23,
                    ).onTap(
                        () => controller.onPressedDeleteTask(context, taskId)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).marginOnly(bottom: 16);
  }
}
