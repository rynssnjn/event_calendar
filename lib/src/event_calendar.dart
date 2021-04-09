import 'dart:io';
import 'dart:ui';
import 'package:event_calendar/event_calendar.dart';
import 'package:event_calendar/src/month_pageview.dart';
import 'package:event_calendar/src/utilities/calendar_utils.dart';
import 'package:flutter/material.dart';

class EventCalendar extends StatefulWidget {
  EventCalendar({
    this.onMoreEventsTapped,
    this.weekDays,
    this.events,
    this.previousIcon,
    this.nextIcon,
    this.headerStyle,
    this.moreEventsBannerTextStyle,
    this.weekdaysHeaderTextStyle,
    this.weekdaysBackgroundColor,
    this.moreEventsBackgroundColor,
    this.calendarSize,
  });

  final VoidCallback onMoreEventsTapped;
  final List<String> weekDays;
  final List<EventModel> events;
  final Widget previousIcon;
  final Widget nextIcon;
  final TextStyle headerStyle;
  final TextStyle moreEventsBannerTextStyle;
  final TextStyle weekdaysHeaderTextStyle;
  final Color weekdaysBackgroundColor;
  final Color moreEventsBackgroundColor;
  final Size calendarSize;

  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> with SingleTickerProviderStateMixin {
  List<String> _weekDays;
  double _itemHeight;
  double _itemWidth;
  DateTime _currentDate = DateTime.now();
  PageController _controller;
  int _previousIndex = 12;

  @override
  void initState() {
    EventModel.setEventList(widget.events);

    _controller = PageController(
      initialPage: _previousIndex,
      keepPage: false,
      viewportFraction: 1.0,
    );

    final size = widget.calendarSize ?? MediaQuery.of(context).size;
    _itemHeight = (size.height - kBottomNavigationBarHeight - kToolbarHeight - (Platform.isAndroid ? 120 : _iosSize)) /
        getNumberOfWeeksInMonth(_currentDate);
    _itemWidth = size.width / 7;

    _weekDays = widget.weekDays ?? ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'];
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get _iosSize {
    final height = widget.calendarSize.height ?? MediaQuery.of(context).size.height;
    if (height < 667.0) {
      return 0.0; // iphone 5s
    } else if (height == 667.0) {
      return 80.0; // iphone SE
    } else if (height <= 812.0) {
      return 250.0; // iphone X, 11, 12 etc.
    } else {
      return 280.0; // iphone 11 Max, 12 Max etc.
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final months = [
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
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  _controller.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: widget.previousIcon ??
                    Icon(
                      Icons.arrow_left_rounded,
                      size: 50,
                    ),
              ),
              Text(
                '${months[_currentDate.month - 1]} ${_currentDate.year}',
                style: widget.headerStyle ?? textTheme.headline6,
              ),
              InkWell(
                onTap: () {
                  _controller.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: widget.nextIcon ??
                    Icon(
                      Icons.arrow_right_rounded,
                      size: 50,
                    ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            color: widget.weekdaysBackgroundColor ?? Color(0xff509D56),
            child: Row(
              children: <Widget>[
                for (String day in _weekDays)
                  SizedBox(
                    width: _itemWidth,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        day,
                        style: widget.weekdaysHeaderTextStyle ?? textTheme.bodyText2.copyWith(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: MonthPageView(
              onPageChanged: (index) {
                int month = _currentDate.month;
                if (index > _previousIndex) {
                  month += index - _previousIndex;
                } else if (index < _previousIndex) {
                  month -= _previousIndex - index;
                }
                setState(() {
                  _previousIndex = index;
                  _currentDate = DateTime(_currentDate.year, month, 1);
                });
              },
              controller: _controller,
              size: Size(_itemWidth, _itemHeight),
              date: _currentDate,
              onMoreEventsTapped: widget.onMoreEventsTapped,
              moreEventsBackgroundColor: widget.moreEventsBackgroundColor,
              moreEventsBannerTextStyle: widget.moreEventsBannerTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
