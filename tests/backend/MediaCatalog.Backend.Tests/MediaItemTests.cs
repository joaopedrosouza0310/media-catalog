using System;
using MediaCatalog.Backend.Domain.Entities;
using MediaCatalog.Backend.Domain.Enums;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MediaCatalog.Backend.Tests
{
    [TestClass]
    public sealed class MediaItemTests
    {
        [TestMethod]
        public void Constructor_rejects_invalid_rating()
        {
            Assert.ThrowsException<ArgumentOutOfRangeException>(() => Create(rating: 11m));
        }

        [TestMethod]
        public void Constructor_rejects_relative_poster_url()
        {
            Assert.ThrowsException<ArgumentException>(() => new MediaItem(
                Guid.NewGuid(), "Title", MediaType.Movie, "Drama", "Synopsis", "Studio",
                2024, 8m, 120, "/poster.jpg", false));
        }

        private static MediaItem Create(decimal rating) => new MediaItem(
            Guid.NewGuid(), "Title", MediaType.Movie, "Drama", "Synopsis", "Studio",
            2024, rating, 120, "https://example.com/poster.jpg", false);
    }
}
