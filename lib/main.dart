import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const CampusSchedulerApp());
}

class CampusSchedulerApp extends StatelessWidget {
  const CampusSchedulerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '스마트 캠퍼스 스케줄러 데모',
      home: const ScheduleInputScreen(),
    );
  }
}

class ScheduleInputScreen extends StatefulWidget {
  const ScheduleInputScreen({super.key});

  @override
  State<ScheduleInputScreen> createState() => _ScheduleInputScreenState();
}

class _ScheduleInputScreenState extends State<ScheduleInputScreen> {
  final TextEditingController _titleController = TextEditingController();
  TimeOfDay? _selectedTime;
  String? _selectedBuilding;

  final List<Map<String, dynamic>> _schedules = [];

  final List<String> _buildings = [
    '미래창조관',
    '전자정보대학',
    '도서관',
    '공과대학1호관',
    '공과대학2호관',
    '공과대학3호관',
    'N1',
    'N10',
    '학생회관',
    '자연과학대학',
    '농업생명환경대학',
    '사회과학대학',
    '사범대학',
    '경상대학',
    '생활과학대학',
    '수의과대학',
    '의과대학',
    '약학대학',
    '중앙도서관',
    '글로벌라운지'
  ];

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
    if (_titleController.text.isEmpty || _selectedBuilding == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('모든 항목을 입력해주세요')),
      );
      return;
    }

    setState(() {
      _schedules.add({
        'title': _titleController.text,
        'place': _selectedBuilding!,
        'time': _selectedTime!,
      });
      _titleController.clear();
      _selectedTime = null;
      _selectedBuilding = null;

      _schedules.sort((a, b) {
        final at = a['time'] as TimeOfDay;
        final bt = b['time'] as TimeOfDay;
        return at.hour != bt.hour ? at.hour - bt.hour : at.minute - bt.minute;
      });
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
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: '일정 제목'),
            ),
            const SizedBox(height: 12),
            DropdownButton<String>(
              hint: const Text('건물 선택'),
              value: _selectedBuilding,
              items: _buildings.map((b) => DropdownMenuItem(
                value: b,
                child: Text(b),
              )).toList(),
              onChanged: (value) => setState(() => _selectedBuilding = value),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _pickTime,
                  child: const Text('시간 선택'),
                ),
                const SizedBox(width: 16),
                Text(_selectedTime != null ? _selectedTime!.format(context) : '시간 미선택'),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _schedules.length,
                itemBuilder: (context, index) {
                  final schedule = _schedules[index];
                  return ListTile(
                    title: Text(schedule['title']),
                    subtitle: Text('${schedule['place']} / ${schedule['time'].format(context)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() => _schedules.removeAt(index));
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapPage(schedules: _schedules),
                  ),
                );
              },
              child: const Text('지도 보기'),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
            ),
          ],
        ),
      ),
    );
  }
}

class MapPage extends StatelessWidget {
  final List<Map<String, dynamic>> schedules;

  const MapPage({super.key, required this.schedules});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('캠퍼스 지도')),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(36.6282, 127.4562),
          zoom: 16.0,
          minZoom: 3.0,
          maxZoom: 18.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.campus_schedule_manager',
          ),
          MarkerLayer(
            markers: schedules.map((schedule) {
              final coords = _getLatLngForBuilding(schedule['place']);
              return Marker(
                point: coords,
                width: 80,
                height: 80,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.blue,
                  size: 36,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  LatLng _getLatLngForBuilding(String name) {
    switch (name) {
      case '미래창조관': return LatLng(36.628373, 127.456287);
      case '전자정보대학': return LatLng(36.628754, 127.459352);
      case '도서관': return LatLng(36.627653, 127.457817);
      default: return LatLng(36.6282, 127.4562);
    }
  }
}
