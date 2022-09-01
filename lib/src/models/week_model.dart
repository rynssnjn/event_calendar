import 'package:flutter/material.dart';

class WeekModel {
  const WeekModel({
    required this.stackWidgets,
    required this.dayViewWidgets,
  });

  final List<Widget> stackWidgets;
  final List<Widget> dayViewWidgets;
}
