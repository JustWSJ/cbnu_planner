//  일정 리스트 보기
import 'package:flutter/material.dart';
import '../models/schedule.dart';

class ScheduleList extends StatelessWidget {
  final List<Schedule> schedules;

  const ScheduleList({super.key, required this.schedules});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          final schedule = schedules[index];
          return ListTile(
            leading: const Icon(Icons.event_note),
            title: Text(schedule.title),
            subtitle: Text(
              '${schedule.place} - ${schedule.time.format(context)}',
            ),
          );
        },
      ),
    );
  }
}
