// 통합된 단일 코드 - main.dart 하나로 모든 기능 포함

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const CBNUPlannerApp());
}

class CBNUPlannerApp extends StatelessWidget {
  const CBNUPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CBNU Planner',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ScheduleInputPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Schedule {
  final String title;
  final String place;
  final TimeOfDay time;

  Schedule({required this.title, required this.place, required this.time});

  Map<String, dynamic> toJson() => {
        'title': title,
        'place': place,
        'hour': time.hour,
        'minute': time.minute,
      };

  static Schedule fromJson(Map<String, dynamic> json) => Schedule(
        title: json['title'],
        place: json['place'],
        time: TimeOfDay(hour: json['hour'], minute: json['minute']),
      );
}

class Building {
  final String name;
  final LatLng location;
  Building({required this.name, required this.location});
}

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

  final List<Building> buildingList = [
    Building(name: '도서관', location: LatLng(36.627653, 127.457817)),
    Building(name: '자연과학대학본관(S1-1)', location: LatLng(36.627764, 127.456824)),
    Building(name: '자연대2호관(S1-2)', location: LatLng(36.627166, 127.456904)),
    Building(name: '공과대학1호관', location: LatLng(36.629000, 127.457000)),
  ];

  @override
  void initState() {
    super.initState();
    _loadSchedules();
  }

  void _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) setState(() => _selectedTime = picked);
  }

  void _submitSchedule() {
    if (_titleController.text.isEmpty || _selectedBuilding == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('모든 항목을 입력해주세요')));
      return;
    }
    final newSchedule = Schedule(
      title: _titleController.text,
      place: _selectedBuilding!,
      time: _selectedTime!,
    );
    setState(() {
      _schedules.add(newSchedule);
      _titleController.clear();
      _selectedTime = null;
      _selectedBuilding = null;
    });
    _saveSchedules();
  }

  Future<void> _saveSchedules() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_schedules.map((s) => s.toJson()).toList());
    await prefs.setString('schedules', encoded);
  }

  Future<void> _loadSchedules() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('schedules');
    if (raw != null) {
      final decoded = jsonDecode(raw);
      final loaded = (decoded as List).map((e) => Schedule.fromJson(e)).toList();
      setState(() => _schedules.addAll(loaded));
    }
  }

  void _clearSchedules() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('schedules');
    setState(() => _schedules.clear());
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
            DropdownButton<String>(
              hint: const Text('건물 선택'),
              value: _selectedBuilding,
              items: buildingList.map((b) => DropdownMenuItem(value: b.name, child: Text(b.name))).toList(),
              onChanged: (value) => setState(() => _selectedBuilding = value),
            ),
            Row(
              children: [
                ElevatedButton(onPressed: _pickTime, child: const Text('시간 선택')),
                const SizedBox(width: 16),
                Text(_selectedTime != null ? _selectedTime!.format(context) : '시간 미선택'),
              ],
            ),
            ElevatedButton(onPressed: _submitSchedule, child: const Text('일정 추가')),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapRoutePage(schedules: _schedules, buildingList: buildingList),
                ),
              ),
              child: const Text('경로 보기'),
            ),
            ElevatedButton(onPressed: _clearSchedules, child: const Text('초기화')),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _schedules.length,
                itemBuilder: (context, index) {
                  final s = _schedules[index];
                  return ListTile(title: Text('${s.title} (${s.place}) - ${s.time.format(context)}'));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MapRoutePage extends StatefulWidget {
  final List<Schedule> schedules;
  final List<Building> buildingList;

  const MapRoutePage({super.key, required this.schedules, required this.buildingList});

  @override
  State<MapRoutePage> createState() => _MapRoutePageState();
}

class _MapRoutePageState extends State<MapRoutePage> {
  LatLng? currentLocation;

  @override
  void initState() {
    super.initState();
    _setCurrentLocation();
  }

  Future<void> _setCurrentLocation() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      setState(() => currentLocation = LatLng(pos.latitude, pos.longitude));
    }
  }

  List<LatLng> _getRoutePoints() {
    final points = widget.schedules.map((s) {
      final b = widget.buildingList.firstWhere((b) => b.name == s.place, orElse: () => Building(name: '', location: LatLng(0, 0)));
      return (b.location.latitude != 0 && b.location.longitude != 0) ? b.location : null;
    }).whereType<LatLng>().toList();
    if (currentLocation != null) points.insert(0, currentLocation!);
    return points;
  }

  @override
  Widget build(BuildContext context) {
    final points = _getRoutePoints();
    return Scaffold(
      appBar: AppBar(title: const Text('경로 보기')),
      body: FlutterMap(
        options: MapOptions(center: points.isNotEmpty ? points.first : LatLng(36.6282, 127.4562), zoom: 17.0),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.cbnu_planner',
          ),
          if (points.length >= 2)
            PolylineLayer(
              polylines: [
                Polyline(points: points, strokeWidth: 4.0, color: Colors.blueAccent),
              ],
            ),
          MarkerLayer(
            markers: points
                .map((p) => Marker(
                      point: p,
                      width: 40,
                      height: 40,
                      child: const Icon(Icons.location_on, color: Colors.red),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
