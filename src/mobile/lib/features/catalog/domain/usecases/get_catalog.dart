import 'package:injectable/injectable.dart';
import 'package:media_catalog_app/core/result/result.dart';
import 'package:media_catalog_app/features/catalog/domain/entities/media_item.dart';
import 'package:media_catalog_app/features/catalog/domain/repositories/catalog_repository.dart';

@injectable
class GetCatalog {
  GetCatalog(this._repository);

  final CatalogRepository _repository;

  Future<Result<List<MediaItem>>> call() => _repository.getCatalog();
}
