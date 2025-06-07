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

  DateTime _convertToDateTime(TimeOfDay tod) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  }

  List<Schedule> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('캘린더 일정 보기')),
      body: Column(
        children: [
          TableCalendar<Schedule>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            eventLoader: _getEventsForDay,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedEvents = _getEventsForDay(selectedDay);
              });
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
            ),
          ),
