import 'package:media_catalog_app/features/catalog/domain/entities/media_item.dart';

final class MediaItemModel {
  const MediaItemModel({
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

  factory MediaItemModel.fromJson(Map<String, dynamic> json) => MediaItemModel(
    id: json['id'] as String,
    title: json['title'] as String,
    kind: (json['type'] as String).toLowerCase() == 'movie'
        ? MediaKind.movie
        : MediaKind.series,
    genre: json['genre'] as String,
    synopsis: json['synopsis'] as String,
    studio: json['studio'] as String,
    releaseYear: json['releaseYear'] as int,
    rating: (json['rating'] as num).toDouble(),
    runtimeMinutes: json['runtimeMinutes'] as int?,
    posterUrl: json['posterUrl'] as String,
    isFeatured: json['isFeatured'] as bool? ?? false,
  );

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

  MediaItem toDomain() => MediaItem(
    id: id,
    title: title,
    kind: kind,
    genre: genre,
    synopsis: synopsis,
    studio: studio,
    releaseYear: releaseYear,
    rating: rating,
    runtimeMinutes: runtimeMinutes,
    posterUrl: posterUrl,
    isFeatured: isFeatured,
  );
}
