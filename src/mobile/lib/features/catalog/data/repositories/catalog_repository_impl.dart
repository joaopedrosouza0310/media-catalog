import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:media_catalog_app/core/error/app_failure.dart';
import 'package:media_catalog_app/core/result/result.dart';
import 'package:media_catalog_app/features/catalog/data/datasources/catalog_remote_data_source.dart';
import 'package:media_catalog_app/features/catalog/data/datasources/favorites_local_data_source.dart';
import 'package:media_catalog_app/features/catalog/domain/entities/media_item.dart';
import 'package:media_catalog_app/features/catalog/domain/repositories/catalog_repository.dart';

@LazySingleton(as: CatalogRepository)
class CatalogRepositoryImpl implements CatalogRepository {
  CatalogRepositoryImpl(this._remoteDataSource, this._favoritesDataSource);

  final CatalogRemoteDataSource _remoteDataSource;
  final FavoritesLocalDataSource _favoritesDataSource;

  @override
  Future<Result<List<MediaItem>>> getCatalog() async {
    try {
      final models = await _remoteDataSource.getCatalog();
      return Success(
        models.map((model) => model.toDomain()).toList(growable: false),
      );
    } on DioException {
      return const FailureResult(AppFailure(FailureKind.network));
    } catch (_) {
      return const FailureResult(AppFailure(FailureKind.unexpected));
    }
  }

  @override
  Future<Set<String>> getFavoriteIds() async =>
      _favoritesDataSource.getFavoriteIds();

  @override
  Future<bool> toggleFavorite(String mediaId) =>
      _favoritesDataSource.toggle(mediaId);
}
