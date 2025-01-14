import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/models/plan_location.model.dart';
import 'package:kiwis_flutter/services/socket.service.dart';
import 'package:kiwis_flutter/views/plan/plan_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class ScheduleContent extends GetView<PlanController> {
  const ScheduleContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Container(
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 32),
                      ScheduleWidget(),
                    ],
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
      height: Get.height * 0.55,
      child: Column(
        children: [
          DatePicker(
            SocketService.currentPlan.value.startDate!,
            height: 100,
            width: 70,
            initialSelectedDate: SocketService.currentPlan.value.startDate!,
            daysCount: SocketService.currentPlan.value.endDate!
                    .difference(SocketService.currentPlan.value.startDate!)
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
              SocketService.getTasksByDate(date);
              SocketService.getCostSharingByDate(date);
            },
          ),
          SizedBox(height: 16),
          Obx(() => Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: SocketService.taskByDay.length,
                  itemBuilder: (context, index) {
                    var currentTask = SocketService.taskByDay[index];
                    return index != SocketService.taskByDay.length
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
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 147 / 3,
            child: Stack(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.svgWave,
                  width: Get.width - 100,
                  height: 147 / 3,
                  fit: BoxFit.cover,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.svgCalander,
                          width: 16,
                          height: 16,
                          color: Colors.black,
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
                        Spacer(),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(0xffFBEA92),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: 'In Progress'
                              .text
                              .textStyle(theme.textTheme.bodySmall)
                              .make(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                        ),
                        Text(
                          DateFormat(' HH:mm - ').format(startDate).toString(),
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
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 4),
          description.text.ellipsis
              .maxLines(2)
              .fontWeight(FontWeight.w400)
              .textStyle(theme.textTheme.bodyMedium)
              .make(),
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
                    Icon(Icons.location_on, size: 16),
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
    ).marginOnly(bottom: 16);
  }
}
