using System;
using System.Runtime.Caching;
using System.Threading.Tasks;

namespace MediaCatalog.Backend.Infrastructure.Caching
{
    public static class MemoryResponseCache
    {
        private static readonly ObjectCache Cache = MemoryCache.Default;

        public static async Task<T> GetOrCreateAsync<T>(string key, TimeSpan lifetime, Func<Task<T>> factory) where T : class
        {
            if (Cache.Get(key) is T cached) return cached;
            var value = await factory();
            if (value != null) Cache.Set(key, value, DateTimeOffset.UtcNow.Add(lifetime));
            return value;
        }
    }
}
