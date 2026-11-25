import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_catalog_app/features/catalog/presentation/cubit/catalog_cubit.dart';
import 'package:media_catalog_app/features/catalog/presentation/cubit/catalog_state.dart';
import 'package:media_catalog_app/features/catalog/presentation/pages/discover_view.dart';
import 'package:media_catalog_app/features/catalog/presentation/pages/favorites_view.dart';
import 'package:media_catalog_app/features/catalog/presentation/pages/settings_view.dart';
import 'package:media_catalog_app/generated/app_localizations.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final _pageController = PageController();
  int _selectedIndex = 0;
  int _handledFavoriteActionVersion = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocListener<CatalogCubit, CatalogState>(
      listenWhen: (previous, current) =>
          previous.favoriteActionVersion != current.favoriteActionVersion,
      listener: (context, state) {
        if (state.favoriteActionVersion <= _handledFavoriteActionVersion) {
          return;
        }
        _handledFavoriteActionVersion = state.favoriteActionVersion;
        final message = state.lastFavoriteValue == true
            ? l10n.favoriteAdded
            : l10n.favoriteRemoved;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(message)));
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 72,
          titleSpacing: 20,
          title: Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.auto_awesome_mosaic_rounded, size: 22),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.appName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) => setState(() => _selectedIndex = index),
          children: const [DiscoverView(), FavoritesView(), SettingsView()],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _goToPage,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.explore_outlined),
              selectedIcon: const Icon(Icons.explore_rounded),
              label: l10n.navDiscover,
            ),
            NavigationDestination(
              icon: const Icon(Icons.favorite_border_rounded),
              selectedIcon: const Icon(Icons.favorite_rounded),
              label: l10n.navFavorites,
            ),
            NavigationDestination(
              icon: const Icon(Icons.tune_rounded),
              selectedIcon: const Icon(Icons.tune_rounded),
              label: l10n.navSettings,
            ),
          ],
        ),
      ),
    );
  }

  void _goToPage(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }
}
