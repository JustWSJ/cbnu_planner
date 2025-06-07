import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:cbnu_planner/features/map/services/route_service.dart';
import 'package:latlong2/latlong.dart';

class FakeHttpOverrides extends HttpOverrides {
  final String responseBody;
  FakeHttpOverrides(this.responseBody);

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _MockHttpClient(responseBody);
  }
}

class _MockHttpClient implements HttpClient {
  final String body;
  _MockHttpClient(this.body);

  @override
  Future<HttpClientRequest> postUrl(Uri url) async {
    return _MockHttpClientRequest(body);
  }

  // ✅ 필수: close 메서드 추가
  @override
  void close({bool force = false}) {
    // 테스트 목적이므로 실제 리소스 정리는 생략
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _MockHttpClientRequest implements HttpClientRequest {
  final String body;
  _MockHttpClientRequest(this.body);

  @override
  final HttpHeaders headers = _MockHttpHeaders();

  @override
  Future<HttpClientResponse> close() async => _MockHttpClientResponse(body);

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _MockHttpClientResponse extends Stream<List<int>>
    implements HttpClientResponse {
  final String body;
  _MockHttpClientResponse(this.body);

  @override
  int get statusCode => 200;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int>)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    final data = utf8.encode(body);
    return Stream<List<int>>.fromIterable([data]).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _MockHttpHeaders implements HttpHeaders {
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

    await HttpOverrides.runZoned(
      () async {
        final result = await RouteService.fetchRouteWithWaypoints(points);

        expect(result.length, 2);
        expect(result[0].latitude, 1.0);
        expect(result[0].longitude, 0.0);
      },
      createHttpClient: (_) => _MockHttpClient(responseBody),
    );
  });
}
