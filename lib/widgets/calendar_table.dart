import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomTableCalendar extends StatelessWidget {
  final DateTime startSelectedDay;
  final DateTime endSelectedDay;
  final CalendarFormat calendarFormat;
  final Function(DateTime)? onDaySelected;
  CustomTableCalendar({
    required this.startSelectedDay,
    required this.endSelectedDay,
    this.calendarFormat = CalendarFormat.twoWeeks,
    this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(Duration(days: 365)),
      focusedDay: DateTime.now(),
      selectedDayPredicate: (day) {
        // Đánh dấu các ngày được chọn
        if (startSelectedDay != null && endSelectedDay != null) {
          return day.isAfter(startSelectedDay!.subtract(Duration(days: 1))) &&
              day.isBefore(endSelectedDay!.add(Duration(days: 1)));
        } else if (endSelectedDay != null) {
          return day.isAfter(startSelectedDay!.subtract(Duration(days: 1))) &&
              day.isBefore(endSelectedDay!.add(Duration(days: 1)));
        }
        return false;
      },
      onDaySelected: (selectedDay, focusedDay) => onDaySelected!(selectedDay),
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
      calendarFormat: calendarFormat,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
    );
  }
}
