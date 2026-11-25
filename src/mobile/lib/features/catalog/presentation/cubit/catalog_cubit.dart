import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:media_catalog_app/core/result/result.dart';
import 'package:media_catalog_app/features/catalog/domain/usecases/get_catalog.dart';
import 'package:media_catalog_app/features/catalog/domain/usecases/get_favorite_ids.dart';
import 'package:media_catalog_app/features/catalog/domain/usecases/toggle_favorite.dart';
import 'package:media_catalog_app/features/catalog/presentation/cubit/catalog_state.dart';

@injectable
class CatalogCubit extends Cubit<CatalogState> {
  CatalogCubit(this._getCatalog, this._getFavoriteIds, this._toggleFavorite)
    : super(const CatalogState());

  final GetCatalog _getCatalog;
  final GetFavoriteIds _getFavoriteIds;
  final ToggleFavorite _toggleFavorite;

  Future<void> load() async {
    if (state.phase == CatalogPhase.loading) return;
    emit(state.copyWith(phase: CatalogPhase.loading, clearFailure: true));
    final favoriteIds = await _getFavoriteIds();
    switch (await _getCatalog()) {
      case Success(value: final items):
        emit(
          state.copyWith(
            phase: items.isEmpty ? CatalogPhase.empty : CatalogPhase.ready,
            items: items,
            favoriteIds: favoriteIds,
            clearFailure: true,
          ),
        );
      case FailureResult(failure: final failure):
        emit(state.copyWith(phase: CatalogPhase.failure, failure: failure));
    }
  }

  void setSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void setKindFilter(CatalogKindFilter filter) {
    emit(state.copyWith(kindFilter: filter));
  }

  void setGenreFilter(String? genre) {
    emit(state.copyWith(genreFilter: genre, clearGenreFilter: genre == null));
  }

  Future<void> toggleFavorite(String mediaId) async {
    if (state.togglingFavoriteId != null) return;
    emit(state.copyWith(togglingFavoriteId: mediaId));
    final isFavorite = await _toggleFavorite(mediaId);
    final updatedIds = Set<String>.of(state.favoriteIds);
    if (isFavorite) {
      updatedIds.add(mediaId);
    } else {
      updatedIds.remove(mediaId);
    }
    emit(
      state.copyWith(
        favoriteIds: updatedIds,
        favoriteActionVersion: state.favoriteActionVersion + 1,
        lastFavoriteValue: isFavorite,
        clearTogglingFavorite: true,
      ),
    );
  }
}
