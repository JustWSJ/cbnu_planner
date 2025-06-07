import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cbnu_planner/features/schedule/widgets/schedule_list.dart';
import 'package:cbnu_planner/features/schedule/models/schedule.dart';

void main() {
  testWidgets('displays schedule titles', (tester) async {
    final schedules = [
      Schedule(
        title: 'title1',
        zone: 'N',
        place: 'place',
        time: const TimeOfDay(hour: 9, minute: 0),
      ),
    ];

    await tester.pumpWidget(MaterialApp(
      home: ScheduleList(
        schedules: schedules,
        onDelete: (_) {},
        onEdit: (_) {},
      ),
    ));

    expect(find.text('title1'), findsOneWidget);
  });
}