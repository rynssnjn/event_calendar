import 'dart:io';

import 'package:event_calendar/src/models/day_model.dart';
import 'package:event_calendar/src/models/calendar_holder.dart';
import 'package:event_calendar/src/models/event_model.dart';
import 'package:event_calendar/src/month_pageview.dart';
import 'package:event_calendar/src/utilities/typedefs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EventCalendar extends StatefulWidget {
  EventCalendar({
    required this.holder,
    this.onMoreEventsTapped,
    this.events,
    this.previousIcon,
    this.nextIcon,
    this.headerStyle,
    this.moreEventsBannerTextStyle,
    this.weekdaysHeaderTextStyle,
    this.weekdaysBackgroundColor,
    this.moreEventsBackgroundColor,
    this.calendarSize,
    this.divisor,
    // New Properties
    this.onLeftChevronTapped,
    this.onRightChevronTapped,
    this.pageController,
    this.isLeftChevronVisible = true,
    this.isRightChevronVisible = true,
    this.headerSubtitle,
    this.dateBorderColor,
    this.currentDateColor,
    this.dateTextStyle,
    this.initialDate,
    this.horizontalScrollPhysics,
  });

  final VoidCallback? onMoreEventsTapped;
  final List<EventModel>? events;
  final Widget? previousIcon;
  final Widget? nextIcon;
  final TextStyle? headerStyle;
  final TextStyle? moreEventsBannerTextStyle;
  final TextStyle? weekdaysHeaderTextStyle;
  final Color? weekdaysBackgroundColor;
  final Color? moreEventsBackgroundColor;
  final Size? calendarSize;
  final double? divisor;

  // New Properties
  final OnChangeMonth? onLeftChevronTapped;
  final OnChangeMonth? onRightChevronTapped;
  final PageController? pageController;
  final bool isLeftChevronVisible;
  final bool isRightChevronVisible;
  final Widget? headerSubtitle;
  final Color? dateBorderColor;
  final Color? currentDateColor;
  final TextStyle? dateTextStyle;
  final DateTime? initialDate;
  final ScrollPhysics? horizontalScrollPhysics;
  final CalendarHolder holder;

  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> with SingleTickerProviderStateMixin {
  late List<DayModel> _weekDays;
  late DateTime _currentDate;
  late PageController _controller;
  int _previousIndex = 12;

  @override
  void initState() {
    EventModel.setEventList(widget.events!);
    _currentDate = widget.initialDate ?? DateTime.now();

    _controller = widget.pageController ??
        PageController(
          initialPage: _previousIndex,
          keepPage: false,
          viewportFraction: 1.0,
        );

    _weekDays = widget.holder.days;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get _subtrahend {
    if (kIsWeb) {
      return 0.0;
    } else {
      return Platform.isAndroid ? 120 : _iosSize;
    }
  }

  double get _iosSize {
    final height = widget.calendarSize?.height ?? MediaQuery.of(context).size.height;
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

    final size = widget.calendarSize ?? MediaQuery.of(context).size;

    final itemHeight =
        (size.height - kBottomNavigationBarHeight - kToolbarHeight - _subtrahend) / (widget.divisor ?? 4);
    final itemWidth = size.width / 7;

    return LayoutBuilder(
      builder: (_, __) => Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: widget.isLeftChevronVisible,
                  child: InkWell(
                    onTap: () {
                      if (widget.onLeftChevronTapped != null) {
                        widget.onLeftChevronTapped!();
                        return;
                      }
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
                ),
                Text(
                  '${widget.holder.calendarMonths[_currentDate.month - 1]} ${_currentDate.year}',
                  style: widget.headerStyle ?? textTheme.headline6,
                ),
                Visibility(
                  visible: widget.isRightChevronVisible,
                  child: InkWell(
                    onTap: () {
                      if (widget.onRightChevronTapped != null) {
                        widget.onRightChevronTapped!();
                        return;
                      }
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
                ),
              ],
            ),
            if (widget.headerSubtitle != null) widget.headerSubtitle!,
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              color: widget.weekdaysBackgroundColor ?? Color(0xff509D56),
              child: Row(
                children: <Widget>[
                  for (DayModel day in _weekDays)
                    Expanded(
                      child: SizedBox(
                        width: itemWidth,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            day.dayStringValue,
                            style: day.textStyle ??
                                widget.weekdaysHeaderTextStyle ??
                                textTheme.bodyText2!.copyWith(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ),
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
                size: Size(itemWidth, itemHeight),
                date: _currentDate,
                onMoreEventsTapped: widget.onMoreEventsTapped,
                moreEventsBackgroundColor: widget.moreEventsBackgroundColor,
                moreEventsBannerTextStyle: widget.moreEventsBannerTextStyle,
                dateBorderColor: widget.dateBorderColor,
                currentDateColor: widget.currentDateColor,
                dateTextStyle: widget.dateTextStyle,
                physics: widget.horizontalScrollPhysics,
                holder: widget.holder,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
