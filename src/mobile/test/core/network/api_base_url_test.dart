import 'package:media_catalog_app/core/network/api_base_url.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('normalizeApiBaseUrl', () {
    test('adds a trailing slash when it is missing', () {
      expect(
        normalizeApiBaseUrl('http://localhost:59579/api/v1'),
        'http://localhost:59579/api/v1/',
      );
    });

    test('preserves an existing trailing slash', () {
      expect(
        normalizeApiBaseUrl('http://localhost:59579/api/v1/'),
        'http://localhost:59579/api/v1/',
      );
    });
  });
}
