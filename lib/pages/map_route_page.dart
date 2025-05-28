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

  List<Marker> _createMarkers(List<Schedule> sortedSchedules, List<LatLng> points) {
    final markers = <Marker>[];

    if (currentLocation != null) {
      markers.add(
        Marker(
          point: currentLocation!,
          width: 40,
          height: 40,
          child: const Icon(Icons.my_location, color: Colors.blue, size: 36),
        ),
      );
    }

    for (int i = 0; i < sortedSchedules.length; i++) {
      final point = points[currentLocation != null ? i + 1 : i];
      markers.add(
        Marker(
          point: point,
          width: 80,
          height: 80,
          child: Column(
            children: [
              const Icon(Icons.location_on, color: Colors.red, size: 36),
              Text('${i + 1}', style: const TextStyle(fontSize: 12)),
              Text(sortedSchedules[i].title, style: const TextStyle(fontSize: 10)),
            ],
          ),
        ),
      );
    }

    return markers;
  }

  
}