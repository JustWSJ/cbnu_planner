//  일정 입력 폼
import 'package:flutter/material.dart';

class ScheduleForm extends StatelessWidget {
  final TextEditingController titleController;
  final String? selectedZone;
  final String? selectedBuilding;
  final Map<String, List<String>> buildingsByZone;
  final TimeOfDay? selectedTime;
  final VoidCallback onPickTime;
  final Function(String?) onZoneChanged;
  final Function(String?) onBuildingChanged;
  final VoidCallback onSubmit;

  const ScheduleForm({
    super.key,
    required this.titleController,
    required this.selectedZone,
    required this.selectedBuilding,
    required this.buildingsByZone,
    required this.selectedTime,
    required this.onPickTime,
    required this.onZoneChanged,
    required this.onBuildingChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: titleController,
          decoration: const InputDecoration(labelText: '일정 제목'),
        ),
        const SizedBox(height: 12),
        DropdownButton<String>(
          hint: const Text('구역 선택'),
          value: selectedZone,
          items: buildingsByZone.keys
              .map((z) => DropdownMenuItem(value: z, child: Text(z)))
              .toList(),
          onChanged: onZoneChanged,
        ),
        const SizedBox(height: 12),
        DropdownButton<String>(
          hint: const Text('건물 선택'),
          value: selectedBuilding,
          items: (selectedZone != null
                  ? buildingsByZone[selectedZone] ?? []
                  : [])
              .map((b) => DropdownMenuItem(value: b, child: Text(b)))
              .toList(),
          onChanged: onBuildingChanged,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ElevatedButton(onPressed: onPickTime, child: const Text('시간 선택')),
            const SizedBox(width: 16),
            Text(
              selectedTime != null ? selectedTime!.format(context) : '시간 미선택',
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: onSubmit, child: const Text('일정 추가')),
      ],
    );
  }
}