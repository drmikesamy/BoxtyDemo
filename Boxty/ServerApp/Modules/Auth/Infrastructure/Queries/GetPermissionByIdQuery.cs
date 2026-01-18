using Boxty.ServerBase.Interfaces;
using Boxty.ServerBase.Mappers;
using Microsoft.EntityFrameworkCore;
using Boxty.ServerApp.Modules.Auth.Entities;
using Boxty.ServerApp.Modules.Auth.Infrastructure.Database;
using Boxty.SharedBase.DTOs.Auth;

namespace Boxty.ServerApp.Modules.Auth.Infrastructure.Queries
{
    public interface IGetPermissionByIdQuery : IQuery
    {
        Task<PermissionDto?> Handle(Guid id);
    }

    public class GetPermissionByIdQuery : IGetPermissionByIdQuery
    {
        private readonly AuthDbContext _dbContext;
        private readonly IMapper<Permission, PermissionDto> _mapper;

        public GetPermissionByIdQuery(AuthDbContext dbContext, IMapper<Permission, PermissionDto> mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public async Task<PermissionDto?> Handle(Guid id)
        {
            var permission = await _dbContext.Set<Permission>().FindAsync(id);
            return permission != null ? _mapper.Map(permission) : null;
        }
    }
}
