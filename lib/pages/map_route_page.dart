import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/schedule.dart';
import '../services/map_service.dart';
import '../utils/building_data.dart';

class MapRoutePage extends StatelessWidget {
  final List<Schedule> schedules;

  const MapRoutePage({super.key, required this.schedules});

  /// 일정 리스트를 시간순으로 정렬
  List<Schedule> _getSortedSchedules() {
    final sorted = [...schedules];
    sorted.sort((a, b) {
      final aTime = a.time.hour * 60 + a.time.minute;
      final bTime = b.time.hour * 60 + b.time.minute;
      return aTime.compareTo(bTime);
    });
    return sorted;
  }

  /// 일정 리스트를 좌표 리스트로 변환
  List<LatLng> _getCoordinates(List<Schedule> sortedSchedules) {
    return sortedSchedules.map((s) {
      final coord = MapService.getBuildingCoordinates(s.place, buildingList);
      print('📍 ${s.place} → $coord');
      return coord;
    }).toList();
  }

  /// 마커 리스트 생성
  List<Marker> _buildMarkers(
      List<Schedule> sortedSchedules, List<LatLng> points) {
    return points.asMap().entries.map((entry) {
      final index = entry.key;
      final point = entry.value;
      final title = sortedSchedules[index].title;
      return Marker(
        width: 80,
        height: 80,
        point: point,
        child: Column(
          children: [
            const Icon(Icons.location_on, color: Colors.red, size: 36),
            Text('${index + 1}', style: const TextStyle(fontSize: 12)),
            Text(title, style: const TextStyle(fontSize: 10)),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final sortedSchedules = _getSortedSchedules();
    final points = _getCoordinates(sortedSchedules);

    print('📏 경로 좌표 개수: ${points.length}');
    print('📏 경로 좌표 목록: $points');

    return Scaffold(
      appBar: AppBar(title: const Text('이동 경로 보기')),
      body: FlutterMap(
        options: MapOptions(
          center: points.isNotEmpty ? points.first : LatLng(36.6282, 127.4562),
          zoom: 17.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.cbnu_planner',
          ),
          if (points.length >= 2)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: points,
                  strokeWidth: 4.0,
                  color: Colors.blueAccent,
                ),
              ],
            ),
          MarkerLayer(
            markers: _buildMarkers(sortedSchedules, points),
          ),
        ],
      ),
    );
  }
}
