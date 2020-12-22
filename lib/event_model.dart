import 'package:flutter/material.dart';

class EventModel {
  /// used while painting event in calendar
  int positionInStack = -1; //current position

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

  static List<EventModel> _events;

  static List<EventModel> get eventsList => _events;

  Color get color => backgroundColor ?? Colors.grey;

  static Map<String, List<int>> _eventsDict;

  static void setListAndUpdateMap(List<EventModel> events) {
    //on deleting an event
    _events = events;
    _eventsDict = Map();
    for (int i = 0; i < events.length; i++) {
      EventModel event = events.elementAt(i);
      _updateMap(event, i);
    }
  }

  //indexing events for fast processing
  static void _updateMap(EventModel event, int position) {
    int monthsCount = numberOfMonthsBetween(event.startTime, event.endTime);
    int index = 0;
    do {
      DateTime dateTime = DateTime(event.startTime.year, event.startTime.month + index, 1);
      String key = _getKeyFrom(dateTime.month, dateTime.year);
      List<int> pointersToEvents = _eventsDict[key];
      if (pointersToEvents == null) {
        pointersToEvents = List<int>();
      }
      pointersToEvents.add(position);
      _eventsDict[key] = pointersToEvents;
      index++;
    } while (index < monthsCount);
  }

  static List<int> getList(int month, int year) {
    if (_eventsDict == null) return List<int>();
    List<int> eventPositions = _eventsDict[_getKeyFrom(month, year)];
    return eventPositions ?? List<int>();
  }

  static String _getKeyFrom(int month, int year) {
    return '$month-$year';
  }
}

int numberOfMonthsBetween(DateTime startDate, DateTime endDate, {bool inclusiveStartAndEnd = true}) {
  int numberOfYearsInBetween = endDate.year - startDate.year;
  if (numberOfYearsInBetween < 0) {
    numberOfYearsInBetween = numberOfYearsInBetween.abs();
    DateTime temp = startDate;
    startDate = endDate;
    endDate = temp;
  }
  if (numberOfYearsInBetween == 0) {
    int noOfMonths = endDate.month - startDate.month;
    return inclusiveStartAndEnd
        ? noOfMonths + 1
        : noOfMonths > 0
            ? noOfMonths - 1
            : 0;
  } else if (numberOfYearsInBetween > 0) {
    int noOfMonths = 12 - startDate.month + endDate.month + 12 * (numberOfYearsInBetween - 1);
    return inclusiveStartAndEnd ? noOfMonths + 1 : noOfMonths - 1;
  }
  return -1;
}
