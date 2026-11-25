using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using MediaCatalog.Backend.Domain.Entities;

namespace MediaCatalog.Backend.Domain.Repositories
{
    public interface IMediaCatalogRepository
    {
        Task<IReadOnlyCollection<MediaItem>> ListAsync(CancellationToken cancellationToken);
        Task<MediaItem> FindAsync(Guid mediaId, CancellationToken cancellationToken);
    }
}
