// 일정 입력 화면
import 'dart:async';
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
  Timer? _cleanupTimer;

  @override
  void initState() {
    super.initState();
    _loadSchedules();
    _cleanupTimer =
        Timer.periodic(const Duration(minutes: 1), (_) => _removeExpiredSchedules());
  }

  @override
  void dispose() {
    _cleanupTimer?.cancel();
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _loadSchedules() async {
    final loaded = await ScheduleStorage.loadSchedules();
    setState(() {
      _schedules.addAll(loaded);
    });
    _removeExpiredSchedules();
    _sortSchedules();
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
    _removeExpiredSchedules();
    _sortSchedules();
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
  _sortSchedules();
  }

  void _removeExpiredSchedules() {
    final now = TimeOfDay.now();
    final nowMinutes = now.hour * 60 + now.minute;
    setState(() {
      _schedules.removeWhere((s) {
        final sMinutes = s.time.hour * 60 + s.time.minute;
        return sMinutes < nowMinutes;
      });
    });
    ScheduleStorage.saveSchedules(_schedules);
    _sortSchedules();
  }

  void _sortSchedules() {
    _schedules.sort((a, b) {
      final aMinutes = a.time.hour * 60 + a.time.minute;
      final bMinutes = b.time.hour * 60 + b.time.minute;
      return aMinutes.compareTo(bMinutes);
    });
  }

  void _editSchedule(Schedule schedule) {
    setState(() {
      _editingIndex = _schedules.indexOf(schedule);
      _titleController.text = schedule.title;
      _selectedZone = schedule.zone;
      _selectedBuilding = schedule.place;
      _selectedTime = schedule.time;
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
              submitText: _editingIndex != null ? '수정 완료' : '일정 추가',
            ),
            const SizedBox(height: 20),
            ScheduleList(
              schedules: _schedules,
              onDelete: _deleteSchedule,
              onEdit: _editSchedule,
            ),
          ],
        ),
      ),
    );
  }
}