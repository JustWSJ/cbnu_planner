import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cbnu_planner/utils/building_data.dart'; // 건물 좌표
import 'package:cbnu_planner/services/route_service.dart'; // 도보 경로 요청 함수
import 'package:geolocator/geolocator.dart';

class MapRoutePage extends StatefulWidget {
  final List<dynamic>? schedules; // 필요하면 전달받기

  const MapRoutePage({super.key, this.schedules});

  @override
  State<MapRoutePage> createState() => _MapRoutePageState();
}

class _MapRoutePageState extends State<MapRoutePage> {
  LatLng start = LatLng(36.6283, 127.4545);
  LatLng end = LatLng(36.6320, 127.4582);
  List<LatLng> routePoints = [];

  double totalDistance = 0.0;
  int estimatedTime = 0;

  @override
  void initState() {
    super.initState();

    end = buildingList.first.location;

    getCurrentLocation().then((userLocation) {
      setState(() {
        start = userLocation;
      });

      print('start (현재 위치): (${start.latitude}, ${start.longitude})');
      print('end: (${end.latitude}, ${end.longitude})');

      getRoute();
    }).catchError((e) {
      print('현재 위치 가져오기 실패: $e');
    });
  }

  Future<void> getRoute() async {
    final points = await RouteService.fetchWalkingRoute(start, end);

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
      estimatedTime = (distance / 80).round(); // 시속 약 4.8km 기준
    });
  }

  // ✅ 여기에 추가된 현재 위치 함수
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
                    Marker(
                      point: start,
                      width: 50,
                      height: 50,
                      child: const Icon(Icons.person_pin_circle, color: Colors.blue),
                    ),
                    Marker(
                      point: end,
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
