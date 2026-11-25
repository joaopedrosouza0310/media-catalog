using System;
using MediaCatalog.Backend.Domain.Enums;

namespace MediaCatalog.Backend.Domain.Entities
{
    public sealed class MediaItem
    {
        private MediaItem() { }

        public MediaItem(
            Guid id,
            string title,
            MediaType type,
            string genre,
            string synopsis,
            string studio,
            int releaseYear,
            decimal rating,
            int? runtimeMinutes,
            string posterUrl,
            bool isFeatured)
        {
            if (id == Guid.Empty) throw new ArgumentException("A media identifier is required.", nameof(id));
            if (string.IsNullOrWhiteSpace(title)) throw new ArgumentException("A title is required.", nameof(title));
            if (string.IsNullOrWhiteSpace(genre)) throw new ArgumentException("A genre is required.", nameof(genre));
            if (string.IsNullOrWhiteSpace(synopsis)) throw new ArgumentException("A synopsis is required.", nameof(synopsis));
            if (string.IsNullOrWhiteSpace(studio)) throw new ArgumentException("A studio is required.", nameof(studio));
            if (releaseYear < 1900 || releaseYear > DateTime.UtcNow.Year + 2) throw new ArgumentOutOfRangeException(nameof(releaseYear));
            if (rating < 0 || rating > 10) throw new ArgumentOutOfRangeException(nameof(rating));
            if (!Uri.TryCreate(posterUrl, UriKind.Absolute, out _)) throw new ArgumentException("A valid poster URL is required.", nameof(posterUrl));

            Id = id;
            Title = title.Trim();
            Type = type;
            Genre = genre.Trim();
            Synopsis = synopsis.Trim();
            Studio = studio.Trim();
            ReleaseYear = releaseYear;
            Rating = rating;
            RuntimeMinutes = runtimeMinutes;
            PosterUrl = posterUrl.Trim();
            IsFeatured = isFeatured;
        }

        public Guid Id { get; private set; }
        public string Title { get; private set; }
        public MediaType Type { get; private set; }
        public string Genre { get; private set; }
        public string Synopsis { get; private set; }
        public string Studio { get; private set; }
        public int ReleaseYear { get; private set; }
        public decimal Rating { get; private set; }
        public int? RuntimeMinutes { get; private set; }
        public string PosterUrl { get; private set; }
        public bool IsFeatured { get; private set; }
    }
}
