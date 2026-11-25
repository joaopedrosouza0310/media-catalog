using System;
using System.Threading;
using System.Threading.Tasks;
using System.Web.Http;
using MediaCatalog.Backend.Application.Catalog;

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
        public async Task<IHttpActionResult> Get(CancellationToken cancellationToken)
        {
            return Ok(await _applicationService.ListAsync(cancellationToken));
        }

        [HttpGet, Route("{mediaId:guid}")]
        public async Task<IHttpActionResult> Get(Guid mediaId, CancellationToken cancellationToken)
        {
            var item = await _applicationService.FindAsync(mediaId, cancellationToken);
            return item == null ? (IHttpActionResult)NotFound() : Ok(item);
        }
    }
}
