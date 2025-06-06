import 'package:flutter/material.dart';
import '../models/schedule.dart';

class ScheduleList extends StatelessWidget {
  final List<Schedule> schedules;
  final void Function(Schedule) onDelete; // 🔹 삭제 콜백 추가

  const ScheduleList({
    super.key,
    required this.schedules,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: schedules.map((schedule) {
        return ListTile(
          title: Text(schedule.title),
          subtitle: Text('${schedule.place} - ${schedule.time.format(context)}'),
   
