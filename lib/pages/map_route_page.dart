import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

import 'package:cbnu_planner/services/route_service.dart';
import 'package:cbnu_planner/utils/building_data.dart';
import 'package:cbnu_planner/models/schedule.dart';

class MapRoutePage extends StatefulWidget {
  final List<Schedule>? schedules;

  const MapRoutePage({super.key, this.schedules});

  @override
  State<MapRoutePage> createState() => _MapRoutePageState();
}

class _MapRoutePageState extends State<MapRoutePage> {
  LatLng start = LatLng(36.6283, 127.4545);
  List<LatLng> routePoints = [];
  double totalDistance = 0.0;
  int estimatedTime = 0;

  @override
  void initState() {
    super.initState();

    getCurrentLocation().then((userLocation) {
      setState(() {
        start = userLocation;
      });
      getRoute();
    }).catchError((e) {
      print('현재 위치 가져오기 실패: $e');
    });
  }

  Future<void> getRoute() async {
    List<LatLng> waypoints = [start];

    if (widget.schedules != null && widget.schedules!.isNotEmpty) {
      List<Schedule> sorted = List<Schedule>.from(widget.schedules!)
        ..sort((a, b) => a.time.hour.compareTo(b.time.hour));

      for (var s in sorted) {
        final building = buildingList.firstWhere(
          (b) => b.name == s.place,
          orElse: () => buildingList.first,
        );
        waypoints.add(building.location);
      }
    }

    final points = await RouteService.fetchRouteWithWaypoints(waypoints);

    double distance = 0.0;
    if (points.length >= 2) {
      final Distance calc = Distance();
      for (int i = 0; i < points.length - 1; i++) {
        distance += calc(points[i], points[i + 1]);
      }
    }

    setState(() {
      routePoints = points;
      totalDistance = distance;
      estimatedTime = (distance / 80).round();
    });
  }

  Future<LatLng> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("위치 서비스가 비활성화되어 있습니다.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("위치 권한이 거부되었습니다.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("위치 권한이 영구적으로 거부되었습니다.");
    }

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("도보 경로 시각화")),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(center: start, zoom: 16.0),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: [
                    if (routePoints.isNotEmpty)
                      Marker(
                        point: start,
                        width: 50,
                        height: 50,
                        child: const Icon(Icons.person_pin_circle, color: Colors.blue),
                      ),
                    for (int i = 1; i < routePoints.length; i++)
                      Marker(
                        point: routePoints[i],
                        width: 50,
                        height: 50,
                        child: const Icon(Icons.location_on, color: Colors.red),
                      ),
                  ],
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(points: routePoints, color: Colors.green, strokeWidth: 5.0),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              '총 거리: ${totalDistance.toStringAsFixed(1)} m / 예상 시간: ${estimatedTime}분',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
