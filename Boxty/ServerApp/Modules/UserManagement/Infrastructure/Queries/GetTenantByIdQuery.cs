using Boxty.ServerBase.Interfaces;
using Boxty.ServerBase.Mappers;
using Microsoft.EntityFrameworkCore;
using Boxty.ServerApp.Modules.UserManagement.Entities;
using Boxty.ServerApp.Modules.UserManagement.Infrastructure.Database;
using Boxty.ServerApp.Modules.Shared.Contracts;
using Boxty.SharedApp.DTOs.UserManagement;

namespace Boxty.ServerApp.Modules.UserManagement.Infrastructure.Queries
{
    public class GetTenantByIdQuery : IGetTenantByIdQuery, IQuery
    {
        private readonly UserManagementDbContext _dbContext;
        private readonly IMapper<Tenant, TenantDto> _mapper;

        public GetTenantByIdQuery(UserManagementDbContext dbContext, IMapper<Tenant, TenantDto> mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public async Task<TenantDto?> Handle(Guid tenantId)
        {
            var tenant = await _dbContext.Set<Tenant>()
                .AsNoTracking()
                .FirstOrDefaultAsync(c => c.Id == tenantId);

            return tenant != null ? _mapper.Map(tenant) : null;
        }
    }
}
