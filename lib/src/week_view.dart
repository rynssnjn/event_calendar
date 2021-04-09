import 'package:event_calendar/src/models/week_model.dart';
import 'package:flutter/material.dart';

class WeekView extends StatelessWidget {
  const WeekView({this.week});

  final WeekModel week;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: week.dayViewWidgets,
        ),
        ...week.stackWidgets,
      ],
    );
  }
}
