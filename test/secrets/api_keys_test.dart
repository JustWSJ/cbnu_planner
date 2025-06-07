import 'package:flutter_test/flutter_test.dart';
import 'package:cbnu_planner/secrets/api_keys.dart';

void main() {
  test('openRouteService key exists', () {
    expect(ApiKeys.openRouteService, isNotEmpty);
  });
}