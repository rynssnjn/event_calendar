import 'package:event_calendar/src/models/event_model.dart';

/// Gets the total number of weeks available in a month.
int getNumberOfWeeksInMonth(DateTime date) {
  DateTime dateTime = DateTime(date.year, date.month, 1);
  int numberOfDays = getNumberOfDaysInMonth(date);
  int numberOfDaysInStartWeek = 7 - dateTime.weekday;
  int numberOfWeeks = (numberOfDays - numberOfDaysInStartWeek) ~/ 7; // ~/ ~> truncate integer divison opertor
  numberOfWeeks += (numberOfDays - numberOfDaysInStartWeek) % 7 != 0 ? 1 : 0;
  if (numberOfDaysInStartWeek > 0) numberOfWeeks++; // Add a week for the numberOfDaysInStartWeek

  return numberOfWeeks;
}

/// Gets the number of days in a month.
int getNumberOfDaysInMonth(DateTime date) {
  DateTime dateTime = DateTime(date.year, date.month, 1);
  DateTime nextMonth = DateTime(date.year, date.month + 1, 1);
  Duration duration = nextMonth.difference(dateTime);

  return duration.inDays;
}

int comparator(EventModel event1, EventModel event2) {
  int compareOutput = event1.startDate.compareTo(event2.startDate);
  if (compareOutput < 0)
    return -1; //makes event1 come before event2 in the result list
  else if (compareOutput > 0)
    return 1; //makes event2 come before event1 in the result list
  else {
    return event1.startDate
        .difference(event1.endDate)
        .inMilliseconds
        .abs()
        .compareTo(event2.startDate.difference(event2.endDate).inMilliseconds.abs());
  }
}

List<EventModel> getEventsOn(DateTime date) {
  List<int> eventPositions = EventModel.getList(date.month, date.year);
  List<EventModel> eventsOnDate = [];
  for (int pos in eventPositions) {
    EventModel event = EventModel.eventsList[pos];
    DateTime startDate = DateTime(event.startDate.year, event.startDate.month, event.startDate.day);
    DateTime endDate = DateTime(event.endDate.year, event.endDate.month, event.endDate.day);
    if (date.compareTo(startDate) >= 0 && date.compareTo(endDate) <= 0) {
      event.positionInStack = -1;
      eventsOnDate.add(event);
    }
  }
  return eventsOnDate;
}
