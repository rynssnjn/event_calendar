import 'package:event_calendar/src/day_container.dart';
import 'package:event_calendar/src/event_item.dart';
import 'package:event_calendar/src/models/event_model.dart';
import 'package:event_calendar/src/models/week_model.dart';
import 'package:event_calendar/src/more_events.dart';
import 'package:event_calendar/src/utilities/calendar_utils.dart';
import 'package:event_calendar/src/week_view.dart';
import 'package:flutter/material.dart';

class MonthView extends StatefulWidget {
  MonthView({
    required this.currentMonthDate,
    required this.dayWidgetSize,
    this.onMoreEventsTapped,
    this.moreEventsBackgroundColor,
    this.moreEventsBannerTextStyle,
  });

  final DateTime currentMonthDate;
  final Size dayWidgetSize;
  final VoidCallback? onMoreEventsTapped;
  final TextStyle? moreEventsBannerTextStyle;
  final Color? moreEventsBackgroundColor;

  @override
  _MonthViewState createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  final double dateTextHeight = 30;
  final double eventHeight = 20;

  /// holds the list of events in currentweek
  late List<EventModel> eventsInCurrentWeek;

  /// holds the stack positions which are filled w.r.t current day events
  List<int> currentDayEventPositionsInStack = [];

  int get paddingBeforeStartDayOfMonth {
    final dateTime = DateTime(widget.currentMonthDate.year, widget.currentMonthDate.month, 1);
    return dateTime.weekday == 7 ? 0 : dateTime.weekday;
  }

  int get numberOfDays => getNumberOfDaysInMonth(widget.currentMonthDate);

  /// adds an ranged event to stack by checking the positions that are empty
  void checkAndAddEventToStack(int numberOfEventsToDisplay, EventModel event, DateTime currentDay, int currentDayNumber,
      int i, List<Widget> stackWidgets, List<Widget> eventWidgetsInDay) {
    for (int position = 0; position < numberOfEventsToDisplay; position++) {
      if (currentDayEventPositionsInStack.contains(position) ||
          (position < eventWidgetsInDay.length && eventWidgetsInDay.elementAt(position) is EventItem)) {
        continue;
      }
      currentDayEventPositionsInStack.add(position);
      event.positionInStack = position;
      final int eventDuration = event.endTime.difference(currentDay).inDays + 1;
      final int noOfDaysLeftInWeek =
          (numberOfDays - currentDayNumber) + 1 >= (7 - i) ? 7 - i : (numberOfDays - currentDayNumber) + 1;
      final double width =
          (eventDuration <= noOfDaysLeftInWeek ? eventDuration : noOfDaysLeftInWeek) * widget.dayWidgetSize.width;
      stackWidgets.add(
        Positioned(
          left: i * widget.dayWidgetSize.width,
          top: position * (eventHeight + 20) + dateTextHeight,
          width: width,
          child: EventItem(event: event),
        ),
      );
      eventWidgetsInDay.add(SizedBox(height: eventHeight + 15));
      break; //break after the event is added
    }
  }

  List<EventModel> sortedAccordingToTheDuration(DateTime date) {
    List<EventModel> events = [];
    currentDayEventPositionsInStack = []; //resetting current day positions in stack
    for (EventModel event in eventsInCurrentWeek) {
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

  void setEventsInWeekWithStartDate(int date) {
    eventsInCurrentWeek = [];
    for (int i = 0; i < 7; i++, date++) {
      if (date <= 0 || date > numberOfDays) continue;
      eventsInCurrentWeek
          .addAll(getEventsOn(DateTime(widget.currentMonthDate.year, widget.currentMonthDate.month, date)));
    }
  }

  @override
  Widget build(BuildContext context) {
    int numberOfWeeksInMonth = getNumberOfWeeksInMonth(widget.currentMonthDate);
    List<WeekModel> weekModels = <WeekModel>[];

    for (int week = 0; week < numberOfWeeksInMonth; week++) {
      int daysBeforeStart = paddingBeforeStartDayOfMonth;
      int noOfDaysTillPastWeek = (week) * 7 - daysBeforeStart;
      int currentDayNumber = noOfDaysTillPastWeek + 1;
      setEventsInWeekWithStartDate(noOfDaysTillPastWeek + 1);

      final List<Widget> dayViewWidgets = [];
      final List<Widget> stackWidgets = [];

      for (int i = 0; i < 7; i++, currentDayNumber++) {
        final List<Widget> eventWidgetsInDay = [];
        if (currentDayNumber <= 0 || currentDayNumber > numberOfDays) {
          dayViewWidgets.add(Container(
            width: widget.dayWidgetSize.width,
            padding: EdgeInsets.only(top: 5),
          ));
        } else {
          final int numberOfEventsToDisplay = (widget.dayWidgetSize.height - dateTextHeight) ~/ eventHeight;
          final DateTime currentDay =
              DateTime(widget.currentMonthDate.year, widget.currentMonthDate.month, currentDayNumber);
          final List<EventModel> sorted = sortedAccordingToTheDuration(currentDay);

          if (numberOfEventsToDisplay != 0) {
            for (EventModel event in sorted) {
              final DateTime startDate = DateTime(event.startTime.year, event.startTime.month, event.startTime.day);
              final DateTime endDate = DateTime(event.endTime.year, event.endTime.month, event.endTime.day);
              if (eventWidgetsInDay.length == numberOfEventsToDisplay &&
                  eventWidgetsInDay.length >= currentDayEventPositionsInStack.length) {
                break;
              }
              if (event.positionInStack >= 0) {
                eventWidgetsInDay.add(SizedBox(height: eventHeight + 15));
                continue;
              } else if ((startDate.difference(currentDay).inDays.abs() > 0 ||
                      endDate.difference(currentDay).inDays.abs() > 0) &&
                  currentDay.compareTo(DateTime(currentDay.year, currentDay.month, numberOfDays)) != 0) {
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
                      EventItem(event: event),
                    );
                    break;
                  }
                }
              }
            }
          }
          dayViewWidgets.add(DayContainer(
            onTap: (day) {},
            day: currentDay,
            currentMonthDate: widget.currentMonthDate,
            eventWidgets: eventWidgetsInDay,
            width: widget.dayWidgetSize.width,
          ));

          if (sorted.length - numberOfEventsToDisplay > 0 && widget.onMoreEventsTapped != null) {
            const size = 25.0;
            stackWidgets.add(Positioned(
              left: i * widget.dayWidgetSize.width,
              top: 0,
              width: size,
              child: MoreEvents(
                onTap: () {
                  widget.onMoreEventsTapped?.call();
                },
                value: sorted.length - numberOfEventsToDisplay,
                size: size,
                backgroundColor: widget.moreEventsBackgroundColor!,
                bannerTextStyle: widget.moreEventsBannerTextStyle!,
              ),
            ));
          }
        }
      }
      weekModels.add(WeekModel(
        dayViewWidgets: dayViewWidgets,
        stackWidgets: stackWidgets,
      ));
    }
    return ListView(
      children: [
        Column(children: weekModels.map((week) => WeekView(week: week)).toList()),
      ],
    );
  }
}
