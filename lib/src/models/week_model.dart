import 'package:flutter/material.dart';

class WeekModel {
  const WeekModel({
    this.stackWidgets,
    this.dayViewWidgets,
  });

  final List<Widget> stackWidgets;
  final List<Widget> dayViewWidgets;
}
