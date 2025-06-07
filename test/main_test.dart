import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cbnu_planner/main.dart';

void main() {
  testWidgets('App builds MaterialApp', (tester) async {
    await tester.pumpWidget(const CampusScheduleApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}