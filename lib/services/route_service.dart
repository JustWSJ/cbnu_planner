import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cbnu_planner/secrets/api_keys.dart'; // 🔐 API 키 모듈화

class RouteService {
  static const String _apiKey = ApiKeys.openRouteService;

  /// 단일 도보 경로 요청: 시작 → 도착
  static Future<List<LatLng>> fetchWalkingRoute(LatLng start, LatLng end) async {
    return fetchRouteWithWaypoints([start, end]);
  }

  /// 경유지 포함 도보 경로 요청: 시작 → 경유지* → 도착
  static Future<List<LatLng>> fetchRouteWithWaypoints(List<LatLng> coordinates) async {
    final url = Uri.parse('https://api.openrouteservice.org/v2/directions/foot-walking/geojson');

    final body = jsonEncode({
      "coordinates": coordinates.map((c) => [c.longitude, c.latitude]).toList(),
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
      print('🚫 경로 요청 실패: ${response.statusCode}');
      print('응답 내용: ${response.body}');
      return [];
    }
  }
}
