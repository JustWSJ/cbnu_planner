import 'package:flutter/material.dart';
import 'package:cbnu_planner/pages/map_route_page.dart';
import 'package:cbnu_planner/pages/schedule_input_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1; // 시작 탭: 지도
  final List<Widget> _pages = [
    const ScheduleInputPage(),
    const MapRoutePage(),
  ];

}
