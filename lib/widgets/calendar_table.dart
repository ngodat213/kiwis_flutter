import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomTableCalendar extends StatelessWidget {
  final DateTime firstDay;
  final DateTime lastDay;
  final Rx<DateTime?> focusedDay;
  final Rx<DateTime?> startDay;
  final Rx<DateTime?> endDay;

  CustomTableCalendar({
    required this.firstDay,
    required this.lastDay,
    required this.focusedDay,
    required this.startDay,
    required this.endDay,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TableCalendar(
        firstDay: firstDay,
        lastDay: lastDay,
        focusedDay: focusedDay.value ?? DateTime.now(),
        selectedDayPredicate: (day) {
          // Đánh dấu các ngày được chọn
          if (endDay.value != null) {
            return day.isAfter(startDay.value!.subtract(Duration(days: 1))) &&
                day.isBefore(endDay.value!.add(Duration(days: 1)));
          }
          return false;
        },
        onDaySelected: (selectedDay, newFocusedDay) {
          focusedDay.value = newFocusedDay;
          if (startDay.value == null ||
              (startDay.value != null && endDay.value != null)) {
            // Đặt ngày bắt đầu mới nếu chưa chọn hoặc đã chọn đủ phạm vi
            startDay.value = selectedDay;
            endDay.value = null;
          } else {
            // Đặt ngày kết thúc nếu đã có ngày bắt đầu
            if (selectedDay.isBefore(startDay.value!)) {
              startDay.value = selectedDay;
            } else {
              endDay.value = selectedDay;
            }
          }
        },
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            final text = DateFormat.E().format(day);
            return Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            );
          },
          defaultBuilder: (context, day, focusedDay) {
            return Center(
              child: Text(
                '${day.day}',
                style: TextStyle(
                  color: Colors.white, // Màu mặc định
                ),
              ),
            );
          },
          selectedBuilder: (context, day, focusedDay) {
            return Container(
              margin: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    color: Colors.white, // Màu chữ ngày được chọn
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
          outsideBuilder: (context, day, focusedDay) {
            return Center(
              child: Text(
                '${day.day}',
                style: TextStyle(
                  color: Colors.grey, // Màu cho ngày ngoài phạm vi
                ),
              ),
            );
          },
          headerTitleBuilder: (context, title) {
            return Center(
              child: Text(
                DateFormat.yMMMM().format(title),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
        calendarFormat: CalendarFormat.month,
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
        },
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
      ),
    );
  }
}
