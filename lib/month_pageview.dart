import 'package:event_calendar/month_view.dart';
import 'package:flutter/material.dart';

class MonthPageView extends StatelessWidget {
  const MonthPageView({
    @required this.onPageChanged,
    @required this.controller,
    this.size,
    this.date,
  });

  final Function(int) onPageChanged;
  final PageController controller;
  final Size size;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      onPageChanged: (index) => onPageChanged(index),
      itemBuilder: (_, __) {
        return MonthView(
          dayWidgetSize: size,
          currentMonthDate: date,
        );
      },
    );
  }
}
