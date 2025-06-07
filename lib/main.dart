import 'package:flutter/material.dart';
import 'package:cbnu_planner/pages/home_page.dart';

void main() {
  runApp(const CampusScheduleApp());
}

class CampusScheduleApp extends StatefulWidget {
  const CampusScheduleApp({super.key});

  @override
  State<CampusScheduleApp> createState() => _CampusScheduleAppState();
}

class _CampusScheduleAppState extends State<CampusScheduleApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '스마트 캠퍼스 스케줄러',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
  