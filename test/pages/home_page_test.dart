import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cbnu_planner/pages/home_page.dart';
import 'package:cbnu_planner/features/map/pages/map_route_page.dart';
import 'package:cbnu_planner/features/schedule/pages/schedule_input_page.dart';

void main() {
  testWidgets('HomePage navigates between tabs', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: HomePage(isDarkMode: false, onThemeChanged: (_) {}),
    ));

    // Default page is MapRoutePage
    expect(find.byType(MapRoutePage), findsOneWidget);

    await tester.tap(find.text('내 일정'));
    await tester.pumpAndSettle();
    expect(find.byType(ScheduleInputPage), findsOneWidget);
  });
}