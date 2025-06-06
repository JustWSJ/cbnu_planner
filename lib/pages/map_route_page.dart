import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/location_service.dart';

import 'package:cbnu_planner/services/route_service.dart';
import 'package:cbnu_planner/utils/building_data.dart';
import 'package:cbnu_planner/models/schedule.dart';
import '../services/map_service.dart';
import '../services/schedule_storage.dart';

class MapRoutePage extends StatefulWidget {
  final List<Schedule>? schedules;

  const MapRoutePage({super.key, this.schedules});

  @override
  State<MapRoutePage> createState() => _MapRoutePageState();
}

class _MapRoutePageState extends State<MapRoutePage> {
  LatLng? start;
  List<LatLng> routePoints = [];
  double totalDistance = 0.0;
  int estimatedTime = 0;
  List<Schedule> schedules = [];

  @override
  void initState() {
    super.initState();

    if (widget.schedules != null) {
      schedules = List<Schedule>.from(widget.schedules!);
    } else {
      ScheduleStorage.loadSchedules().then((value) {
        setState(() {
          schedules = value;
        });
        _tryGetRoute();
      });
    }

    LocationService.getCurrentLocation().then((userLocation) {
      setState(() {
        start = userLocation;
      });
      _tryGetRoute();
    }).catchError((e) {
      print('현재 위치 가져오기 실패: $e');
    });
  }

  void _tryGetRoute() {
    if (start != null) {
      getRoute();
    }
  }

  Future<void> getRoute() async {
    if (start == null) return;

    List<LatLng> waypoints = [start!];

    if (schedules.isNotEmpty) {
      List<Schedule> sorted = List<Schedule>.from(schedules)
        ..sort((a, b) => a.time.hour.compareTo(b.time.hour));

      for (var s in sorted) {
        final coord = MapService.getBuildingCoordinates(
          s.zone,
          s.place,
        );
        waypoints.add(coord);
      }
    }

    if (waypoints.length < 2) {
      setState(() {
        routePoints = [];
        totalDistance = 0.0;
        estimatedTime = 0;
      });
      return;
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
      estimatedTime = (distance / 80).round(); // 도보 기준 약 80 m/min
    });
  }

  int _calculateTravelTime(int index) {
    if (start == null) return 0;
    LatLng from;
    if (index == 0) {
      from = start!;
    } else {
      final prev = schedules[index - 1];
      from = MapService.getBuildingCoordinates(prev.zone, prev.place);
    }
    final curr = schedules[index];
    final currCoord = MapService.getBuildingCoordinates(curr.zone, curr.place);
    final distance = const Distance()(from, currCoord);
    return (distance / 80).round();
  }

  @override
  Widget build(BuildContext context) {
    if (start == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("지도")),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(center: start!, zoom: 16.0),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: [
                    // 🔵 현재 위치
                    Marker(
                      point: start!,
                      width: 50,
                      height: 50,
                      child: const Icon(Icons.person_pin_circle, color: Colors.blue),
                    ),
                    // 🔴 일정 목적지 마커 + 이름/이동시간
                    if (schedules.isNotEmpty)
                      ...List.generate(schedules.length, (index) {
                        final schedule = schedules[index];
                        final coord = MapService.getBuildingCoordinates(
                          schedule.zone,
                          schedule.place,
                        );
                        final travelTime = _calculateTravelTime(index);
                        return Marker(
                          point: coord,
                          width: 120,
                          height: 80,
                          child: Column(
                            children: [
                              const Icon(Icons.location_on, color: Colors.red),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '${schedule.place}\n${travelTime}분',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
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
              '총 거리: ${totalDistance.toStringAsFixed(1)} m / 이동 예상 시간: ${estimatedTime}분',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
