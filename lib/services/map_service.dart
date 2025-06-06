//  지도 관련 로직
import '../models/building.dart';
import 'package:latlong2/latlong.dart';
import '../utils/building_data.dart';

class MapService {
  static LatLng getBuildingCoordinates(String zone, String name) {
    final List<Building> buildings = categorizedBuildings[zone] ?? [];
    try {
      return buildings.firstWhere((b) => b.name == name).location;
    } catch (e) {
      return LatLng(36.6282, 127.4562); // 기본값
    }
  }
}
