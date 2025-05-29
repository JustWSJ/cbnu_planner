import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../models/schedule.dart';
import '../services/map_service.dart';
import '../services/route_service.dart';
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
  StreamSubscription<Position>? _positionStream;
  List<LatLng> routePoints = [];

  @override
  void initState() {
    super.initState();
    _setNextSchedule();
    _requestAndSetCurrentLocation();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
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
        if (!mounted) return;
        setState(() {
          currentLocation = LatLng(position.latitude, position.longitude);
        });
        _updateDistanceAndRoute();
      });
    }
  }

  Future<void> _updateDistanceAndRoute() async {
