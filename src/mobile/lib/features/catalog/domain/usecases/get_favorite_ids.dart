import 'package:injectable/injectable.dart';
import 'package:media_catalog_app/features/catalog/domain/repositories/catalog_repository.dart';

@injectable
class GetFavoriteIds {
  GetFavoriteIds(this._repository);

  final CatalogRepository _repository;

  Future<Set<String>> call() => _repository.getFavoriteIds();
}
