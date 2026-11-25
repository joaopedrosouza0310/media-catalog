import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class FavoritesLocalDataSource {
  Set<String> getFavoriteIds();
  Future<bool> toggle(String mediaId);
}

@LazySingleton(as: FavoritesLocalDataSource)
class SharedPreferencesFavoritesLocalDataSource
    implements FavoritesLocalDataSource {
  SharedPreferencesFavoritesLocalDataSource(this._preferences);

  static const _key = 'favorite_media_ids';
  final SharedPreferences _preferences;

  @override
  Set<String> getFavoriteIds() =>
      (_preferences.getStringList(_key) ?? const <String>[]).toSet();

  @override
  Future<bool> toggle(String mediaId) async {
    final favorites = getFavoriteIds();
    final isFavorite = favorites.contains(mediaId);
    if (isFavorite) {
      favorites.remove(mediaId);
    } else {
      favorites.add(mediaId);
    }
    await _preferences.setStringList(_key, favorites.toList()..sort());
    return !isFavorite;
  }
}
