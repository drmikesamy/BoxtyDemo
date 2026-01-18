using Boxty.ServerBase.Interfaces;
using Boxty.ServerBase.Mappers;
using Boxty.ServerBase.Queries.ModuleQueries;
using Boxty.ServerBase.Services;
using Microsoft.EntityFrameworkCore;
using Boxty.ServerApp.Modules.Auth.Entities;
using Boxty.ServerApp.Modules.Auth.Infrastructure.Database;
using Boxty.SharedBase.DTOs.Auth;
using System.Security.Claims;

namespace Boxty.ServerApp.Modules.Auth.Infrastructure.Queries
{
    public interface IGetAllRolesQuery : IQuery
    {
        Task<IEnumerable<RoleDto>> Handle(ClaimsPrincipal user);
    }

    public class GetAllRolesQuery : IGetAllRolesQuery, IGetAllRolesWithPermissionsQuery
    {
        private readonly AuthDbContext _dbContext;
        private readonly IMapper<Role, RoleDto> _mapper;
        private readonly IUserContextService _userContextService;

        public GetAllRolesQuery(AuthDbContext dbContext, IMapper<Role, RoleDto> mapper, IUserContextService userContextService)
        {
            _dbContext = dbContext;
            _mapper = mapper;
            _userContextService = userContextService;
        }

        public async Task<IEnumerable<RoleDto>> Handle(ClaimsPrincipal user)
        {
            // Validate authorization
            ValidateAuthorization(user);

            // Check if user is an administrator
            var userRoles = _userContextService.GetRoles(user);
            var isAdministrator = userRoles.Any(role => 
                string.Equals(role, "administrator", StringComparison.OrdinalIgnoreCase));

            // Get all roles from database
            var allRoles = await _dbContext.Set<Role>()
                .Include(r => r.Permissions)
                .ToListAsync();

            // If not an administrator, exclude the administrator role
            if (!isAdministrator)
            {
                allRoles = allRoles.Where(r => !string.Equals(r.Name, "administrator", StringComparison.OrdinalIgnoreCase)).ToList();
            }

            return _mapper.Map(allRoles).ToList();
        }

        // For backward compatibility with IGetAllRolesWithPermissionsQuery
        // Used by RolePermissionCacheService to populate role cache at startup
        public async Task<IEnumerable<RoleDto>> Handle()
        {
            var roles = await _dbContext.Set<Role>()
                .Include(r => r.Permissions)
                .ToListAsync();

            return _mapper.Map(roles).ToList();
        }

        /// <summary>
        /// Validates that the user has permission to view roles
        /// </summary>
        /// <param name="user">The current user's claims principal</param>
        /// <exception cref="UnauthorizedAccessException">Thrown when the user lacks permission to view roles</exception>
        private void ValidateAuthorization(ClaimsPrincipal user)
        {
            if (user?.Identity?.IsAuthenticated != true)
            {
                throw new UnauthorizedAccessException("User must be authenticated to view roles.");
            }

            // Get current user's roles
            var userRoles = _userContextService.GetRoles(user);
            if (userRoles == null || !userRoles.Any())
            {
                throw new UnauthorizedAccessException("User has no assigned roles.");
            }

            // Check if user has permission to view roles (only administrators and tenant administrators)
            var hasViewPermission = userRoles.Any(role =>
                string.Equals(role, "administrator", StringComparison.OrdinalIgnoreCase) ||
                string.Equals(role, "tenantadministrator", StringComparison.OrdinalIgnoreCase));

            if (!hasViewPermission)
            {
                var allRoles = string.Join(", ", userRoles);
                throw new UnauthorizedAccessException($"Only administrators and tenant administrators can view roles. User has roles: {allRoles}");
            }
        }
    }
}
