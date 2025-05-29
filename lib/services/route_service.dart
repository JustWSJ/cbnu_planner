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
 