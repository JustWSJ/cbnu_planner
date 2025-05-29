import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:flutter/foundation.dart';

class RouteService {
  static const _apiKey = '5b3ce3597851110001cf6248c8b7b039e91545918016bbf70f29574a';
  static const _baseUrl = 'https://api.openrouteservice.org/v2/directions/foot-walking';

  static Future<List<LatLng>> getRoute(LatLng start, LatLng end) async {
    final uri = Uri.parse(_baseUrl);

    final response = await http.post(
      uri,
      headers: {
        'Authorization': _apiKey,
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'coordinates': [
          [start.longitude, start.latitude],
          [end.longitude, end.latitude],
        ]
      }),
    );

    debugPrint("📍 start: $start");
    debugPrint("📍 end: $end");
    debugPrint("📦 status: ${response.statusCode}");
    debugPrint("📩 body: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      try {
        final geometry = data['routes'][0]['geometry'] as String;
        final points = decodePolyline(geometry);
        return points;
      } catch (e) {
        throw Exception('❌ Invalid route response: $e');
      }
    } else {
      throw Exception('Failed to get route: ${response.body}');
    }
  }

  static List<LatLng> decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }
}
