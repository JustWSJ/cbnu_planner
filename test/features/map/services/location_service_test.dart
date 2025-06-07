import 'package:flutter_test/flutter_test.dart';
import 'package:cbnu_planner/features/map/services/location_service.dart';
import 'package:latlong2/latlong.dart';

void main() {
  test('locationStream returns a Stream<LatLng>', () {
    final stream = LocationService.locationStream();
    expect(stream, isA<Stream<LatLng>>());
  });
}