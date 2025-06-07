import 'package:flutter/material.dart';
import 'package:cbnu_planner/features/map/pages/map_route_page.dart';
import 'package:cbnu_planner/features/schedule/pages/schedule_input_page.dart';

class HomePage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

class CampusScheduleApp extends StatefulWidget {
  const CampusScheduleApp({super.key});

  @override
  State<CampusScheduleApp> createState() => _CampusScheduleAppState();
}

