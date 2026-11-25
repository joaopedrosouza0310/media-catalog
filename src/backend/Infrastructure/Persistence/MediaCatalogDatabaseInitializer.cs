using System;
using System.Data.Entity;
using MediaCatalog.Backend.Domain.Entities;
using MediaCatalog.Backend.Domain.Enums;

namespace MediaCatalog.Backend.Infrastructure.Persistence
{
    public sealed class MediaCatalogDatabaseInitializer : DropCreateDatabaseIfModelChanges<MediaCatalogDbContext>
    {
        protected override void Seed(MediaCatalogDbContext context)
        {
            context.MediaItems.Add(new MediaItem(Guid.Parse("3f1e1d9b-0cf6-4cb4-8e19-5e7d12ad1001"), "Dune: Part Two", MediaType.Movie, "Science Fiction", "Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.", "Legendary Pictures", 2024, 8.5m, 166, "https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg", true));
            context.MediaItems.Add(new MediaItem(Guid.Parse("3f1e1d9b-0cf6-4cb4-8e19-5e7d12ad1002"), "Oppenheimer", MediaType.Movie, "Drama", "The story of J. Robert Oppenheimer and his role in the development of the atomic bomb during World War II.", "Universal Pictures", 2023, 8.1m, 181, "https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg", true));
            context.MediaItems.Add(new MediaItem(Guid.Parse("3f1e1d9b-0cf6-4cb4-8e19-5e7d12ad1003"), "Spider-Man: Across the Spider-Verse", MediaType.Movie, "Animation", "Miles Morales is catapulted across the Multiverse, where he meets a team of Spider-People charged with protecting its existence.", "Sony Pictures Animation", 2023, 8.4m, 140, "https://image.tmdb.org/t/p/w500/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg", false));
            context.MediaItems.Add(new MediaItem(Guid.Parse("3f1e1d9b-0cf6-4cb4-8e19-5e7d12ad1004"), "The Batman", MediaType.Movie, "Crime", "Batman ventures into Gotham City's underworld when a sadistic killer leaves behind a trail of cryptic clues.", "Warner Bros. Pictures", 2022, 7.7m, 176, "https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg", false));
            context.MediaItems.Add(new MediaItem(Guid.Parse("3f1e1d9b-0cf6-4cb4-8e19-5e7d12ad1005"), "Parasite", MediaType.Movie, "Thriller", "A struggling family gradually infiltrates the home of a wealthy household with unexpected consequences.", "CJ Entertainment", 2019, 8.5m, 133, "https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg", false));
            context.MediaItems.Add(new MediaItem(Guid.Parse("3f1e1d9b-0cf6-4cb4-8e19-5e7d12ad1006"), "Breaking Bad", MediaType.Series, "Crime", "A chemistry teacher diagnosed with cancer turns to manufacturing methamphetamine to secure his family's future.", "AMC", 2008, 9.5m, 47, "https://image.tmdb.org/t/p/w500/ztkUQFLlC19CCMYHW9o1zWhJRNq.jpg", true));
            context.MediaItems.Add(new MediaItem(Guid.Parse("3f1e1d9b-0cf6-4cb4-8e19-5e7d12ad1007"), "The Last of Us", MediaType.Series, "Drama", "A hardened survivor escorts a teenage girl across a post-apocalyptic United States after a devastating fungal outbreak.", "HBO", 2023, 8.7m, 59, "https://image.tmdb.org/t/p/w500/uKvVjHNqB5VmOrdxqAt2F7J78ED.jpg", true));
            context.MediaItems.Add(new MediaItem(Guid.Parse("3f1e1d9b-0cf6-4cb4-8e19-5e7d12ad1008"), "Stranger Things", MediaType.Series, "Science Fiction", "When a boy vanishes, a small town uncovers a mystery involving secret experiments and supernatural forces.", "Netflix", 2016, 8.7m, 51, "https://image.tmdb.org/t/p/w500/49WJfeN0moxb9IPfGn8AIqMGskD.jpg", false));
            context.MediaItems.Add(new MediaItem(Guid.Parse("3f1e1d9b-0cf6-4cb4-8e19-5e7d12ad1009"), "Arcane", MediaType.Series, "Animation", "Two sisters find themselves on rival sides of a conflict between the prosperous city of Piltover and the oppressed underground of Zaun.", "Netflix", 2021, 9.0m, 41, "https://image.tmdb.org/t/p/w500/fqldf2t8ztc9aiwn3k6mlX3tvRT.jpg", false));
            context.MediaItems.Add(new MediaItem(Guid.Parse("3f1e1d9b-0cf6-4cb4-8e19-5e7d12ad1010"), "Severance", MediaType.Series, "Mystery", "Office workers undergo a procedure that surgically divides their work memories from their personal lives.", "Apple TV+", 2022, 8.7m, 50, "https://image.tmdb.org/t/p/w500/lFf6LLrQjYldcZItzOkGmMMigP7.jpg", false));
            context.SaveChanges();
        }
    }
}
