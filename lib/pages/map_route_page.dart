import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../models/schedule.dart';
import '../services/map_service.dart';
import '../utils/building_data.dart';

class MapRoutePage extends StatefulWidget {
  final List<Schedule> schedules;

  const MapRoutePage({super.key, required this.schedules});

  @override
  State<MapRoutePage> createState() => _MapRoutePageState();
}

class _MapRoutePageState extends State<MapRoutePage> {
  LatLng? currentLocation;

  @override
  void initState() {
    super.initState();
    _requestAndSetCurrentLocation();
  }

  Future<void> _requestAndSetCurrentLocation() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
      });
    }
  }

  List<Schedule> _sortSchedulesByTime() {
    final sorted = [...widget.schedules];
    sorted.sort((a, b) => (a.time.hour * 60 + a.time.minute)
        .compareTo(b.time.hour * 60 + b.time.minute));
    return sorted;
  }

  List<LatLng> _generateRoutePoints(List<Schedule> sortedSchedules) {
    final points = sortedSchedules.map((s) {
      final coord = MapService.getBuildingCoordinates(s.place, buildingList);
      debugPrint('📍 ${s.place} → $coord');
      return coord;
    }).toList();

    if (currentLocation != null) {
      points.insert(0, currentLocation!);
    }

    debugPrint('📏 경로 좌표 개수: ${points.length}');
    debugPrint('📏 경로 좌표 목록: $points');
    return points;
  }

  
}