import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../models/schedule.dart';
import '../services/map_service.dart';

class ScheduleList extends StatelessWidget {
  final List<Schedule> schedules;
  final void Function(Schedule) onDelete;

  final void Function(Schedule) onEdit;

  const ScheduleList({
    super.key,
    required this.schedules,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: schedules.map((schedule) {
        return ListTile(
          title: Text(schedule.title),
          subtitle: Text('${schedule.place} - ${schedule.time.format(context)}'),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => onDelete(schedule), // 🔸 삭제 동작 연결
          ),
        );
      }).toList(),
    );
  }
}
