import 'package:flutter_test/flutter_test.dart';
import 'package:media_catalog_app/features/catalog/data/models/media_item_model.dart';
import 'package:media_catalog_app/features/catalog/domain/entities/media_item.dart';

void main() {
  test('maps an API media payload into the domain entity', () {
    final item = MediaItemModel.fromJson({
      'id': 'media-1',
      'title': 'Neon Horizon',
      'type': 'Movie',
      'genre': 'Science Fiction',
      'synopsis': 'A signal changes everything.',
      'studio': 'Northstar Pictures',
      'releaseYear': 2025,
      'rating': 8.7,
      'runtimeMinutes': 142,
      'posterUrl': 'https://example.com/neon-horizon.jpg',
      'isFeatured': true,
    }).toDomain();

    expect(item.title, 'Neon Horizon');
    expect(item.kind, MediaKind.movie);
    expect(item.rating, 8.7);
    expect(item.runtimeMinutes, 142);
    expect(item.isFeatured, isTrue);
  });
}
