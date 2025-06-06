// 일정 입력 화면
import 'package:flutter/material.dart';
import '../models/schedule.dart';
import '../widgets/schedule_form.dart';
import '../widgets/schedule_list.dart';
import '../utils/building_data.dart';
import '../services/schedule_storage.dart';

class ScheduleInputPage extends StatefulWidget {
  const ScheduleInputPage({super.key});

  @override
  State<ScheduleInputPage> createState() => _ScheduleInputPageState();
}

class _ScheduleInputPageState extends State<ScheduleInputPage> {
  final TextEditingController _titleController = TextEditingController();
  TimeOfDay? _selectedTime;
  String? _selectedZone;
  String? _selectedBuilding;
  final List<Schedule> _schedules = [];
  int? _editingIndex;

  @override
  void initState() {
    super.initState();
    _loadSchedules();
  }

  Future<void> _loadSchedules() async {
    final loaded = await ScheduleStorage.loadSchedules();
    setState(() {
      _schedules.addAll(loaded);
    });
  }

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
        _selectedZone == null ||
        _selectedBuilding == null ||
        _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('모든 항목을 입력해주세요')),
      );
      return;
    }

    setState(() {
      final schedule = Schedule(
        title: _titleController.text,
        zone: _selectedZone!,
        place: _selectedBuilding!,
        time: _selectedTime!,
      );
      if (_editingIndex != null) {
        _schedules[_editingIndex!] = schedule;
        _editingIndex = null;
      } else {
        _schedules.add(schedule);
      }
      _titleController.clear();
      _selectedTime = null;
      _selectedZone = null;
      _selectedBuilding = null;
    });

    ScheduleStorage.saveSchedules(_schedules);
  }

  void _deleteSchedule(Schedule schedule) {
    setState(() {
      final idx = _schedules.indexOf(schedule);
      _schedules.removeAt(idx);
      if (_editingIndex != null) {
        if (_editingIndex == idx) {
          _editingIndex = null;
          _titleController.clear();
          _selectedTime = null;
          _selectedZone = null;
          _selectedBuilding = null;
        } else if (_editingIndex! > idx) {
          _editingIndex = _editingIndex! - 1;
        }
      }
    });
    ScheduleStorage.saveSchedules(_schedules);
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
              selectedZone: _selectedZone,
              selectedBuilding: _selectedBuilding,
              buildingsByZone: {
                for (var entry in categorizedBuildings.entries)
                  entry.key: entry.value.map((b) => b.name).toList()
              },
              selectedTime: _selectedTime,
              onPickTime: _pickTime,
              onZoneChanged: (value) => setState(() {
                _selectedZone = value;
                _selectedBuilding = null;
              }),
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
            ScheduleList(
              schedules: _schedules,
              onDelete: _deleteSchedule, // 🔥 삭제 콜백 연결
            ),
          ],
        ),
      ),
    );
  }
}