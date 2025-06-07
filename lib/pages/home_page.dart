import 'package:flutter/material.dart';
import 'package:cbnu_planner/features/map/pages/map_route_page.dart';
import 'package:cbnu_planner/features/schedule/pages/schedule_input_page.dart';

class HomePage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const HomePage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1; // 시작 탭: 지도
  final List<Widget> _pages = [
    const ScheduleInputPage(),
    const MapRoutePage(),
  ];

  void _onTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () => widget.onThemeChanged(!widget.isDarkMode),
        tooltip: '다크모드',
        child: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
      ),
