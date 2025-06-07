import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cbnu_planner/features/schedule/models/schedule.dart';

void main() {
  test('toMap and fromMap work correctly', () {
    final schedule = Schedule(
      title: 'test',
      zone: 'N',
      place: 'place',
      time: const TimeOfDay(hour: 8, minute: 30),
    );

    final map = schedule.toMap();
    final recreated = Schedule.fromMap(map);
    expect(recreated.title, schedule.title);
    expect(recreated.zone, schedule.zone);
    expect(recreated.place, schedule.place);
    expect(recreated.time.hour, schedule.time.hour);
    expect(recreated.time.minute, schedule.time.minute);
  });
}