import 'package:flutter_test/flutter_test.dart';
import 'package:cbnu_planner/features/map/data/building_data.dart';

void main() {
  test('categorized buildings contain north zone', () {
    expect(categorizedBuildings.containsKey('N'), isTrue);
    expect(categorizedBuildings['N'], isNotEmpty);
  });

  test('buildingList length matches sum of categories', () {
    final total = categorizedBuildings.values
        .fold<int>(0, (prev, list) => prev + list.length);
    expect(buildingList.length, total);
  });
}