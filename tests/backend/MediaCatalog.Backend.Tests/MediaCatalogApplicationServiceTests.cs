using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using MediaCatalog.Backend.Application.Catalog;
using MediaCatalog.Backend.Domain.Entities;
using MediaCatalog.Backend.Domain.Enums;
using MediaCatalog.Backend.Domain.Repositories;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MediaCatalog.Backend.Tests
{
    [TestClass]
    public sealed class MediaCatalogApplicationServiceTests
    {
        [TestMethod]
        public async Task List_returns_requested_page_with_total_metadata_and_all_genres()
        {
            var repository = new RepositoryFake(new[]
            {
                Create("One", "Drama"), Create("Two", "Drama"), Create("Three", "Science Fiction")
            });
            var service = new MediaCatalogApplicationService(repository);

            var result = await service.ListAsync(2, 2, CancellationToken.None);

            Assert.AreEqual(1, result.Items.Count);
            Assert.AreEqual(3, result.TotalItems);
            Assert.AreEqual(2, result.TotalPages);
            CollectionAssert.AreEquivalent(new[] { "Drama", "Science Fiction" }, result.Genres.ToArray());
        }

        [TestMethod]
        public async Task Find_returns_null_for_unknown_identifier()
        {
            var service = new MediaCatalogApplicationService(new RepositoryFake(Array.Empty<MediaItem>()));
            Assert.IsNull(await service.FindAsync(Guid.NewGuid(), CancellationToken.None));
        }

        private static MediaItem Create(string title, string genre) => new MediaItem(
            Guid.NewGuid(), title, MediaType.Movie, genre, "Synopsis", "Studio", 2024, 8m,
            120, "https://example.com/poster.jpg", false);

        private sealed class RepositoryFake : IMediaCatalogRepository
        {
            private readonly IReadOnlyCollection<MediaItem> _items;
            public RepositoryFake(IReadOnlyCollection<MediaItem> items) => _items = items;
            public Task<IReadOnlyCollection<MediaItem>> ListAsync(CancellationToken cancellationToken) => Task.FromResult(_items);
            public Task<MediaItem> FindAsync(Guid mediaId, CancellationToken cancellationToken) => Task.FromResult(_items.FirstOrDefault(item => item.Id == mediaId));
        }
    }
}
