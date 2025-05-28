import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class RouteService {
  static const _apiKey = '5b3ce3597851110001cf6248c8b7b039e91545918016bbf70f29574a'; // 여기에 키 입력
  static const _baseUrl = 'https://api.openrouteservice.org/v2/directions/foot-walking';

  static Future<List<LatLng>> getRoute(LatLng start, LatLng end) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': _apiKey,
        'Content-Type': 'application/json',
      },