import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationService {
  static Future<LocationPermission> _ensurePermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
    return permission;
  }

  static Stream<LatLng> locationStream({
    LocationAccuracy accuracy = LocationAccuracy.best,
    int distanceFilter = 5,
  }) async* {
    final permission = await _ensurePermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      yield* Geolocator.getPositionStream(
        locationSettings: LocationSettings(
          accuracy: accuracy,
          distanceFilter: distanceFilter,
        ),
      ).map((p) => LatLng(p.latitude, p.longitude));
    }
  }
}