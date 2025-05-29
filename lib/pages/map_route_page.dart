import 'dart:async'; // ✅ 위치 스트림 제어용

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
  Schedule? nextSchedule;
  double distanceToNext = 0.0;
  StreamSubscription<Position>? _positionStream; // ✅ 위치 추적 구독 저장

  @override
  void initState() {
    super.initState();
    _setNextSchedule();
    _requestAndSetCurrentLocation();
  }

  @override
  void dispose() {
    _positionStream?.cancel(); // ✅ 스트림 해제
    super.dispose();
  }

  void _setNextSchedule() {
    final now = TimeOfDay.now();
    final sorted = [...widget.schedules];
    sorted.sort((a, b) => (a.time.hour * 60 + a.time.minute)
        .compareTo(b.time.hour * 60 + b.time.minute));

    for (var s in sorted) {
      if ((s.time.hour > now.hour) ||
          (s.time.hour == now.hour && s.time.minute > now.minute)) {
        nextSchedule = s;
        return;
      }
    }

    if (sorted.isNotEmpty) {
      nextSchedule = sorted.first;
    }
  }

  Future<void> _requestAndSetCurrentLocation() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      _positionStream = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 5,
        ),
      ).listen((position) {
        if (!mounted) return; // ✅ 페이지 살아있을 때만 갱신
        setState(() {
          currentLocation = LatLng(position.latitude, position.longitude);
          _updateDistance();
        });
      });
    }
  }

  void _updateDistance() {
    if (currentLocation != null && nextSchedule != null) {
      final nextLatLng = MapService.getBuildingCoordinates(
        nextSchedule!.place,
        buildingList,
      );

      debugPrint("🟢 다음 장소 좌표: $nextLatLng");
      debugPrint("🔵 현재 위치: $currentLocation");

      distanceToNext = Distance().as(LengthUnit.Meter, currentLocation!, nextLatLng);
      debugPrint("📏 계산된 거리: ${distanceToNext.toStringAsFixed(2)} m");
    } else {
      debugPrint("⚠️ 거리 계산 불가: 위치 또는 다음 장소가 null");
    }
  }

  List<LatLng> _generateRoutePoints() {
    final sorted = [...widget.schedules];
    sorted.sort((a, b) => (a.time.hour * 60 + a.time.minute)
        .compareTo(b.time.hour * 60 + b.time.minute));

    final points = sorted.map((s) {
      return MapService.getBuildingCoordinates(s.place, buildingList);
    }).toList();

    if (currentLocation != null) {
      points.insert(0, currentLocation!);
    }

    return points;
  }

  List<Marker> _createMarkers() {
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

    for (var schedule in widget.schedules) {
      final point = MapService.getBuildingCoordinates(schedule.place, buildingList);
      final isNext = nextSchedule?.title == schedule.title &&
          nextSchedule?.time == schedule.time &&
          nextSchedule?.place == schedule.place;

      markers.add(
        Marker(
          point: point,
          width: 80,
          height: 80,
          child: Column(
            children: [
              Icon(
                Icons.location_on,
                color: isNext ? Colors.green : Colors.red,
                size: 36,
              ),
              Text(schedule.title, style: const TextStyle(fontSize: 10)),
            ],
          ),
        ),
      );
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    final routePoints = _generateRoutePoints();
    final markers = _createMarkers();

    return Scaffold(
      appBar: AppBar(title: const Text('이동 경로 보기')),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center:
                  routePoints.isNotEmpty ? routePoints.first : LatLng(36.6282, 127.4562),
              zoom: 17.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.cbnu_planner',
              ),
              if (routePoints.length >= 2)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: routePoints,
                      strokeWidth: 4.0,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              MarkerLayer(markers: markers),
            ],
          ),

          // ✅ 하단 안내 바
          if (nextSchedule != null && currentLocation != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                color: Colors.white.withOpacity(0.95),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '다음 장소: ${nextSchedule!.place}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '거리: ${distanceToNext.toStringAsFixed(1)} m',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
