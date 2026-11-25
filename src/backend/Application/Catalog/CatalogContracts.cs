using System;
using System.Collections.Generic;

namespace MediaCatalog.Backend.Application.Catalog
{
    public sealed class MediaItemResponse
    {
        public Guid Id { get; set; }
        public string Title { get; set; }
        public string Type { get; set; }
        public string Genre { get; set; }
        public string Synopsis { get; set; }
        public string Studio { get; set; }
        public int ReleaseYear { get; set; }
        public decimal Rating { get; set; }
        public int? RuntimeMinutes { get; set; }
        public string PosterUrl { get; set; }
        public bool IsFeatured { get; set; }
    }

    public sealed class MediaListResponse
    {
        public IReadOnlyCollection<MediaItemResponse> Items { get; set; }
        public IReadOnlyCollection<string> Genres { get; set; }
        public int Page { get; set; }
        public int PageSize { get; set; }
        public int TotalItems { get; set; }
        public int TotalPages { get; set; }
    }
}
