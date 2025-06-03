import 'package:flutter/material.dart';
import 'package:cbnu_planner/pages/home_page.dart';

void main() {
  runApp(const CampusScheduleApp());
}

class CampusScheduleApp extends StatelessWidget {
  const CampusScheduleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '스마트 캠퍼스 스케줄러',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
