import 'package:flutter/material.dart';
import 'package:cbnu_planner/features/map/pages/map_route_page.dart';
import 'package:cbnu_planner/features/schedule/pages/schedule_input_page.dart';

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

  void _onTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '내 일정',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: '지도',
          ),
        ],
      ),
    );
  }
}
