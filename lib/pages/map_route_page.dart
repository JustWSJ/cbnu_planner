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
}
