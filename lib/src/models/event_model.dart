import 'package:flutter/material.dart';

class EventModel {
  EventModel({
    this.onSelect,
    this.title,
    this.startTime,
    this.endTime,
    this.backgroundColor,
  });

  final VoidCallback onSelect;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final Color backgroundColor;

  Color get color => backgroundColor ?? Colors.grey;

  /// used while painting event in calendar
  int positionInStack = -1; // current position

  static List<EventModel> _events;

  static List<EventModel> get eventsList => _events;

  static Map<String, List<int>> _eventsDict;

  static void setEventList(List<EventModel> events) {
    _events = events;
    _eventsDict = Map();
    for (int i = 0; i < events.length; i++) {
      EventModel event = events.elementAt(i);
      _updateMap(event, i);
    }
  }

  static List<int> getList(int month, int year) {
    if (_eventsDict == null) return List.empty();
    List<int> eventPositions = _eventsDict[_getKey(month, year)];
    return eventPositions ?? [];
  }

  static String _getKey(int month, int year) {
    return '$month-$year';
  }

  /// indexing events for processing
  static void _updateMap(EventModel event, int position) {
    int index = 0;
    do {
      DateTime dateTime = DateTime(event.startTime.year, event.startTime.month + index, 1);
      String key = _getKey(dateTime.month, dateTime.year);
      List<int> pointers = _eventsDict[key];
      if (pointers == null) {
        pointers = [];
      }
      pointers.add(position);
      _eventsDict[key] = pointers;
      index++;
    } while (index < inBetweenMonths(event.startTime, event.endTime));
  }
}

int inBetweenMonths(DateTime startDate, DateTime endDate, {bool inclusiveStartAndEnd = true}) {
  int numberOfYears = endDate.year - startDate.year;
  if (numberOfYears < 0) {
    numberOfYears = numberOfYears.abs();
    DateTime temp = startDate;
    startDate = endDate;
    endDate = temp;
  }
  if (numberOfYears == 0) {
    int numberOfMonths = endDate.month - startDate.month;
    return inclusiveStartAndEnd
        ? numberOfMonths + 1
        : numberOfMonths > 0
            ? numberOfMonths - 1
            : 0;
  } else if (numberOfYears > 0) {
    int numberOfMonths = 12 - startDate.month + endDate.month + 12 * (numberOfYears - 1);
    return inclusiveStartAndEnd ? numberOfMonths + 1 : numberOfMonths - 1;
  }
  return -1;
}
