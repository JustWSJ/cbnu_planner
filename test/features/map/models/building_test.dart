import 'package:flutter_test/flutter_test.dart';
import 'package:cbnu_planner/features/map/models/building.dart';
import 'package:latlong2/latlong.dart';

void main() {
  group('Building', () {
    test('hasValidCoordinates returns true when coordinates are non-zero', () {
      final b = Building(name: 'A', location: const LatLng(1.0, 2.0));
      expect(b.hasValidCoordinates, isTrue);
    });

    test('hasValidCoordinates returns false when coordinates are zero', () {
      final b = Building(name: 'B', location: const LatLng(0.0, 0.0));
      expect(b.hasValidCoordinates, isFalse);
    });
  });
}