using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using MediaCatalog.Backend.Domain.Entities;
using MediaCatalog.Backend.Domain.Repositories;

namespace MediaCatalog.Backend.Application.Catalog
{
    public sealed class MediaCatalogApplicationService : IMediaCatalogApplicationService
    {
        private readonly IMediaCatalogRepository _repository;

        public MediaCatalogApplicationService(IMediaCatalogRepository repository)
        {
            _repository = repository ?? throw new ArgumentNullException(nameof(repository));
        }

        public async Task<MediaListResponse> ListAsync(CancellationToken cancellationToken)
        {
            var media = await _repository.ListAsync(cancellationToken);
            return new MediaListResponse
            {
                Items = media.Select(Map).ToArray(),
                Genres = media.Select(item => item.Genre).Distinct().OrderBy(genre => genre).ToArray()
            };
        }

        public async Task<MediaItemResponse> FindAsync(Guid mediaId, CancellationToken cancellationToken)
        {
            var item = await _repository.FindAsync(mediaId, cancellationToken);
            return item == null ? null : Map(item);
        }

        private static MediaItemResponse Map(MediaItem item)
        {
            return new MediaItemResponse
            {
                Id = item.Id,
                Title = item.Title,
                Type = item.Type.ToString(),
                Genre = item.Genre,
                Synopsis = item.Synopsis,
                Studio = item.Studio,
                ReleaseYear = item.ReleaseYear,
                Rating = item.Rating,
                RuntimeMinutes = item.RuntimeMinutes,
                PosterUrl = item.PosterUrl,
                IsFeatured = item.IsFeatured
            };
        }
    }
}
