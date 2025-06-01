import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cbnu_planner/secrets/api_keys.dart';

class RouteService {
  static const String _apiKey = ApiKeys.openRouteService;

  /// 기존: 단일 경로 (start → end)
  static Future<List<LatLng>> fetchWalkingRoute(LatLng start, LatLng end) async {
    return fetchWalkingRouteWithWaypoints([start, end]);
  }

  /// 확장: 경유지 포함 경로 (start → waypoint1 → ... → end)
  static Future<List<LatLng>> fetchWalkingRouteWithWaypoints(List<LatLng> points) async {
    final url = Uri.parse('https://api.openrouteservice.org/v2/directions/foot-walking/geojson');
    final coordinates = points.map((p) => [p.longitude, p.latitude]).toList();

    final body = jsonEncode({
      "coordinates": coordinates,
    });

    final response = await http.post(
      url,
      headers: {
        'Authorization': _apiKey,
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final coords = data['features'][0]['geometry']['coordinates'];
      return coords.map<LatLng>((c) => LatLng(c[1], c[0])).toList();
    } else {
      print('도보 경로 요청 실패: ${response.statusCode}');
      print('응답 내용: ${response.body}');
      return [];
    }
  }
}
