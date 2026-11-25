// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'Catálogo de Mídia';

  @override
  String get navDiscover => 'Descobrir';

  @override
  String get navFavorites => 'Favoritos';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get discoverEyebrow => 'SELECIONADOS PARA VOCÊ';

  @override
  String get discoverTitle => 'Encontre sua próxima obsessão';

  @override
  String get discoverSubtitle => 'Filmes e séries que merecem seu tempo.';

  @override
  String get searchHint => 'Busque títulos, gêneros ou estúdios';

  @override
  String get allFilter => 'Tudo';

  @override
  String get moviesFilter => 'Filmes';

  @override
  String get seriesFilter => 'Séries';

  @override
  String get featuredTitle => 'Em destaque';

  @override
  String get browseTitle => 'Explore o catálogo';

  @override
  String resultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count títulos',
      one: '1 título',
      zero: 'Nenhum título',
    );
    return '$_temp0';
  }

  @override
  String get emptyResults => 'Nenhum resultado encontrado';

  @override
  String get emptyResultsDescription => 'Tente outro título, gênero ou filtro.';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get genericError => 'Algo deu errado. Tente novamente.';

  @override
  String rating(String value) {
    return '$value/10';
  }

  @override
  String releaseYear(int year) {
    return 'Lançado em $year';
  }

  @override
  String runtime(int minutes) {
    return '$minutes min';
  }

  @override
  String get movieLabel => 'Filme';

  @override
  String get seriesLabel => 'Série';

  @override
  String get aboutTitle => 'Sobre';

  @override
  String get studioLabel => 'Estúdio';

  @override
  String get genreLabel => 'Gênero';

  @override
  String get addFavorite => 'Adicionar aos favoritos';

  @override
  String get removeFavorite => 'Remover dos favoritos';

  @override
  String get favoriteAdded => 'Adicionado aos seus favoritos.';

  @override
  String get favoriteRemoved => 'Removido dos seus favoritos.';

  @override
  String get favoritesTitle => 'Seus favoritos';

  @override
  String get favoritesSubtitle =>
      'Sua lista de filmes e séries reunida em um só lugar.';

  @override
  String get emptyFavorites => 'Sua coleção está esperando';

  @override
  String get emptyFavoritesDescription =>
      'Toque no coração de qualquer filme ou série para salvar aqui.';

  @override
  String get appearance => 'Aparência';

  @override
  String get settingsTitle => 'Deixe do seu jeito';

  @override
  String get settingsSubtitle =>
      'Escolha como o Catálogo de Mídia aparece e fala com você.';

  @override
  String get themeDescription => 'Selecione a aparência que você prefere.';

  @override
  String get languageDescription =>
      'Escolha o idioma usado em todo o aplicativo.';

  @override
  String get systemTheme => 'Sistema';

  @override
  String get lightTheme => 'Claro';

  @override
  String get darkTheme => 'Escuro';

  @override
  String get language => 'Idioma';

  @override
  String get english => 'English';

  @override
  String get portuguese => 'Português';
}
