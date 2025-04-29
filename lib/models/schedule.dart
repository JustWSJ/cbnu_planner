//  일정 데이터 모델
import 'package:flutter/material.dart';

class Schedule {
  final String title;
  final String place;
  final TimeOfDay time;

  Schedule({required this.title, required this.place, required this.time});
}
