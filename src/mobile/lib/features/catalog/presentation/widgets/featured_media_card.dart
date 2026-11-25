import 'package:flutter/material.dart';
import 'package:media_catalog_app/features/catalog/domain/entities/media_item.dart';
import 'package:media_catalog_app/features/catalog/presentation/widgets/media_poster.dart';
import 'package:media_catalog_app/generated/app_localizations.dart';

class FeaturedMediaCard extends StatelessWidget {
  const FeaturedMediaCard({
    super.key,
    required this.item,
    required this.isFavorite,
    required this.onTap,
    required this.onFavorite,
  });

  final MediaItem item;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      width: 280,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: [
              SizedBox(width: 112, child: MediaPoster(item: item)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          tooltip: isFavorite
                              ? l10n.removeFavorite
                              : l10n.addFavorite,
                          onPressed: onFavorite,
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: isFavorite ? colors.error : null,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        item.kind == MediaKind.movie
                            ? l10n.movieLabel.toUpperCase()
                            : l10n.seriesLabel.toUpperCase(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 17,
                            color: colors.primary,
                          ),
                          const SizedBox(width: 3),
                          Text(item.rating.toStringAsFixed(1)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
