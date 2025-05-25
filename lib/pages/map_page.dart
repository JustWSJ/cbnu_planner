import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

import '../models/schedule.dart';
import '../services/map_service.dart';
import '../utils/building_data.dart';

class MapPage extends StatefulWidget {
  final List<Schedule> schedules;

  const MapPage({super.key, required this.schedules});

  @override
  State<MapPage> createState() => _MapPageState();
}