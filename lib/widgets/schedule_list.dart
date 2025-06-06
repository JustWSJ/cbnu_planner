import 'package:flutter/material.dart';
import '../models/schedule.dart';

class ScheduleList extends StatelessWidget {
  final List<Schedule> schedules;
  final void Function(Schedule) onDelete; // 🔹 삭제 콜백 추가

  const ScheduleList({
    super.key,
