import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/core/constants/app.button_style.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/expense/expense_controller.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import 'package:kiwis_flutter/widgets/app_bar/custom_app_bar.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';
import 'package:kiwis_flutter/widgets/custom_text_form_field.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:velocity_x/velocity_x.dart';

class AddExpenseContent extends BaseView<ExpenseController> {
  /// Section Widget
  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize:
          Size.fromHeight(Get.height * 0.09 + 23), // Set desired height
      child: Container(
        padding: EdgeInsets.only(top: 23),
        margin: EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 16), // Adjust padding as needed
        child: CustomAppBar(
          leadingWidth: 44.h,
          leading: AppbarLeadingIconbutton(
            imagePath: ImageConstant.imgArrowLeftOnprimary,
            onTap: () {
              Get.back();
            },
          ),
          title: AppbarTitle(
            text: "Add".tr,
            margin: EdgeInsets.only(left: 16.h),
          ),
        ),
      ),
    );
  }

  Widget? floatingActionButton(BuildContext context) {
    return CustomElevatedButton(
      text: "ADD INCOME".tr,
      buttonStyle: CustomButtonStyles.fillGreen,
    ).marginSymmetric(horizontal: 32, vertical: 16);
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 32),
      height: Get.height,
      margin: EdgeInsets.symmetric(horizontal: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          "Income Title"
              .tr
              .text
              .bold
              .textStyle(theme.textTheme.titleLarge)
              .make()
              .pOnly(bottom: 8),
          CustomTextFormField(
            hintText: "Income",
            height: 64,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 23.h, vertical: 12.h),
            // borderDecoration: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(18.h),
            //   borderSide: BorderSide(width: 0),
            // ),
            boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.h),
            ),
          ),
          "Amout"
              .tr
              .text
              .bold
              .textStyle(theme.textTheme.titleLarge)
              .make()
              .pOnly(bottom: 8),
          CustomTextFormField(
            hintText: "Amout",
            height: 64,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 23.h, vertical: 12.h),
            // borderDecoration: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(18.h),
            //   borderSide: BorderSide(width: 0),
            // ),
            boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.h),
            ),
          ),
          "Income category"
              .tr
              .text
              .bold
              .textStyle(theme.textTheme.titleLarge)
              .make()
              .pOnly(bottom: 8),
          Row(
            children: [
              Container(
                height: Get.width * 0.15,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  IconlyLight.plus,
                  color: Colors.white,
                ),
              ).paddingOnly(right: 16),
              GestureDetector(
                onTap: () => controller.onTapAddIncome(context),
                child: Container(
                  height: Get.width * 0.15,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 23),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: "Salary"
                      .tr
                      .text
                      .textStyle(theme.textTheme.displayLarge)
                      .center
                      .white
                      .make()
                      .centered(),
                ).paddingOnly(right: 16),
              ),
              GestureDetector(
                onTap: () => controller.onTapAddIncome(context),
                child: Container(
                  height: Get.width * 0.15,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 23),
                  decoration: BoxDecoration(
                    color: appTheme.blueA200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: "Rewards"
                      .tr
                      .text
                      .textStyle(theme.textTheme.displayLarge)
                      .center
                      .white
                      .make()
                      .centered(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
