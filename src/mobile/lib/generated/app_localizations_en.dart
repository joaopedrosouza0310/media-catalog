// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Media Catalog';

  @override
  String get navDiscover => 'Discover';

  @override
  String get navFavorites => 'Favorites';

  @override
  String get navSettings => 'Settings';

  @override
  String get discoverEyebrow => 'CURATED FOR YOU';

  @override
  String get discoverTitle => 'Find your next obsession';

  @override
  String get discoverSubtitle => 'Movies and series worth making time for.';

  @override
  String get searchHint => 'Search titles, genres, or studios';

  @override
  String get allFilter => 'All';

  @override
  String get moviesFilter => 'Movies';

  @override
  String get seriesFilter => 'Series';

  @override
  String get featuredTitle => 'Featured now';

  @override
  String get browseTitle => 'Browse the catalog';

  @override
  String resultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count titles',
      one: '1 title',
      zero: 'No titles',
    );
    return '$_temp0';
  }

  @override
  String get emptyResults => 'Nothing matched your search';

  @override
  String get emptyResultsDescription => 'Try another title, genre, or filter.';

  @override
  String get retry => 'Try again';

  @override
  String get genericError => 'Something went wrong. Please try again.';

  @override
  String rating(String value) {
    return '$value/10';
  }

  @override
  String releaseYear(int year) {
    return 'Released $year';
  }

  @override
  String runtime(int minutes) {
    return '$minutes min';
  }

  @override
  String get movieLabel => 'Movie';

  @override
  String get seriesLabel => 'Series';

  @override
  String get aboutTitle => 'About';

  @override
  String get studioLabel => 'Studio';

  @override
  String get genreLabel => 'Genre';

  @override
  String get addFavorite => 'Add to favorites';

  @override
  String get removeFavorite => 'Remove from favorites';

  @override
  String get favoriteAdded => 'Added to your favorites.';

  @override
  String get favoriteRemoved => 'Removed from your favorites.';

  @override
  String get favoritesTitle => 'Your favorites';

  @override
  String get favoritesSubtitle =>
      'Your personal movie and series watchlist, all in one place.';

  @override
  String get emptyFavorites => 'Your collection is waiting';

  @override
  String get emptyFavoritesDescription =>
      'Tap the heart on any movie or series to save it here.';

  @override
  String get appearance => 'Appearance';

  @override
  String get settingsTitle => 'Make it yours';

  @override
  String get settingsSubtitle =>
      'Choose how Media Catalog looks and speaks to you.';

  @override
  String get themeDescription => 'Select the appearance you prefer.';

  @override
  String get languageDescription =>
      'Choose the language used throughout the app.';

  @override
  String get systemTheme => 'System';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get portuguese => 'Português';
}
