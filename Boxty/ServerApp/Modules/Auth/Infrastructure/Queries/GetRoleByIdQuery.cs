using Boxty.ServerBase.Interfaces;
using Boxty.ServerBase.Mappers;
using Microsoft.EntityFrameworkCore;
using Boxty.ServerApp.Modules.Auth.Entities;
using Boxty.ServerApp.Modules.Auth.Infrastructure.Database;
using Boxty.SharedBase.DTOs.Auth;

namespace Boxty.ServerApp.Modules.Auth.Infrastructure.Queries
{
    public interface IGetRoleByIdQuery : IQuery
    {
        Task<RoleDto?> Handle(Guid id);
    }

    public class GetRoleByIdQuery : IGetRoleByIdQuery
    {
        private readonly AuthDbContext _dbContext;
        private readonly IMapper<Role, RoleDto> _mapper;

        public GetRoleByIdQuery(AuthDbContext dbContext, IMapper<Role, RoleDto> mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public async Task<RoleDto?> Handle(Guid id)
        {
            var role = await _dbContext.Set<Role>()
                .Include(r => r.Permissions)
                .FirstOrDefaultAsync(r => r.Id == id);

            return role != null ? _mapper.Map(role) : null;
        }
    }
}
