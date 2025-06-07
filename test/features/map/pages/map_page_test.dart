import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cbnu_planner/features/map/pages/map_page.dart';

void main() {
  testWidgets('MapPage shows title', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: MapPage(schedules: []),
    ));

    expect(find.text('캠퍼스 지도'), findsOneWidget);
  });
}