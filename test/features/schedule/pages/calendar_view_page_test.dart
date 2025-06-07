import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cbnu_planner/features/schedule/pages/calendar_view_page.dart';

void main() {
  testWidgets('CalendarViewPage builds', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CalendarViewPage(),
    ));

    expect(find.byType(CalendarViewPage), findsOneWidget);
  });
}