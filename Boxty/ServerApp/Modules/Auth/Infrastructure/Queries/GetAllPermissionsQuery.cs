using Boxty.ServerBase.Interfaces;
using Boxty.ServerBase.Mappers;
using Microsoft.EntityFrameworkCore;
using Boxty.ServerApp.Modules.Auth.Entities;
using Boxty.ServerApp.Modules.Auth.Infrastructure.Database;
using Boxty.SharedBase.DTOs.Auth;

namespace Boxty.ServerApp.Modules.Auth.Infrastructure.Queries
{
    public interface IGetAllPermissionsQuery : IQuery
    {
        Task<IEnumerable<PermissionDto>> Handle();
    }

    public class GetAllPermissionsQuery : IGetAllPermissionsQuery
    {
        private readonly AuthDbContext _dbContext;
        private readonly IMapper<Permission, PermissionDto> _mapper;

        public GetAllPermissionsQuery(AuthDbContext dbContext, IMapper<Permission, PermissionDto> mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public async Task<IEnumerable<PermissionDto>> Handle()
        {
            var permissions = await _dbContext.Set<Permission>().ToListAsync();
            return _mapper.Map(permissions).ToList();
        }
    }
}
