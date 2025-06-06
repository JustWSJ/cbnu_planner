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
      children: List.generate(schedules.length, (index) {
        final schedule = schedules[index];
        final travelTime = _calculateTravelTime(index);
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            title: Text(schedule.title),
            subtitle: Text(
              '${schedule.time.format(context)} | 이동 ${travelTime}분',
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') onEdit(schedule);
                if (value == 'delete') onDelete(schedule);
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'edit', child: Text('수정')),
                PopupMenuItem(value: 'delete', child: Text('삭제')),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
