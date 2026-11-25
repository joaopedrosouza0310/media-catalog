import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_catalog_app/features/catalog/presentation/cubit/catalog_cubit.dart';
import 'package:media_catalog_app/features/catalog/presentation/cubit/catalog_state.dart';
import 'package:media_catalog_app/features/catalog/presentation/widgets/catalog_empty_state.dart';
import 'package:media_catalog_app/features/catalog/presentation/widgets/media_card.dart';
import 'package:media_catalog_app/features/catalog/presentation/widgets/media_details.dart';
import 'package:media_catalog_app/generated/app_localizations.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<CatalogCubit, CatalogState>(
      builder: (context, state) => SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 850
                ? 5
                : constraints.maxWidth >= 600
                ? 3
                : 2;
            final items = state.favoriteItems;
            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.favoritesTitle,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          l10n.favoritesSubtitle,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (items.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: CatalogEmptyState(
                      icon: Icons.favorite_border_rounded,
                      title: l10n.emptyFavorites,
                      description: l10n.emptyFavoritesDescription,
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                    sliver: SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 18,
                        childAspectRatio: 0.54,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return MediaCard(
                          item: item,
                          isFavorite: true,
                          onTap: () => MediaDetails.show(context, item),
                          onFavorite: () => context
                              .read<CatalogCubit>()
                              .toggleFavorite(item.id),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
