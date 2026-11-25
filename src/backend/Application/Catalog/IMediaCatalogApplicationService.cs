using System;
using System.Threading;
using System.Threading.Tasks;

namespace MediaCatalog.Backend.Application.Catalog
{
    public interface IMediaCatalogApplicationService
    {
        Task<MediaListResponse> ListAsync(CancellationToken cancellationToken);
        Task<MediaItemResponse> FindAsync(Guid mediaId, CancellationToken cancellationToken);
    }
}
