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
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            highlightColor: Colors.red.withOpacity(0.3),
            splashColor: Colors.red.withOpacity(0.2),
            onTap: () {},
            child: ListTile(
              title: Text(schedule.title),
              subtitle: Text(
                '${schedule.time.format(context)} | 이동 예상 시간: ${travelTime}분',
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
          ),
        );
      }),
    );
  }
  
  int _calculateTravelTime(int index) {
    if (index == 0) return 0;
    final prev = schedules[index - 1];
    final curr = schedules[index];
    final prevCoord = MapService.getBuildingCoordinates(prev.zone, prev.place);
    final currCoord = MapService.getBuildingCoordinates(curr.zone, curr.place);
    final distance = const Distance()(prevCoord, currCoord);
    return (distance / 80).round();
  }
}
