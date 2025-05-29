//  일정 입력 화면
import 'package:flutter/material.dart';
import '../models/schedule.dart';
import '../widgets/schedule_form.dart';
import '../widgets/schedule_list.dart';
import '../utils/building_data.dart';
import 'package:cbnu_planner/pages/map_route_page.dart'; 


class ScheduleInputPage extends StatefulWidget {
  const ScheduleInputPage({super.key});

  @override
  State<ScheduleInputPage> createState() => _ScheduleInputPageState();
}

class _ScheduleInputPageState extends State<ScheduleInputPage> {
  final TextEditingController _titleController = TextEditingController();
  TimeOfDay? _selectedTime;
  String? _selectedBuilding;
  final List<Schedule> _schedules = [];

  void _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  void _submitSchedule() {
    if (_titleController.text.isEmpty ||
        _selectedBuilding == null ||
        _selectedTime == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('모든 항목을 입력해주세요')));
      return;
    }

    setState(() {
      _schedules.add(
        Schedule(
          title: _titleController.text,
          place: _selectedBuilding!,
          time: _selectedTime!,
        ),
      );
      _titleController.clear();
      _selectedTime = null;
      _selectedBuilding = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('일정 입력')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ScheduleForm(
              titleController: _titleController,
              selectedBuilding: _selectedBuilding,
              buildings: buildingList.map((b) => b.name).toList(),
              selectedTime: _selectedTime,
              onPickTime: _pickTime,
              onBuildingChanged:
                  (value) => setState(() => _selectedBuilding = value),
              onSubmit: _submitSchedule,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapRoutePage(schedules: _schedules),
                  ),
                );
              },
              child: const Text('지도 보기'),
            ),
            const SizedBox(height: 20),
            ScheduleList(schedules: _schedules),
          ],
        ),
      ),
    );
  }
}
