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
  final String submitText;

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
    this.submitText = '일정 추가',
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
              .map<DropdownMenuItem<String>>(
                  (z) => DropdownMenuItem<String>(value: z, child: Text(z)))
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
              .map<DropdownMenuItem<String>>(
                  (b) => DropdownMenuItem<String>(value: b, child: Text(b)))
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
        ElevatedButton(onPressed: onSubmit, child: Text(submitText)),
      ],
    );
  }
}
