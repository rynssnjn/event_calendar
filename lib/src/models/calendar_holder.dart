import 'package:event_calendar/event_calendar.dart';
import 'package:flutter/material.dart';

class CalendarHolder {
  CalendarHolder({
    this.monday = 'Mo.',
    this.tuesday = 'Tu.',
    this.wednesday = 'We.',
    this.thursday = 'Th.',
    this.friday = 'Fr.',
    this.saturday = 'Sa.',
    this.sunday = 'Su.',
    this.firstDay = FirstDay.SUNDAY,
    this.weekdayTextStyle,
    this.weekendTextStyle,
    this.months,
  });

  final String monday;
  final String tuesday;
  final String wednesday;
  final String thursday;
  final String friday;
  final String saturday;
  final String sunday;
  final TextStyle? weekdayTextStyle;
  final TextStyle? weekendTextStyle;
  final FirstDay firstDay;
  final List<String>? months;

  List<DayModel> get days => isFirstDayMonday ? _mondayFirst : _sundayFirst;

  bool get isFirstDayMonday => firstDay == FirstDay.MONDAY;

  int get firstDayValue => isFirstDayMonday ? 0 : 1;

  List<String> get calendarMonths => months ?? _months;

  List<DayModel> get _mondayFirst => [
        DayModel(dayStringValue: monday, textStyle: weekdayTextStyle),
        DayModel(dayStringValue: tuesday, textStyle: weekdayTextStyle),
        DayModel(dayStringValue: wednesday, textStyle: weekdayTextStyle),
        DayModel(dayStringValue: thursday, textStyle: weekdayTextStyle),
        DayModel(dayStringValue: friday, textStyle: weekdayTextStyle),
        DayModel(dayStringValue: saturday, textStyle: weekendTextStyle),
        DayModel(dayStringValue: sunday, textStyle: weekdayTextStyle),
      ];

  List<DayModel> get _sundayFirst => [
        DayModel(dayStringValue: sunday, textStyle: weekdayTextStyle),
        DayModel(dayStringValue: monday, textStyle: weekdayTextStyle),
        DayModel(dayStringValue: tuesday, textStyle: weekdayTextStyle),
        DayModel(dayStringValue: wednesday, textStyle: weekdayTextStyle),
        DayModel(dayStringValue: thursday, textStyle: weekdayTextStyle),
        DayModel(dayStringValue: friday, textStyle: weekdayTextStyle),
        DayModel(dayStringValue: saturday, textStyle: weekendTextStyle),
      ];

  List<String> get _months => [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];
}
