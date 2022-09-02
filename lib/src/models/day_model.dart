import 'package:flutter/material.dart';

class DayModel {
  DayModel({
    required this.dayStringValue,
    this.textStyle,
  });

  final String dayStringValue;
  final TextStyle? textStyle;
}
