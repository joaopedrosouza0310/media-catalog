enum MediaKind { movie, series }

final class MediaItem {
  const MediaItem({
    required this.id,
    required this.title,
    required this.kind,
    required this.genre,
    required this.synopsis,
    required this.studio,
    required this.releaseYear,
    required this.rating,
    required this.runtimeMinutes,
    required this.posterUrl,
    required this.isFeatured,
  });

  final String id;
  final String title;
  final MediaKind kind;
  final String genre;
  final String synopsis;
  final String studio;
  final int releaseYear;
  final double rating;
  final int? runtimeMinutes;
  final String posterUrl;
  final bool isFeatured;
}
