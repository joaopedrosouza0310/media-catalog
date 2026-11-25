import 'package:flutter/material.dart';
import 'package:media_catalog_app/features/catalog/domain/entities/media_item.dart';
import 'package:media_catalog_app/features/catalog/presentation/widgets/media_poster.dart';
import 'package:media_catalog_app/generated/app_localizations.dart';

class MediaDetailSheet extends StatelessWidget {
  const MediaDetailSheet({
    super.key,
    required this.item,
    required this.isFavorite,
    required this.onFavorite,
  });

  final MediaItem item;
  final bool isFavorite;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.88,
      minChildSize: 0.55,
      maxChildSize: 0.95,
      builder: (context, controller) => ListView(
        controller: controller,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 36),
        children: [
          Center(
            child: Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: colors.outlineVariant,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 132, child: MediaPoster(item: item)),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.kind == MediaKind.movie
                          ? l10n.movieLabel.toUpperCase()
                          : l10n.seriesLabel.toUpperCase(),
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 7,
                      runSpacing: 7,
                      children: [
                        _InfoChip(
                          icon: Icons.star_rounded,
                          label: l10n.rating(item.rating.toStringAsFixed(1)),
                        ),
                        _InfoChip(
                          icon: Icons.calendar_today_outlined,
                          label: item.releaseYear.toString(),
                        ),
                        if (item.runtimeMinutes case final runtime?)
                          _InfoChip(
                            icon: Icons.schedule_rounded,
                            label: l10n.runtime(runtime),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: onFavorite,
            icon: Icon(
              isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
            ),
            label: Text(isFavorite ? l10n.removeFavorite : l10n.addFavorite),
          ),
          const SizedBox(height: 26),
          Text(
            l10n.aboutTitle,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          Text(
            item.synopsis,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
          ),
          const SizedBox(height: 24),
          _DetailRow(
            icon: Icons.apartment_rounded,
            label: l10n.studioLabel,
            value: item.studio,
          ),
          const SizedBox(height: 14),
          _DetailRow(
            icon: Icons.category_outlined,
            label: l10n.genreLabel,
            value: item.genre,
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      visualDensity: VisualDensity.compact,
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: colors.secondaryContainer,
          foregroundColor: colors.onSecondaryContainer,
          child: Icon(icon, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 3),
              Text(value, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}
