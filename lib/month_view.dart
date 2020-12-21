import 'package:event_calendar/day_container.dart';
import 'package:event_calendar/event_item.dart';
import 'package:flutter/material.dart';
import 'calendar_event.dart';
import 'calendar_utils.dart';

final double dateTxtHt = 30;
final double eventItemHt = 20;

class CalendarMonthWidget extends StatefulWidget {
  final DateTime currentMonthDate;
  final Size dayWidgetSize;

  CalendarMonthWidget({
    @required this.currentMonthDate,
    @required this.dayWidgetSize,
  });

  @override
  _CalendarMonthWidgetState createState() => _CalendarMonthWidgetState();
}

class _CalendarMonthWidgetState extends State<CalendarMonthWidget> {
  ///holds the list of events in currentweek
  List<CalendarEvent> eventsInCurrentWeek;

  /// holds the stack positions which are filled w.r.t current day events
  List<int> currentDayEventPositionsInStack = List();

  @override
  Widget build(BuildContext context) {
    int numberOfWeeksInMonth = getNumberOfWeeksInMonth(widget.currentMonthDate);
    return ListView(
      children: [
        Column(
          children: [
            for (int i = 0; i < numberOfWeeksInMonth; i++) getWeek(i),
          ],
        ),
      ],
    );
  }

  Widget getWeek(int weekNumber) {
    int daysBeforeStart = getPaddingBeforeStartDayOfMonth();
    int noOfDaysTillPastWeek = (weekNumber) * 7 - daysBeforeStart;
    setEventsInWeekWithStartDate(noOfDaysTillPastWeek + 1);
    return Container(
      child: createChildren(noOfDaysTillPastWeek + 1),
    );
  }

  ///creates a week view by creating each day's view in a week
  ///
  ///[dayViewWidgets] holds the day widgets which themselves hold the event widgets which happen only on paticular day
  ///
  ///[stackWidgets] holds the event widgets which range accross different dates
  ///
  ///[eventWidgetsInDay] events that happen on single day and also in some cases like the day is first day of week and an event that occurs on more days but end on this day will also be added to this

  Widget createChildren(int currentDayNumber) {
    final List<Widget> dayViewWidgets = [];
    final List<Widget> stackWidgets = [];
    //creating 7 days
    for (int i = 0; i < 7; i++, currentDayNumber++) {
      final List<Widget> eventWidgetsInDay = [];
      if (currentDayNumber <= 0 || currentDayNumber > getNumberOfDays()) {
        break;
      } else {
        //get list of events on this date sorted according to their start date and add them to stack or to a dayview
        final int numberOfEventsToDisplay = (widget.dayWidgetSize.height - dateTxtHt) ~/ eventItemHt;
        final DateTime currentDay =
            DateTime(widget.currentMonthDate.year, widget.currentMonthDate.month, currentDayNumber);
        final List<CalendarEvent> sorted = sortedAccordingToTheDuration(currentDay);

        if (numberOfEventsToDisplay != 0) {
          for (CalendarEvent event in sorted) {
            final DateTime startDate = DateTime(event.startTime.year, event.startTime.month, event.startTime.day);
            final DateTime endDate = DateTime(event.endTime.year, event.endTime.month, event.endTime.day);
            if (eventWidgetsInDay.length == numberOfEventsToDisplay &&
                eventWidgetsInDay.length >= currentDayEventPositionsInStack.length) {
              break;
            }
            if (event.positionInStack >= 0) {
              eventWidgetsInDay.add(SizedBox(height: eventItemHt + 15));
              continue;
            } else if ((startDate.difference(currentDay).inDays.abs() > 0 ||
                    endDate.difference(currentDay).inDays.abs() > 0) &&
                currentDay.compareTo(DateTime(currentDay.year, currentDay.month, getNumberOfDays())) != 0) {
              checkAndAddEventToStack(
                  numberOfEventsToDisplay, event, currentDay, currentDayNumber, i, stackWidgets, eventWidgetsInDay);
            } else {
              if (eventWidgetsInDay.length >= numberOfEventsToDisplay)
                continue;
              else {
                for (int position = 0; position < numberOfEventsToDisplay; position++) {
                  if (currentDayEventPositionsInStack.contains(position) ||
                      (position < eventWidgetsInDay.length && eventWidgetsInDay.elementAt(position) is EventItem)) {
                    //ignoring position if the position is already occupied in stack or if the position already has valid event item widget
                    continue;
                  }
                  eventWidgetsInDay.insert(
                    position,
                    EventItem(
                      onTap: () => print('TEST'),
                      event: event,
                    ),
                  );
                  break;
                }
              }
            }
          }
        }
        //added a day with event widgets
        dayViewWidgets.add(DayContainer(
          day: currentDay,
          currentMonthDate: widget.currentMonthDate,
          eventWidgets: eventWidgetsInDay,
          width: widget.dayWidgetSize.width,
        ));
      }
    }
    return Stack(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: dayViewWidgets,
        ),
        ...stackWidgets,
      ],
    );
  }

  /// adds an ranged event to stack by checking the positions that are empty
  void checkAndAddEventToStack(int numberOfEventsToDisplay, CalendarEvent event, DateTime currentDay,
      int currentDayNumber, int i, List<Widget> stackWidgets, List<Widget> eventWidgetsInDay) {
    for (int position = 0; position < numberOfEventsToDisplay; position++) {
      if (currentDayEventPositionsInStack.contains(position) ||
          (position < eventWidgetsInDay.length && eventWidgetsInDay.elementAt(position) is EventItem)) {
        continue;
      }
      currentDayEventPositionsInStack.add(position);
      event.positionInStack = position;
      final int eventDuration = event.endTime.difference(currentDay).inDays + 1;
      final int noOfDaysLeftInWeek =
          (getNumberOfDays() - currentDayNumber) + 1 >= (7 - i) ? 7 - i : (getNumberOfDays() - currentDayNumber) + 1;
      final double width =
          (eventDuration <= noOfDaysLeftInWeek ? eventDuration : noOfDaysLeftInWeek) * widget.dayWidgetSize.width;
      stackWidgets.add(
        Positioned(
          left: i * widget.dayWidgetSize.width,
          top: position * (eventItemHt + 20) + dateTxtHt,
          width: width,
          child: EventItem(
            onTap: () => print('TEST'),
            event: event,
          ),
        ),
      );
      eventWidgetsInDay.add(SizedBox(height: eventItemHt + 15));
      break; //break after the event is added
    }
  }

  List<CalendarEvent> sortedAccordingToTheDuration(DateTime date) {
    List<CalendarEvent> events = List();
    currentDayEventPositionsInStack = List(); //resetting current day positions in stack
    for (CalendarEvent event in eventsInCurrentWeek) {
      DateTime startDate = DateTime(event.startTime.year, event.startTime.month, event.startTime.day);
      DateTime endDate = DateTime(event.endTime.year, event.endTime.month, event.endTime.day);
      if (date.compareTo(startDate) >= 0 && date.compareTo(endDate) <= 0) {
        if (events.contains(event)) continue;
        events.add(event);
        currentDayEventPositionsInStack.add(event.positionInStack);
      }
    }
    events.sort(comparator);
    return events;
  }

  int comparator(CalendarEvent event1, CalendarEvent event2) {
    int compareOutput = event1.startTime.compareTo(event2.startTime);
    if (compareOutput < 0)
      return -1; //makes event1 come before event2 in the result list
    else if (compareOutput > 0)
      return 1; //makes event2 come before event1 in the result list
    else {
      return event1.startTime
          .difference(event1.endTime)
          .inMilliseconds
          .abs()
          .compareTo(event2.startTime.difference(event2.endTime).inMilliseconds.abs());
    }
  }

  void setEventsInWeekWithStartDate(int date) {
    int totDays = getNumberOfDays();
    eventsInCurrentWeek = List();
    for (int i = 0; i < 7; i++, date++) {
      if (date <= 0 || date > totDays) continue;
      eventsInCurrentWeek
          .addAll(getEventsOn(DateTime(widget.currentMonthDate.year, widget.currentMonthDate.month, date)));
    }
  }

  List<CalendarEvent> getEventsOn(DateTime date) {
    List<int> eventPositions = CalendarEvent.getList(date.month, date.year);
    List<CalendarEvent> eventsOnDate = List();
    for (int pos in eventPositions) {
      CalendarEvent event = CalendarEvent.eventsList[pos];
      DateTime startDate = DateTime(event.startTime.year, event.startTime.month, event.startTime.day);
      DateTime endDate = DateTime(event.endTime.year, event.endTime.month, event.endTime.day);
      if (date.compareTo(startDate) >= 0 && date.compareTo(endDate) <= 0) {
        event.positionInStack = -1;
        eventsOnDate.add(event);
      }
    }
    return eventsOnDate;
  }

  int getPaddingBeforeStartDayOfMonth() {
    DateTime dateTime = DateTime(widget.currentMonthDate.year, widget.currentMonthDate.month, 1);
    return dateTime.weekday == 7 ? 0 : dateTime.weekday;
  }

  int getNumberOfDays() {
    return getNumberOfDaysInMonth(widget.currentMonthDate);
  }
}
