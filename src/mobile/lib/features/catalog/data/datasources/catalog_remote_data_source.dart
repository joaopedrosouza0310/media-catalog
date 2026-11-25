import 'package:injectable/injectable.dart';
import 'package:media_catalog_app/core/network/api_client.dart';
import 'package:media_catalog_app/features/catalog/data/models/media_item_model.dart';

abstract interface class CatalogRemoteDataSource {
  Future<List<MediaItemModel>> getCatalog();
}

@LazySingleton(as: CatalogRemoteDataSource)
class DioCatalogRemoteDataSource implements CatalogRemoteDataSource {
  DioCatalogRemoteDataSource(this._client);

  final ApiClient _client;

  @override
  Future<List<MediaItemModel>> getCatalog() async {
    final response = await _client.dio.get<Map<String, dynamic>>('media');
    final items = response.data?['items'] as List<dynamic>? ?? const [];
    return items
        .map((item) => MediaItemModel.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }
}
