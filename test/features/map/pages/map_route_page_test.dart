import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cbnu_planner/features/map/pages/map_route_page.dart';

void main() {
  testWidgets('shows progress indicator before location is loaded', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: MapRoutePage(),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}