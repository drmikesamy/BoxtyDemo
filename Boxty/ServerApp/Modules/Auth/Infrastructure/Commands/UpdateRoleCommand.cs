using System.Security.Claims;
using Boxty.ServerBase.Database;
using Boxty.ServerBase.Interfaces;
using Boxty.ServerBase.Mappers;
using Boxty.ServerBase.Services;
using Microsoft.EntityFrameworkCore;
using Boxty.ServerApp.Modules.Auth.Entities;
using Boxty.ServerApp.Modules.Auth.Infrastructure.Database;
using Boxty.SharedBase.DTOs.Auth;

namespace Boxty.ServerApp.Modules.Auth.Infrastructure.Commands
{
    public interface IUpdateRoleCommand : ICommand
    {
        Task<RoleDto> Handle(RoleDto roleDto, ClaimsPrincipal user);
    }

    public class UpdateRoleCommand : IUpdateRoleCommand
    {
        private readonly IDbContext<AuthDbContext> _dbContext;
        private readonly IMapper<Role, RoleDto> _mapper;
        private readonly IRolePermissionCacheService _rolePermissionCacheService;

        public UpdateRoleCommand(IDbContext<AuthDbContext> dbContext, IMapper<Role, RoleDto> mapper, IRolePermissionCacheService rolePermissionCacheService)
        {
            _dbContext = dbContext;
            _mapper = mapper;
            _rolePermissionCacheService = rolePermissionCacheService;
        }

        public async Task<RoleDto> Handle(RoleDto roleDto, ClaimsPrincipal user)
        {
            var entityToUpdate = await _dbContext.Set<Role>()
                .Include(r => r.Permissions) // Load existing permissions
                .FirstOrDefaultAsync(r => r.Id == roleDto.Id);

            if (entityToUpdate == null)
            {
                throw new KeyNotFoundException($"Role with ID {roleDto.Id} not found.");
            }

            // Update scalar properties
            entityToUpdate.Name = roleDto.Name;

            // Manage the Permissions collection
            // Get the IDs of the permissions from the DTO
            var desiredPermissionIds = roleDto.Permissions.Select(p => p.Id).ToHashSet();

            // Fetch the actual Permission entities from the database
            var desiredPermissions = await _dbContext.Set<Permission>()
                .Where(p => desiredPermissionIds.Contains(p.Id))
                .ToListAsync();

            // Verify that all desired permissions were found in the database
            if (desiredPermissions.Count != desiredPermissionIds.Count)
            {
                var foundDbPermissionIds = desiredPermissions.Select(p => p.Id).ToHashSet();
                var missingIds = desiredPermissionIds.Except(foundDbPermissionIds);
                throw new InvalidOperationException($"One or more permissions specified for the role could not be found in the database. Missing IDs: {string.Join(", ", missingIds)}");
            }

            // Update the role's permissions collection
            // Clear existing and add desired ones.
            // EF Core will figure out the changes to the join table.
            entityToUpdate.Permissions.Clear();
            foreach (var permissionToAdd in desiredPermissions)
            {
                entityToUpdate.Permissions.Add(permissionToAdd);
            }

            await _dbContext.SaveChangesAsync();

            // Refresh the role permission cache after successful update
            await _rolePermissionCacheService.InitAsync();

            var updatedDto = _mapper.Map(entityToUpdate); // Map the updated entity back to DTO
            return updatedDto;
        }
    }
}
