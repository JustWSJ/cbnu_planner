import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cbnu_planner/features/schedule/services/schedule_storage.dart';
import 'package:cbnu_planner/features/schedule/models/schedule.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('save and load schedules', () async {
    SharedPreferences.setMockInitialValues({});
    final schedules = [
      Schedule(
        title: 't1',
        zone: 'N',
        place: 'place',
        time: const TimeOfDay(hour: 9, minute: 0),
      )
    ];

    await ScheduleStorage.saveSchedules(schedules);
    final loaded = await ScheduleStorage.loadSchedules();
    expect(loaded.length, 1);
    expect(loaded.first.title, 't1');
  });
}