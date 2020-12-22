import 'package:flutter/material.dart';

class DayContainer extends StatelessWidget {
  const DayContainer({
    this.day,
    this.eventWidgets,
    this.currentMonthDate,
    this.width,
    this.height = 158,
  });

  final DateTime day;
  final List<Widget> eventWidgets;
  final DateTime currentMonthDate;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.grey[300], width: 0.35),
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
    this.currentMonthDate,
    this.date,
  });
  final DateTime currentMonthDate;
  final int date;

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
        color: isToday ? Color(0xff509D56) : Colors.transparent,
      ),
      child: Center(
        child: Text(
          '$date',
          style: textTheme.headline4.copyWith(
            color: isToday ? Colors.white : Colors.black,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
