import 'package:media_catalog_app/core/error/app_failure.dart';
import 'package:media_catalog_app/features/catalog/domain/entities/media_item.dart';

enum CatalogPhase { initial, loading, ready, empty, failure }

enum CatalogKindFilter { all, movies, series }

final class CatalogState {
  const CatalogState({
    this.phase = CatalogPhase.initial,
    this.items = const [],
    this.favoriteIds = const {},
    this.searchQuery = '',
    this.kindFilter = CatalogKindFilter.all,
    this.genreFilter,
    this.failure,
    this.togglingFavoriteId,
    this.favoriteActionVersion = 0,
    this.lastFavoriteValue,
  });

  final CatalogPhase phase;
  final List<MediaItem> items;
  final Set<String> favoriteIds;
  final String searchQuery;
  final CatalogKindFilter kindFilter;
  final String? genreFilter;
  final AppFailure? failure;
  final String? togglingFavoriteId;
  final int favoriteActionVersion;
  final bool? lastFavoriteValue;

  List<String> get genres =>
      (items.map((item) => item.genre).toSet().toList()..sort());

  List<MediaItem> get filteredItems {
    final normalizedQuery = searchQuery.trim().toLowerCase();
    return items
        .where((item) {
          final matchesKind = switch (kindFilter) {
            CatalogKindFilter.all => true,
            CatalogKindFilter.movies => item.kind == MediaKind.movie,
            CatalogKindFilter.series => item.kind == MediaKind.series,
          };
          final matchesGenre = genreFilter == null || item.genre == genreFilter;
          final matchesQuery =
              normalizedQuery.isEmpty ||
              item.title.toLowerCase().contains(normalizedQuery) ||
              item.genre.toLowerCase().contains(normalizedQuery) ||
              item.studio.toLowerCase().contains(normalizedQuery);
          return matchesKind && matchesGenre && matchesQuery;
        })
        .toList(growable: false);
  }

  List<MediaItem> get featuredItems =>
      items.where((item) => item.isFeatured).take(4).toList(growable: false);

  List<MediaItem> get favoriteItems => items
      .where((item) => favoriteIds.contains(item.id))
      .toList(growable: false);

  CatalogState copyWith({
    CatalogPhase? phase,
    List<MediaItem>? items,
    Set<String>? favoriteIds,
    String? searchQuery,
    CatalogKindFilter? kindFilter,
    String? genreFilter,
    AppFailure? failure,
    String? togglingFavoriteId,
    int? favoriteActionVersion,
    bool? lastFavoriteValue,
    bool clearFailure = false,
    bool clearGenreFilter = false,
    bool clearTogglingFavorite = false,
  }) => CatalogState(
    phase: phase ?? this.phase,
    items: items ?? this.items,
    favoriteIds: favoriteIds ?? this.favoriteIds,
    searchQuery: searchQuery ?? this.searchQuery,
    kindFilter: kindFilter ?? this.kindFilter,
    genreFilter: clearGenreFilter ? null : genreFilter ?? this.genreFilter,
    failure: clearFailure ? null : failure ?? this.failure,
    togglingFavoriteId: clearTogglingFavorite
        ? null
        : togglingFavoriteId ?? this.togglingFavoriteId,
    favoriteActionVersion: favoriteActionVersion ?? this.favoriteActionVersion,
    lastFavoriteValue: lastFavoriteValue ?? this.lastFavoriteValue,
  );
}
