import 'package:flutter/material.dart';
import 'package:media_catalog_app/features/catalog/domain/entities/media_item.dart';

class MediaPoster extends StatelessWidget {
  const MediaPoster({
    super.key,
    required this.item,
    this.borderRadius = const BorderRadius.all(Radius.circular(18)),
  });

  final MediaItem item;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: Image.network(
          item.posterUrl,
          fit: BoxFit.cover,
          semanticLabel: item.title,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded || frame != null) return child;
            return const ColoredBox(
              color: Color(0xFFE9E5F0),
              child: Center(child: CircularProgressIndicator()),
            );
          },
          errorBuilder: (context, error, stackTrace) => ColoredBox(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Icon(
              item.kind == MediaKind.movie
                  ? Icons.movie_outlined
                  : Icons.live_tv_outlined,
              size: 44,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
