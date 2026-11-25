using System;
using System.Threading;
using System.Threading.Tasks;
using System.Web.Http;
using MediaCatalog.Backend.Application.Catalog;
using MediaCatalog.Backend.Infrastructure.Caching;

namespace MediaCatalog.Backend.Api.Controllers
{
    [RoutePrefix("api/v1/media")]
    public sealed class MediaController : ApiController
    {
        private readonly IMediaCatalogApplicationService _applicationService;

        public MediaController(IMediaCatalogApplicationService applicationService)
        {
            _applicationService = applicationService ?? throw new ArgumentNullException(nameof(applicationService));
        }

        [HttpGet, Route("")]
        public async Task<IHttpActionResult> Get(int page = 1, int pageSize = 20, CancellationToken cancellationToken = default(CancellationToken))
        {
            var response = await MemoryResponseCache.GetOrCreateAsync(
                $"media-list-v1-{page}-{pageSize}",
                TimeSpan.FromMinutes(5),
                () => _applicationService.ListAsync(page, pageSize, cancellationToken));
            return Ok(response);
        }

        [HttpGet, Route("{mediaId:guid}")]
        public async Task<IHttpActionResult> Get(Guid mediaId, CancellationToken cancellationToken)
        {
            var item = await MemoryResponseCache.GetOrCreateAsync(
                $"media-item-v1-{mediaId:N}",
                TimeSpan.FromMinutes(10),
                () => _applicationService.FindAsync(mediaId, cancellationToken));
            return item == null ? (IHttpActionResult)NotFound() : Ok(item);
        }
    }
}
