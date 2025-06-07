import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cbnu_planner/features/schedule/pages/schedule_input_page.dart';

void main() {
  testWidgets('ScheduleInputPage has add button', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: ScheduleInputPage(),
    ));

    expect(find.text('일정 추가'), findsOneWidget);
  });
}