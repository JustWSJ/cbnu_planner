import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/schedule.dart';

class ScheduleStorage {
  static const String _key = 'schedules';

  static Future<void> saveSchedules(List<Schedule> schedules) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> data = schedules.map((s) => jsonEncode(s.toMap())).toList();
    await prefs.setStringList(_key, data);
  }
}