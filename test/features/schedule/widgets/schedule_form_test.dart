import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cbnu_planner/features/schedule/widgets/schedule_form.dart';

void main() {
  testWidgets('dropdowns show selected values', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ScheduleForm(
        titleController: TextEditingController(),
        selectedZone: 'N',
        selectedBuilding: 'B1',
        buildingsByZone: const {
          'N': ['B1', 'B2'],
        },
        selectedTime: const TimeOfDay(hour: 8, minute: 0),
        onPickTime: () {},
        onZoneChanged: (_) {},
        onBuildingChanged: (_) {},
        onSubmit: () {},
      ),
    ));

    expect(find.text('B1'), findsOneWidget);
  });
}