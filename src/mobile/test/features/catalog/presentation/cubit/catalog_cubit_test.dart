import 'package:flutter_test/flutter_test.dart';
import 'package:media_catalog_app/core/result/result.dart';
import 'package:media_catalog_app/features/catalog/domain/entities/media_item.dart';
import 'package:media_catalog_app/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:media_catalog_app/features/catalog/domain/usecases/get_catalog.dart';
import 'package:media_catalog_app/features/catalog/domain/usecases/get_favorite_ids.dart';
import 'package:media_catalog_app/features/catalog/domain/usecases/toggle_favorite.dart';
import 'package:media_catalog_app/features/catalog/presentation/cubit/catalog_cubit.dart';
import 'package:media_catalog_app/features/catalog/presentation/cubit/catalog_state.dart';

void main() {
  late _FakeCatalogRepository repository;
  late CatalogCubit cubit;

  setUp(() {
    repository = _FakeCatalogRepository();
    cubit = CatalogCubit(
      GetCatalog(repository),
      GetFavoriteIds(repository),
      ToggleFavorite(repository),
    );
  });

  tearDown(() => cubit.close());

  test('loads the seeded catalog and persisted favorites', () async {
    await cubit.load();

    expect(cubit.state.phase, CatalogPhase.ready);
    expect(cubit.state.items, hasLength(3));
    expect(cubit.state.favoriteIds, {'series-1'});
  });

  test('filters by media kind, genre, and search query', () async {
    await cubit.load();

    cubit.setKindFilter(CatalogKindFilter.movies);
    cubit.setGenreFilter('Thriller');
    cubit.setSearchQuery('signal');

    expect(cubit.state.filteredItems.single.id, 'movie-2');
  });

  test('toggles and persists a favorite', () async {
    await cubit.load();

    await cubit.toggleFavorite('movie-1');

    expect(cubit.state.favoriteIds, contains('movie-1'));
    expect(cubit.state.favoriteActionVersion, 1);
    expect(cubit.state.lastFavoriteValue, isTrue);
  });
}

final class _FakeCatalogRepository implements CatalogRepository {
  final items = const [
    MediaItem(
      id: 'movie-1',
      title: 'Neon Horizon',
      kind: MediaKind.movie,
      genre: 'Science Fiction',
      synopsis: 'A signal changes everything.',
      studio: 'Northstar Pictures',
      releaseYear: 2025,
      rating: 8.7,
      runtimeMinutes: 142,
      posterUrl: 'https://example.com/neon-horizon.jpg',
      isFeatured: true,
    ),
    MediaItem(
      id: 'movie-2',
      title: 'The Last Signal',
      kind: MediaKind.movie,
      genre: 'Thriller',
      synopsis: 'A call arrives from tomorrow.',
      studio: 'Red Frequency',
      releaseYear: 2024,
      rating: 8.2,
      runtimeMinutes: 118,
      posterUrl: 'https://example.com/last-signal.jpg',
      isFeatured: false,
    ),
    MediaItem(
      id: 'series-1',
      title: 'Signal Stories',
      kind: MediaKind.series,
      genre: 'Drama',
      synopsis: 'A serialized story.',
      studio: 'Example Studios',
      releaseYear: 2025,
      rating: 9.1,
      runtimeMinutes: 50,
      posterUrl: 'https://example.com/signal-stories.jpg',
      isFeatured: true,
    ),
  ];

  final favoriteIds = <String>{'series-1'};

  @override
  Future<Result<List<MediaItem>>> getCatalog() async => Success(items);

  @override
  Future<Set<String>> getFavoriteIds() async => Set.of(favoriteIds);

  @override
  Future<bool> toggleFavorite(String mediaId) async {
    if (favoriteIds.remove(mediaId)) return false;
    favoriteIds.add(mediaId);
    return true;
  }
}
