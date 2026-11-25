using System;
using System.Collections.Concurrent;
using System.Configuration;
using System.Net;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using MediaCatalog.Backend.Api.Models;

namespace MediaCatalog.Backend.Api.Handlers
{
    public sealed class RateLimitHandler : DelegatingHandler
    {
        private sealed class Counter { public DateTime WindowStartedUtc; public int Count; }
        private static readonly TimeSpan Window = TimeSpan.FromMinutes(1);

        private readonly ConcurrentDictionary<string, Counter> _counters = new ConcurrentDictionary<string, Counter>();
        private readonly int _limit;
        private readonly Func<HttpRequestMessage, string> _clientKeyProvider;
        private readonly Func<DateTime> _utcNow;

        public RateLimitHandler()
            : this(GetConfiguredLimit(), GetClientKey, () => DateTime.UtcNow)
        {
        }

        public RateLimitHandler(int limit, Func<HttpRequestMessage, string> clientKeyProvider, Func<DateTime> utcNow)
        {
            if (limit <= 0) throw new ArgumentOutOfRangeException(nameof(limit));
            _limit = limit;
            _clientKeyProvider = clientKeyProvider ?? throw new ArgumentNullException(nameof(clientKeyProvider));
            _utcNow = utcNow ?? throw new ArgumentNullException(nameof(utcNow));
        }

        protected override Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
        {
            var key = _clientKeyProvider(request);
            var now = _utcNow();
            var counter = _counters.GetOrAdd(key, _ => new Counter { WindowStartedUtc = now });
            lock (counter)
            {
                if (now - counter.WindowStartedUtc >= Window)
                {
                    counter.WindowStartedUtc = now;
                    counter.Count = 0;
                }
                counter.Count++;
                if (counter.Count > _limit)
                {
                    var correlationId = request.Properties.TryGetValue(RequestLoggingHandler.CorrelationIdProperty, out var value) ? value as string : null;
                    var response = request.CreateResponse((HttpStatusCode)429, new ApiError("rate_limit_exceeded", "Too many requests. Try again shortly.", correlationId));
                    response.Headers.RetryAfter = new System.Net.Http.Headers.RetryConditionHeaderValue(counter.WindowStartedUtc.Add(Window));
                    return Task.FromResult(response);
                }
            }
            return base.SendAsync(request, cancellationToken);
        }

        private static int GetConfiguredLimit()
        {
            return int.TryParse(ConfigurationManager.AppSettings["RateLimitPerMinute"], out var configured) && configured > 0
                ? configured
                : 120;
        }

        private static string GetClientKey(HttpRequestMessage request)
        {
            return HttpContext.Current?.Request?.UserHostAddress ?? "unknown";
        }
    }
}
