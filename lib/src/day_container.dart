import 'package:flutter/material.dart';

class DayContainer extends StatelessWidget {
  const DayContainer({
    required this.onTap,
    required this.day,
    required this.eventWidgets,
    required this.currentMonthDate,
    required this.width,
    this.height = 158,
    // New Properties
    this.borderColor,
    this.currentDateColor,
    this.dateTextStyle,
  });

  final DateTime day;
  final List<Widget> eventWidgets;
  final DateTime currentMonthDate;
  final double width;
  final double height;
  final Function(DateTime day) onTap;

  // New Properties
  final Color? borderColor;
  final Color? currentDateColor;
  final TextStyle? dateTextStyle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: borderColor ?? Colors.grey[300]!, width: 0.35),
          color: Colors.white,
        ),
        width: width,
        height: height,
        padding: EdgeInsets.only(top: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _DateWidget(
              date: day.day,
              currentMonthDate: currentMonthDate,
              currentDateColor: currentDateColor,
              dateTextStyle: dateTextStyle,
            ),
            ...eventWidgets
                .map((event) => Column(
                      children: [
                        event,
                        SizedBox(height: 5),
                      ],
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}

class _DateWidget extends StatelessWidget {
  const _DateWidget({
    required this.currentMonthDate,
    required this.date,
    this.currentDateColor,
    this.dateTextStyle,
  });

  final DateTime currentMonthDate;
  final int date;
  final Color? currentDateColor;
  final TextStyle? dateTextStyle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    DateTime now = DateTime.now();
    bool isToday = (now.day == date && now.month == currentMonthDate.month && now.year == currentMonthDate.year);
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isToday ? currentDateColor ?? Color(0xff509D56) : Colors.transparent,
      ),
      child: Center(
        child: Text(
          '$date',
          style: dateTextStyle?.copyWith(color: isToday ? Colors.white : Colors.black) ??
              textTheme.headline4!.copyWith(
                color: isToday ? Colors.white : Colors.black,
                fontSize: 13,
              ),
        ),
      ),
    );
  }
}
