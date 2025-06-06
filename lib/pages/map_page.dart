import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/location_service.dart';

import '../models/schedule.dart';
import '../services/map_service.dart';
import '../utils/building_data.dart';

class MapPage extends StatefulWidget {
  final List<Schedule> schedules;

  const MapPage({super.key, required this.schedules});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? currentLocation;
    StreamSubscription<LatLng>? _positionStream; // 위치 스트림 저장

  @override
  void initState() {
    super.initState();
    _startTrackingLocation();
  }

  void _startTrackingLocation() {
    _positionStream = LocationService.locationStream().listen((location) {
      if (!mounted) return;
      setState(() => currentLocation = location);
    });
  }

  @override
  void dispose() {
    _positionStream?.cancel(); // 위치 추적 중지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('캠퍼스 지도')),
      body: FlutterMap(
        options: MapOptions(
          center: currentLocation ?? LatLng(36.6282, 127.4562),
          zoom: 17.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.campus_schedule_manager',
          ),

          // 🔵 현재 위치 마커
          if (currentLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: currentLocation!,
                  width: 50,
                  height: 50,
                  child: const Icon(Icons.my_location, color: Colors.blue, size: 40),
                ),
              ],
            ),

          // 🔴 일정 마커들
          MarkerLayer(
            markers: widget.schedules.map((schedule) {
              final coords = MapService.getBuildingCoordinates(
                schedule.zone,
                schedule.place,
              );
              return Marker(
                point: coords,
                width: 80,
                height: 80,
                child: const Icon(Icons.location_on, color: Colors.red, size: 36),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
