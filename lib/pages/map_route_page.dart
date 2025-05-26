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
}
