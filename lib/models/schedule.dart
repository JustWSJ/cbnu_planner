//  일정 데이터 모델
import 'package:flutter/material.dart';

class Schedule {
  final String title;
  final String zone;
  final String place;
  final TimeOfDay time;

  Schedule({
    required this.title,
    required this.zone,
    required this.place,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'zone': zone,
      'place': place,
      'hour': time.hour,
      'minute': time.minute,
    };
  }

   factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      title: map['title'] as String,
      zone: map['zone'] as String,
      place: map['place'] as String,
      time: TimeOfDay(hour: map['hour'] as int, minute: map['minute'] as int),
    );
  }
}
