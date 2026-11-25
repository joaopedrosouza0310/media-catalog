import 'package:injectable/injectable.dart';
import 'package:media_catalog_app/features/catalog/domain/repositories/catalog_repository.dart';

@injectable
class ToggleFavorite {
  ToggleFavorite(this._repository);

  final CatalogRepository _repository;

  Future<bool> call(String mediaId) => _repository.toggleFavorite(mediaId);
}
