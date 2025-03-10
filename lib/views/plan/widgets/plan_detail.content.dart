import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:glossy/glossy.dart';
import 'package:intl/intl.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/models/cost.model.dart';
import 'package:kiwis_flutter/models/plan_location.model.dart';
import 'package:kiwis_flutter/services/socket.service.dart';
import 'package:kiwis_flutter/views/plan/plan_controller.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_trainling_iconbutton.dart';
import 'package:kiwis_flutter/widgets/base_appbar.dart';
import 'package:kiwis_flutter/widgets/custom_icon_button.dart';
import 'package:velocity_x/velocity_x.dart';

class PlanDetailContent extends GetView<PlanController> {
  const PlanDetailContent({
    super.key,
    this.onlySchedule = false,
  });
  final bool onlySchedule;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: onlySchedule
          ? null
          : baseAppBar(
              context: context,
              title: SocketService.currentPlan.value.name!.tr,
              onBack: () {
                controller.userPlans.clear();
                controller.selectedShareCosts.clear();
                Get.back();
              },
              actions: [
                AppbarLeadingIconbutton(
                  imagePath: ImageConstant.svgEdit,
                  onTap: () =>
                      controller.showContentCreatePlan(context, isEdit: true),
                ),
              ],
            ),
      body: Container(
        height: Get.height,
        width: Get.width,
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
                  height: Get.height * 1.5,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      onlySchedule ? SizedBox() : ContentWidget(),
                      SizedBox(height: 10),
                      DatePicker(
                        SocketService.currentPlan.value.startDate!,
                        height: 100,
                        width: 70,
                        initialSelectedDate:
                            SocketService.currentPlan.value.startDate!,
                        daysCount: SocketService.currentPlan.value.endDate!
                                .difference(
                                    SocketService.currentPlan.value.startDate!)
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
                      Row(
                        children: [
                          'Add task'
                              .tr
                              .text
                              .textStyle(theme.textTheme.bodySmall!.copyWith(
                                color: Colors.white,
                              ))
                              .bold
                              .make()
                              .paddingSymmetric(horizontal: 16, vertical: 8)
                              .color(appTheme.green600)
                              .cornerRadius(10)
                              .onTap(
                                  () => controller.showContentAddTask(context)),
                          SizedBox(width: 10),
                          'Add expense'
                              .tr
                              .text
                              .textStyle(theme.textTheme.bodySmall!.copyWith(
                                color: Colors.white,
                              ))
                              .bold
                              .make()
                              .paddingSymmetric(horizontal: 16, vertical: 8)
                              .color(appTheme.green600)
                              .cornerRadius(10)
                              .onTap(() =>
                                  controller.showContentAddExpense(context)),
                          SizedBox(width: 10),
                          'Map direction'
                              .tr
                              .text
                              .textStyle(theme.textTheme.bodySmall!.copyWith(
                                color: Colors.white,
                              ))
                              .bold
                              .make()
                              .paddingSymmetric(horizontal: 16, vertical: 8)
                              .color(appTheme.green600)
                              .cornerRadius(10)
                              .onTap(() => controller.handeToOnPlan()),
                        ],
                      ),
                      TabBar(
                        controller: controller.detailTabController,
                        indicatorColor: appTheme.green600,
                        labelColor: appTheme.green600,
                        dividerColor: Colors.transparent,
                        tabs: [
                          Tab(text: 'Schedule'),
                          Tab(text: 'Expenses'),
                          Tab(text: 'Spend money'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: Container(
                          child: TabBarView(
                            controller: controller.detailTabController,
                            children: [
                              ScheduleWidget(),
                              ExpenseWidget(),
                              SizedBox(),
                            ],
                          ),
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
  }

  Obx ExpenseWidget() {
    return Obx(
      () => Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: SocketService.planCostsByDay.length,
              itemBuilder: (context, index) => LatestEntryItem(
                cost: SocketService.planCostsByDay[index],
              ).paddingOnly(
                bottom: 8.h,
              ),
            ).pOnly(top: 32),
          ),
        ],
      ),
    );
  }
}

class LatestEntryItem extends StatelessWidget {
  final CostModel cost;
  const LatestEntryItem({
    super.key,
    required this.cost,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.5,
            color: theme.colorScheme.onPrimary.withOpacity(0.05),
          ),
        ),
      ),
      child: Row(
        children: [
          AppbarTrailingIconbutton(
            // onTap: () => controller.showModalCalenderSheet(context),
            imagePath: ImageConstant.svgDollar,
          ).marginOnly(right: 8.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cost.title!.tr.text.textStyle(theme.textTheme.titleMedium).make(),
              "${cost.amount} VNĐ"
                  .tr
                  .text
                  .textStyle(theme.textTheme.titleSmall)
                  .make(),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              DateFormat('dd/MM/yyyy')
                  .format(DateTime.parse(cost.createdAt!))
                  .tr
                  .text
                  .textStyle(theme.textTheme.bodyMedium)
                  .make(),
              cost.payer!.fullName.tr.text
                  .textStyle(theme.textTheme.bodyMedium)
                  .make(),
            ],
          ),
        ],
      ),
    );
  }
}

class ContentWidget extends GetView<PlanController> {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SocketService.currentPlan.value.thumbnail?.imageUrl != null
            ? CustomImageView(
                imagePath: SocketService.currentPlan.value.thumbnail!.imageUrl!,
                width: Get.width * 0.9,
                height: 200,
                fit: BoxFit.cover,
                radius: BorderRadius.circular(10),
                placeHolder: ImageConstant.imgNoData,
              )
            : SizedBox(),
        SizedBox(height: 10),
        SocketService.currentPlan.value.description!.text.ellipsis
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
        Expanded(child: DottedLine()).paddingSymmetric(vertical: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('• Created by: ', style: theme.textTheme.titleSmall),
            Text(SocketService.currentPlan.value.createdBy!.fullName,
                style: theme.textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w400,
                ))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('• Start date: ', style: theme.textTheme.titleSmall),
            Text(
                DateFormat('dd/MM/yyyy')
                    .format(SocketService.currentPlan.value.startDate!),
                style: theme.textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w400,
                ))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('• End date: ', style: theme.textTheme.titleSmall),
            Text(
                DateFormat('dd/MM/yyyy')
                    .format(SocketService.currentPlan.value.endDate!),
                style: theme.textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w400,
                ))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('• Time: ', style: theme.textTheme.titleSmall),
            Text(
              (DateFormat('HH:mm')
                      .format(SocketService.currentPlan.value.endDate!) +
                  ' - ' +
                  DateFormat('HH:mm')
                      .format(SocketService.currentPlan.value.startDate!)),
              style: theme.textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('• Budget: ', style: theme.textTheme.titleSmall),
            Text(
              (SocketService.currentPlan.value.totalCost.toString() + ' VNĐ'),
              style: theme.textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Obx(() => Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: SocketService.taskByDay.length,
                  itemBuilder: (context, index) {
                    var currentTask = SocketService.taskByDay[index];
                    return index != SocketService.taskByDay.length
                        ? buildTimelineItem(
                            status: currentTask.status!,
                            isActive: currentTask.taskId ==
                                SocketService.taskChange.value?.taskId,
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
                            location: currentTask.planLocation,
                          ).onTap(() {
                            SocketService.onChangeTask(currentTask);
                            controller.showDialog(
                              Dialog(
                                insetPadding:
                                    EdgeInsets.symmetric(horizontal: 24),
                                backgroundColor: Colors.transparent,
                                child: GlossyContainer(
                                  width: Get.width + 32,
                                  height: Get.height * 0.3,
                                  borderRadius: BorderRadius.circular(36),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      buildTimelineItem(
                                        status: currentTask.status!,
                                        isActive: currentTask.taskId ==
                                            SocketService
                                                .taskChange.value?.taskId,
                                        taskId: currentTask.taskId!,
                                        context: context,
                                        time: DateFormat('HH:mm').format(
                                            DateTime.tryParse(
                                                currentTask.startDate!)!),
                                        title: currentTask.title!,
                                        description: currentTask.description!,
                                        budget: currentTask.totalCost ?? null,
                                        startDate: DateTime.tryParse(
                                            currentTask.startDate!)!,
                                        endDate: DateTime.tryParse(
                                            currentTask.endDate!)!,
                                        location: currentTask.planLocation,
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          'Done'
                                              .tr
                                              .text
                                              .textStyle(theme
                                                  .textTheme.bodySmall!
                                                  .copyWith(
                                                color: Colors.white,
                                              ))
                                              .bold
                                              .make()
                                              .paddingSymmetric(
                                                  horizontal: 24, vertical: 8)
                                              .color(appTheme.green600)
                                              .cornerRadius(10)
                                              .onTap(() =>
                                                  controller.handleTaskDone(
                                                      currentTask.taskId!)),
                                          'Edit'
                                              .tr
                                              .text
                                              .textStyle(theme
                                                  .textTheme.bodySmall!
                                                  .copyWith(
                                                color: Colors.white,
                                              ))
                                              .bold
                                              .make()
                                              .paddingSymmetric(
                                                  horizontal: 24, vertical: 8)
                                              .color(appTheme.yellow800)
                                              .cornerRadius(10)
                                              .onTap(() => controller
                                                  .showContentAddTask(context,
                                                      task: currentTask)),
                                          'Delete'
                                              .tr
                                              .text
                                              .textStyle(theme
                                                  .textTheme.bodySmall!
                                                  .copyWith(
                                                color: Colors.white,
                                              ))
                                              .bold
                                              .make()
                                              .paddingSymmetric(
                                                  horizontal: 24, vertical: 8)
                                              .color(appTheme.red700)
                                              .cornerRadius(10)
                                              .onTap(() => controller
                                                  .showContentAddExpense(
                                                      context)),
                                        ],
                                      ),
                                    ],
                                  ).paddingAll(24),
                                ),
                              ),
                            );
                          })
                        : SizedBox(height: 64);
                  },
                ),
              )),
        ],
      ),
    );
  }
}

Widget buildTimelineItem({
  required String taskId,
  required BuildContext context,
  required String time,
  required String title,
  required String description,
  required String status,
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
                          color: status == 'COMPLETED'
                              ? appTheme.green600
                              : Color(0xffFBEA92),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: status == 'COMPLETED'
                            ? 'Done'
                                .text
                                .white
                                .textStyle(theme.textTheme.bodySmall)
                                .make()
                            : 'In Progress'
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
