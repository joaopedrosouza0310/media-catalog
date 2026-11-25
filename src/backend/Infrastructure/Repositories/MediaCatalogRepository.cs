using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using MediaCatalog.Backend.Domain.Entities;
using MediaCatalog.Backend.Domain.Repositories;
using MediaCatalog.Backend.Infrastructure.Persistence;

namespace MediaCatalog.Backend.Infrastructure.Repositories
{
    public sealed class MediaCatalogRepository : IMediaCatalogRepository
    {
        private readonly MediaCatalogDbContext _dbContext;

        public MediaCatalogRepository(MediaCatalogDbContext dbContext)
        {
            _dbContext = dbContext ?? throw new ArgumentNullException(nameof(dbContext));
        }

        public async Task<IReadOnlyCollection<MediaItem>> ListAsync(CancellationToken cancellationToken)
        {
            return await _dbContext.MediaItems
                .AsNoTracking()
                .OrderByDescending(item => item.IsFeatured)
                .ThenByDescending(item => item.Rating)
                .ThenBy(item => item.Title)
                .ToArrayAsync(cancellationToken);
        }

        public Task<MediaItem> FindAsync(Guid mediaId, CancellationToken cancellationToken)
        {
            return _dbContext.MediaItems.AsNoTracking().SingleOrDefaultAsync(item => item.Id == mediaId, cancellationToken);
        }
    }
}
