import 'package:media_catalog_app/core/result/result.dart';
import 'package:media_catalog_app/features/catalog/domain/entities/media_item.dart';

abstract interface class CatalogRepository {
  Future<Result<List<MediaItem>>> getCatalog();
  Future<Set<String>> getFavoriteIds();
  Future<bool> toggleFavorite(String mediaId);
}
