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

  
}