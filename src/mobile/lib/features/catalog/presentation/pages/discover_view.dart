import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_catalog_app/features/catalog/presentation/cubit/catalog_cubit.dart';
import 'package:media_catalog_app/features/catalog/presentation/cubit/catalog_state.dart';
import 'package:media_catalog_app/features/catalog/presentation/widgets/catalog_empty_state.dart';
import 'package:media_catalog_app/features/catalog/presentation/widgets/discover_hero.dart';
import 'package:media_catalog_app/features/catalog/presentation/widgets/featured_media_card.dart';
import 'package:media_catalog_app/features/catalog/presentation/widgets/media_card.dart';
import 'package:media_catalog_app/features/catalog/presentation/widgets/media_details.dart';
import 'package:media_catalog_app/generated/app_localizations.dart';

class DiscoverView extends StatelessWidget {
  const DiscoverView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<CatalogCubit, CatalogState>(
      builder: (context, state) {
        if (state.phase == CatalogPhase.loading ||
            state.phase == CatalogPhase.initial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.phase == CatalogPhase.failure) {
          return Center(
            child: FilledButton.icon(
              onPressed: context.read<CatalogCubit>().load,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(l10n.retry),
            ),
          );
        }

        return SafeArea(
          top: false,
          child: RefreshIndicator(
            onRefresh: context.read<CatalogCubit>().load,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth >= 850
                    ? 5
                    : constraints.maxWidth >= 600
                    ? 3
                    : 2;
                final results = state.filteredItems;
                return ListView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                  children: [
                    const DiscoverHero(),
                    const SizedBox(height: 20),
                    TextField(
                      onChanged: context.read<CatalogCubit>().setSearchQuery,
                      decoration: InputDecoration(
                        hintText: l10n.searchHint,
                        prefixIcon: const Icon(Icons.search_rounded),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _KindChip(
                            label: l10n.allFilter,
                            icon: Icons.grid_view_rounded,
                            value: CatalogKindFilter.all,
                            selected: state.kindFilter,
                          ),
                          const SizedBox(width: 8),
                          _KindChip(
                            label: l10n.moviesFilter,
                            icon: Icons.movie_outlined,
                            value: CatalogKindFilter.movies,
                            selected: state.kindFilter,
                          ),
                          const SizedBox(width: 8),
                          _KindChip(
                            label: l10n.seriesFilter,
                            icon: Icons.live_tv_outlined,
                            value: CatalogKindFilter.series,
                            selected: state.kindFilter,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ChoiceChip(
                            label: Text(l10n.allFilter),
                            selected: state.genreFilter == null,
                            onSelected: (_) => context
                                .read<CatalogCubit>()
                                .setGenreFilter(null),
                          ),
                          for (final genre in state.genres) ...[
                            const SizedBox(width: 7),
                            ChoiceChip(
                              label: Text(genre),
                              selected: state.genreFilter == genre,
                              onSelected: (_) => context
                                  .read<CatalogCubit>()
                                  .setGenreFilter(genre),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (state.searchQuery.isEmpty &&
                        state.kindFilter == CatalogKindFilter.all &&
                        state.genreFilter == null) ...[
                      const SizedBox(height: 26),
                      Text(
                        l10n.featuredTitle,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 190,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.featuredItems.length,
                          separatorBuilder: (_, _) => const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final item = state.featuredItems[index];
                            return FeaturedMediaCard(
                              item: item,
                              isFavorite: state.favoriteIds.contains(item.id),
                              onTap: () => MediaDetails.show(context, item),
                              onFavorite: () => context
                                  .read<CatalogCubit>()
                                  .toggleFavorite(item.id),
                            );
                          },
                        ),
                      ),
                    ],
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            l10n.browseTitle,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        Text(
                          l10n.resultsCount(results.length),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    if (results.isEmpty)
                      CatalogEmptyState(
                        icon: Icons.search_off_rounded,
                        title: l10n.emptyResults,
                        description: l10n.emptyResultsDescription,
                      )
                    else
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 18,
                          childAspectRatio: 0.54,
                        ),
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final item = results[index];
                          return MediaCard(
                            item: item,
                            isFavorite: state.favoriteIds.contains(item.id),
                            onTap: () => MediaDetails.show(context, item),
                            onFavorite: () => context
                                .read<CatalogCubit>()
                                .toggleFavorite(item.id),
                          );
                        },
                      ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _KindChip extends StatelessWidget {
  const _KindChip({
    required this.label,
    required this.icon,
    required this.value,
    required this.selected,
  });

  final String label;
  final IconData icon;
  final CatalogKindFilter value;
  final CatalogKindFilter selected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      selected: value == selected,
      onSelected: (_) => context.read<CatalogCubit>().setKindFilter(value),
    );
  }
}
