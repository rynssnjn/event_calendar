import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'calendar_utils.dart';
import 'month_view.dart';

class CustomCalendar extends StatefulWidget {
  final List<String> weekDays;
  final Size calendarSize;
  CustomCalendar({
    this.weekDays,
    this.calendarSize,
  });
  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> with SingleTickerProviderStateMixin {
  final int numWeekDays = 7;
  Size _size;
  List<String> _weekDays;
  double _itemHeight;
  double _itemWidth;
  DateTime _currentDate = DateTime.now();
  PageController _controller;
  int _prevIndex = 12;
  StreamController<int> _dateStreamController = StreamController();

  @override
  void initState() {
    _controller = PageController(
      initialPage: _prevIndex,
      keepPage: false,
      viewportFraction: 1.0,
    );

    _size = widget.calendarSize ?? MediaQuery.of(context).size;
    _itemHeight = (_size.height - kBottomNavigationBarHeight - kToolbarHeight - (Platform.isAndroid ? 80 : 265)) /
        getNumberOfWeeksInMonth(_currentDate);
    _itemWidth = _size.width / numWeekDays;

    _weekDays = widget.weekDays ?? ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'];

    super.initState();
  }

  @override
  void dispose() {
    _dateStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          getWeekDaysView(),
          Expanded(child: monthBuilder()),
        ],
      ),
    );
  }

  Column buildCalendarWithEvents(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        getWeekDaysView(),
        Expanded(child: monthBuilder()),
      ],
    );
  }

  /// creates widget with list of days from Sunday to Saturday in a row.
  Widget getWeekDaysView() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      color: Color(0x551A609F),
      child: Row(
        children: <Widget>[
          for (String day in _weekDays)
            SizedBox(
              width: _itemWidth,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  day,
                  style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget monthBuilder() {
    return PageView.builder(
      controller: _controller,
      onPageChanged: (index) {
        setCurrentDate(index);
      },
      itemBuilder: (context, index) {
        setCurrentDate(index);
        // initDimensions();
        return CalendarMonthWidget(
          dayWidgetSize: Size(_itemWidth, _itemHeight),
          currentMonthDate: _currentDate,
        );
      },
    );
  }

  void setCurrentDate(int index) {
    int month = _currentDate.month;
    if (index > _prevIndex) {
      month += index - _prevIndex;
    } else if (index < _prevIndex) {
      month -= _prevIndex - index;
    }
    _prevIndex = index;
    _currentDate = DateTime(_currentDate.year, month, 1);
    _dateStreamController.add(0); //just to notify builder
  }
}
