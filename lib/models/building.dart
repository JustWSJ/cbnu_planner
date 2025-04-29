//  건물 데이터 모델
import 'package:latlong2/latlong.dart';

class Building {
  final String name;
  final LatLng location;

  Building({required this.name, required this.location});
}
