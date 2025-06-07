import 'package:flutter_test/flutter_test.dart';
import 'package:cbnu_planner/features/map/services/map_service.dart';
import 'package:cbnu_planner/features/map/data/building_data.dart';
import 'package:latlong2/latlong.dart';

void main() {
  group('MapService.getBuildingCoordinates', () {
    test('returns coordinates for existing building', () {
      final building = categorizedBuildings['N']!.first;
      final result =
          MapService.getBuildingCoordinates('N', building.name);
      expect(result.latitude, building.location.latitude);
      expect(result.longitude, building.location.longitude);
    });

    test('returns default coordinates when not found', () {
      final result = MapService.getBuildingCoordinates('N', 'UNKNOWN');
      expect(result, const LatLng(36.6282, 127.4562));
    });
  });
}