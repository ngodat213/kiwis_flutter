import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/views/expense/expense_controller.dart';
import 'package:kiwis_flutter/views/expense/widgets/latest_entry_item.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_trainling_iconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/custom_app_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';

import 'package:velocity_x/velocity_x.dart';

class TotalExpenseContent extends BaseView<ExpenseController> {
  /// Section Widget
  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(Get.height * 0.09 + 23),
      child: Container(
        padding: EdgeInsets.only(top: 23),
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: CustomAppBar(
          leadingWidth: 44.h,
          leading: AppbarLeadingIconbutton(
            imagePath: ImageConstant.imgArrowLeftOnprimary,
            onTap: () {
              Get.back();
            },
          ),
          title: AppbarTitle(
            text: "Total Expenses".tr,
            margin: EdgeInsets.only(left: 16.h),
          ),
          actions: [
            AppbarTrailingIconbutton(
              imagePath: ImageConstant.svgPlus,
              margin: EdgeInsets.only(right: 8.h),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 32),
      height: Get.height,
      margin: EdgeInsets.symmetric(horizontal: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: theme.colorScheme.onPrimary,
            ),
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              // selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              // onDaySelected: (selectedDay, focusedDay) {
              //   // setState(() {
              //   //   _selectedDay = selectedDay;
              //   //   _focusedDay = focusedDay;
              //   // });
              // },
              calendarFormat: CalendarFormat.week, // Hiển thị lịch theo tuần
              availableCalendarFormats: const {
                CalendarFormat.week: 'Week',
              },
              headerStyle: HeaderStyle(
                formatButtonVisible: false, // Ẩn nút chuyển đổi format
                titleCentered: true,
              ),
            ),
          ).marginOnly(bottom: 32),
          Container(
            width: Get.width * 0.3,
            height: Get.width * 0.3,
            decoration: BoxDecoration(
              color: appTheme.blue500,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: "\$1,600"
                  .tr
                  .text
                  .textStyle(theme.textTheme.displayLarge)
                  .bold
                  .center
                  .white
                  .make(),
            ),
          ).paddingOnly(bottom: 16),
          "You have Spend total 60% of you buget"
              .tr
              .text
              .textStyle(theme.textTheme.displayLarge)
              .bold
              .center
              .white
              .make()
              .w(Get.height * 0.2),
          TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.white,
            tabs: const [
              Tab(
                text: "Spends",
              ),
              Tab(
                text: "Categories",
              ),
            ],
            controller: controller.tabController,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) =>
                        LatestEntryItem().paddingOnly(
                      bottom: 8.h,
                    ),
                  ).pOnly(top: 32),
                ),
                Expanded(
                  child: Column(
                    children: [
                      PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                              // touchCallback: (FlTouchEvent event, pieTouchResponse) {
                              //   setState(() {
                              //     if (!event.isInterestedForInteractions ||
                              //         pieTouchResponse == null ||
                              //         pieTouchResponse.touchedSection == null) {
                              //       touchedIndex = -1;
                              //       return;
                              //     }
                              //     touchedIndex = pieTouchResponse
                              //         .touchedSection!.touchedSectionIndex;
                              //   });
                              // },
                              ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                          sections: showingSections(),
                        ),
                      ).w(Get.width * 0.5).h(Get.width * 0.5),
                      Expanded(
                        child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (context, index) =>
                              LatestEntryItem().paddingOnly(
                            bottom: 8.h,
                          ),
                        ).pOnly(top: 32),
                      ),
                    ],
                  ),
                ).pOnly(top: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final fontSize = 25.0;
      final radius = 60.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: appTheme.blue500,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: appTheme.black9000a,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: appTheme.green600,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: appTheme.black9000a,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: appTheme.black9000a,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: appTheme.black9000a,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: appTheme.black9000a,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: appTheme.black9000a,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
