import 'package:flutter/material.dart';
import 'package:media_catalog_app/generated/app_localizations.dart';

class DiscoverHero extends StatelessWidget {
  const DiscoverHero({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primary, colors.tertiary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -24,
            bottom: -28,
            child: Icon(
              Icons.movie_filter_rounded,
              size: 160,
              color: colors.onPrimary.withValues(alpha: 0.10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.discoverEyebrow,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: colors.onPrimary.withValues(alpha: 0.82),
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  l10n.discoverTitle,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.discoverSubtitle,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colors.onPrimary.withValues(alpha: 0.86),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
