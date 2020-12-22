import 'dart:io';
import 'dart:ui';
import 'package:event_calendar/month_pageview.dart';
import 'package:event_calendar/calendar_utils.dart';
import 'package:flutter/material.dart';

class EventCalendar extends StatefulWidget {
  final List<String> weekDays;
  final Size calendarSize;
  final Widget previous;
  final Widget next;
  final TextStyle headerStyle;
  EventCalendar({
    this.weekDays,
    this.calendarSize,
    this.previous,
    this.next,
    this.headerStyle,
  });
  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> with SingleTickerProviderStateMixin {
  List<String> _weekDays;
  double _itemHeight;
  double _itemWidth;
  DateTime _currentDate = DateTime.now();
  PageController _controller;
  int _prevIndex = 12;

  @override
  void initState() {
    _controller = PageController(
      initialPage: _prevIndex,
      keepPage: false,
      viewportFraction: 1.0,
    );

    final size = widget.calendarSize ?? MediaQuery.of(context).size;
    _itemHeight = (size.height - kBottomNavigationBarHeight - kToolbarHeight - (Platform.isAndroid ? 120 : 280)) /
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
                child: widget.previous ??
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
                child: widget.next ??
                    Icon(
                      Icons.arrow_right_rounded,
                      size: 50,
                    ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            color: Color(0xff509D56),
            child: Row(
              children: <Widget>[
                for (String day in _weekDays)
                  SizedBox(
                    width: _itemWidth,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        day,
                        style: textTheme.bodyText2.copyWith(color: Colors.white),
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
                if (index > _prevIndex) {
                  month += index - _prevIndex;
                } else if (index < _prevIndex) {
                  month -= _prevIndex - index;
                }
                setState(() {
                  _prevIndex = index;
                  _currentDate = DateTime(_currentDate.year, month, 1);
                });
              },
              controller: _controller,
              size: Size(_itemWidth, _itemHeight),
              date: _currentDate,
            ),
          ),
        ],
      ),
    );
  }
}
