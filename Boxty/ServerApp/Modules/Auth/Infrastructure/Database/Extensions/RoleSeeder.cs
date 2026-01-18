using Boxty.SharedBase.Interfaces;
using Microsoft.EntityFrameworkCore;
using Boxty.ServerApp.Modules.Auth.Entities;
using Boxty.ServerApp.Modules.Auth.Infrastructure.Database;
using Boxty.ServerApp.Modules.Auth.Infrastructure.Database.Enums;

namespace Boxty.ServerApp.Modules.Auth.Infrastructure.Database.Extensions
{
    public static class RoleSeeder
    {
        public static void SeedRolesAndPermissions(AuthDbContext dbContext)
        {

            // Scan all loaded assemblies for IEntity implementations
            var entityTypes = AppDomain.CurrentDomain.GetAssemblies()
                .SelectMany(a => a.GetTypes())
                .Where(t => t.IsClass && !t.IsAbstract && t.GetInterfaces().Any(i => i.Name == "IEntity" || i.Name == "ISimpleEntity"))
                .ToList();

            foreach (var entityType in entityTypes)
            {
                foreach (var permission in Enum.GetValues<PermissionEnum>())
                {
                    if (permission == PermissionEnum.Finalise && !entityType.GetInterfaces().Contains(typeof(IDraftable)))
                    {
                        continue;
                    }
                    var permissionName = $"{permission}{entityType.Name}";
                    if (dbContext.Permissions.Any(p => p.Name == permissionName))
                    {
                        continue;
                    }
                    var newPermission = new Permission
                    {
                        Name = permissionName
                    };
                    dbContext.Permissions.Add(newPermission);
                }
            }
            dbContext.SaveChanges();

            // Seed Administrator role with Role-specific permissions
            SeedAdministratorRole(dbContext);
        }

        private static void SeedAdministratorRole(AuthDbContext dbContext)
        {
            const string adminRoleName = "Administrator";

            // Check if Administrator role already exists, create if it doesn't
            var adminRole = dbContext.Roles
                .Include(r => r.Permissions)
                .FirstOrDefault(r => r.Name == adminRoleName);

            if (adminRole == null)
            {
                adminRole = new Role
                {
                    Name = adminRoleName,
                    Permissions = new List<Permission>()
                };
                dbContext.Roles.Add(adminRole);
                dbContext.SaveChanges(); // Save to get the role ID
            }

            // Define the Role-specific permissions that Administrator should have
            var rolePermissionNames = new[]
            {
                "ViewRole",
                "CreateRole",
                "UpdateRole",
                "DeleteRole",
                "ViewPermission",
                "CreatePermission",
                "UpdatePermission",
                "DeletePermission"
            };

            // Get the Role permissions from the database
            var rolePermissions = dbContext.Permissions
                .Where(p => rolePermissionNames.Contains(p.Name))
                .ToList();

            // Add missing permissions to Administrator role
            foreach (var permission in rolePermissions)
            {
                if (!adminRole.Permissions.Any(p => p.Id == permission.Id))
                {
                    adminRole.Permissions.Add(permission);
                }
            }

            dbContext.SaveChanges();
        }
    }
}
