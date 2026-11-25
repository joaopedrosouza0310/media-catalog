using System.Data.Entity;
using MediaCatalog.Backend.Domain.Entities;

namespace MediaCatalog.Backend.Infrastructure.Persistence
{
    public sealed class MediaCatalogDbContext : DbContext
    {
        public MediaCatalogDbContext() : base("name=MediaCatalogConnection") { }

        public DbSet<MediaItem> MediaItems { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            var media = modelBuilder.Entity<MediaItem>();
            media.ToTable("MediaItems").HasKey(item => item.Id);
            media.Property(item => item.Title).IsRequired().HasMaxLength(160);
            media.Property(item => item.Genre).IsRequired().HasMaxLength(80);
            media.Property(item => item.Synopsis).IsRequired().HasMaxLength(1200);
            media.Property(item => item.Studio).IsRequired().HasMaxLength(120);
            media.Property(item => item.Rating).HasPrecision(3, 1);
            media.Property(item => item.PosterUrl).IsRequired().HasMaxLength(500);
            media.HasIndex(item => new { item.Type, item.Genre, item.ReleaseYear });

            base.OnModelCreating(modelBuilder);
        }
    }
}
