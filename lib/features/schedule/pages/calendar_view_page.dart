import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/schedule.dart';
import '../services/schedule_storage.dart';

class CalendarViewPage extends StatefulWidget {
  const CalendarViewPage({super.key});

  @override
  State<CalendarViewPage> createState() => _CalendarViewPageState();
}

class _CalendarViewPageState extends State<CalendarViewPage> {
  late Map<DateTime, List<Schedule>> _events;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Schedule> _selectedEvents = [];

  @override
  void initState() {
    super.initState();
    _events = {};
    _loadSchedules();
  }

  Future<void> _loadSchedules() async {
    final schedules = await ScheduleStorage.loadSchedules();
    Map<DateTime, List<Schedule>> grouped = {};

    for (var s in schedules) {
      final dt = _convertToDateTime(s.time);
      final dateKey = DateTime(dt.year, dt.month, dt.day);
      grouped.putIfAbsent(dateKey, () => []).add(s);
    }

    setState(() {
      _events = grouped;
      _selectedDay = _focusedDay;
      _selectedEvents = _getEventsForDay(_selectedDay!);
    });
  }
