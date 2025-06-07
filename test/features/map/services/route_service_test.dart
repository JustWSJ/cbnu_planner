import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:cbnu_planner/features/map/services/route_service.dart';
import 'package:latlong2/latlong.dart';

class _FakeHttpClient extends HttpClient {
  final String body;
  _FakeHttpClient(this.body);

  @override
  Future<HttpClientRequest> postUrl(Uri url) async {
    return _FakeHttpClientRequest(body);
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeHttpClientRequest implements HttpClientRequest {
  final String body;
  _FakeHttpClientRequest(this.body);

  @override
  final HttpHeaders headers = _FakeHttpHeaders();

  @override
  Future<HttpClientResponse> close() async => _FakeHttpClientResponse(body);

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeHttpClientResponse extends Stream<List<int>> implements HttpClientResponse {
  final String body;
  _FakeHttpClientResponse(this.body);

  @override
  int get statusCode => 200;

  @override
  StreamSubscription<List<int>> listen(void Function(List<int>)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    final data = utf8.encode(body);
    return Stream<List<int>>.fromIterable([data]).listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeHttpHeaders implements HttpHeaders {
  final Map<String, List<String>> _values = {};
  @override
  void add(String name, Object value, {bool preserveHeaderCase = false}) {
    _values.putIfAbsent(name, () => []).add(value.toString());
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('fetchRouteWithWaypoints parses coordinates', () async {
    final responseBody = jsonEncode({
      'features': [
        {
          'geometry': {
            'coordinates': [
              [0.0, 1.0],
              [2.0, 3.0]
            ]
          }
        }
      ]
    });

    final points = [const LatLng(1.0, 0.0), const LatLng(3.0, 2.0)];

    final result = await HttpOverrides.runZoned(() {
      return RouteService.fetchRouteWithWaypoints(points);
    }, createHttpClient: (_) => _FakeHttpClient(responseBody));

    expect(result.length, 2);
    expect(result.first.latitude, 1.0);
    expect(result.first.longitude, 0.0);
  });
}