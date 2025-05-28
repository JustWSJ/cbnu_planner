import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class RouteService {
  static const _apiKey = '5b3ce3597851110001cf6248c8b7b039e91545918016bbf70f29574a';
  static const _baseUrl = 'https://api.openrouteservice.org/v2/directions/foot-walking';

  static Future<List<LatLng>> getRoute(LatLng start, LatLng end) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': '5b3ce3597851110001cf6248c8b7b039e91545918016bbf70f29574a',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'coordinates': [
          [start.longitude, start.latitude],
          [end.longitude, end.latitude],
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final coords = data['features'][0]['geometry']['coordinates'] as List;
      return coords.map<LatLng>((c) => LatLng(c[1], c[0])).toList();
    } else {
      throw Exception('Failed to get route: ${response.body}');
    }
  }
}