using System;
using System.Collections.Generic;
using System.Web.Http.Dependencies;
using MediaCatalog.Backend.Api.Controllers;
using MediaCatalog.Backend.Application.Catalog;
using MediaCatalog.Backend.Infrastructure.Persistence;
using MediaCatalog.Backend.Infrastructure.Repositories;

namespace MediaCatalog.Backend.Infrastructure.Composition
{
    public sealed class ApiDependencyResolver : IDependencyResolver
    {
        public IDependencyScope BeginScope() => new ApiRequestScope();
        public object GetService(Type serviceType) => null;
        public IEnumerable<object> GetServices(Type serviceType) => Array.Empty<object>();
        public void Dispose() { }

        private sealed class ApiRequestScope : IDependencyScope
        {
            private readonly MediaCatalogDbContext _dbContext = new MediaCatalogDbContext();

            public object GetService(Type serviceType)
            {
                var applicationService = new MediaCatalogApplicationService(new MediaCatalogRepository(_dbContext));
                if (serviceType == typeof(MediaController)) return new MediaController(applicationService);
                if (serviceType == typeof(IMediaCatalogApplicationService)) return applicationService;
                return null;
            }

            public IEnumerable<object> GetServices(Type serviceType) => Array.Empty<object>();
            public void Dispose() => _dbContext.Dispose();
        }
    }
}
