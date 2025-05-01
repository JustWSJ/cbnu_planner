import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/schedule.dart';
import '../services/map_service.dart';
import '../utils/building_data.dart';

class MapPage extends StatelessWidget {
  final List<Schedule> schedules;

  const MapPage({super.key, required this.schedules});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('캠퍼스 지도')),
      body: FlutterMap(
        options: MapOptions(center: LatLng(36.6282, 127.4562), zoom: 16.0),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.campus_schedule_manager',
          ),
          MarkerLayer(
            markers:
                schedules.map((schedule) {
                  final coords = MapService.getBuildingCoordinates(
                    schedule.place,
                    buildingList,
                  );
                  return Marker(
                    point: coords,
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 36,
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
