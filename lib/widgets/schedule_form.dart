//  일정 입력 폼
import 'package:flutter/material.dart';

class ScheduleForm extends StatelessWidget {
  final TextEditingController titleController;
  final String? selectedBuilding;
  final List<String> buildings;
  final TimeOfDay? selectedTime;
  final VoidCallback onPickTime;
  final Function(String?) onBuildingChanged;
  final VoidCallback onSubmit;

  const ScheduleForm({
    super.key,
    required this.titleController,
    required this.selectedBuilding,
    required this.buildings,
    required this.selectedTime,
    required this.onPickTime,
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
          hint: const Text('건물 선택'),
          value: selectedBuilding,
          items:
              buildings
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
