//  건물 데이터 모델
import 'package:latlong2/latlong.dart';

class Building {
  final String name;
  final LatLng location;

  Building({required this.name, required this.location});
  /// Returns true if the building has coordinates other than (0.0, 0.0).
  bool get hasValidCoordinates =>
      location.latitude != 0.0 || location.longitude != 0.0;
}
