using Boxty.ServerBase.Database;
using Boxty.ServerBase.Mappers;
using Boxty.ServerBase.Modules;
using Boxty.ServerBase.Queries.ModuleQueries;
using Microsoft.AspNetCore.Builder;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Boxty.ServerApp.Modules.Auth.Entities;
using Boxty.ServerApp.Modules.Auth.Infrastructure.Commands;
using Boxty.ServerApp.Modules.Auth.Infrastructure.Database;
using Boxty.ServerApp.Modules.Auth.Infrastructure.Database.Extensions;
using Boxty.ServerApp.Modules.Auth.Infrastructure.Mappers;
using Boxty.ServerApp.Modules.Auth.Infrastructure.Queries;
using Boxty.SharedBase.DTOs.Auth;
using Boxty.ServerBase.Services;

namespace Boxty.ServerApp.Modules.Auth.Infrastructure
{
    public class AuthModule : IModule
    {
        public IServiceCollection RegisterModuleServices(IServiceCollection services, IConfiguration configuration)
        {
            var connectionString = configuration.GetConnectionString("DefaultConnection") ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");
            services.AddDbContext<IDbContext<AuthDbContext>, AuthDbContext>(options =>
                            options.UseNpgsql(configuration.GetConnectionString("DefaultConnection")));

            // Register mappers
            services.AddScoped<IMapper<Role, RoleDto>, RoleMapper>();
            services.AddScoped<IMapper<Permission, PermissionDto>, PermissionMapper>();

            // Register commands and queries
            services.AddScoped<ICreateRoleCommand, CreateRoleCommand>();
            services.AddScoped<IUpdateRoleCommand, UpdateRoleCommand>();
            services.AddScoped<IDeleteRoleCommand, DeleteRoleCommand>();
            services.AddScoped<IGetAllRolesQuery, GetAllRolesQuery>();
            services.AddScoped<IGetRoleByIdQuery, GetRoleByIdQuery>();
            services.AddScoped<IGetAllPermissionsQuery, GetAllPermissionsQuery>();
            services.AddScoped<IGetAllRolesWithPermissionsQuery, GetAllRolesQuery>();

            // Register user encryption key commands and queries
            services.AddScoped<IGetOrCreateUserKeyCommand, GetOrCreateUserKeyCommand>();
            services.AddScoped<IRotateUserKeyCommand, RotateUserKeyCommand>();
            services.AddScoped<IRevokeUserKeyCommand, RevokeUserKeyCommand>();
            services.AddScoped<ICleanupExpiredKeysCommand, CleanupExpiredKeysCommand>();
            services.AddScoped<IGetUserEncryptionKeyQuery, GetUserEncryptionKeyQuery>();

            // Register encryption services
            // Use mock service in development if Azure Key Vault is not configured
            var isDevelopment = configuration.GetValue<string>("ASPNETCORE_ENVIRONMENT") == "Development" || configuration.GetValue<string>("ASPNETCORE_ENVIRONMENT") == "Staging";
            var vaultUrl = configuration["KeyVault:VaultUri"];

            if (isDevelopment && string.IsNullOrEmpty(vaultUrl))
            {
                services.AddScoped<IAzureKeyVaultService, MockAzureKeyVaultService>();
            }
            else
            {
                services.AddScoped<IAzureKeyVaultService, AzureKeyVaultService>();
            }

            return services;
        }
        public WebApplication ConfigureModuleServices(WebApplication app, bool isDevelopment)
        {
            var logger = app.Services.GetRequiredService<ILogger<AuthModule>>();
            logger.LogInformation("Configuring Auth module services...");

            // if (isDevelopment)
            // {
                using (var scope = app.Services.CreateScope())
                {
                    var dbContext = scope.ServiceProvider.GetRequiredService<AuthDbContext>();
                    logger.LogInformation("Running Auth module database migrations...");
                    dbContext.Database.Migrate();

                    logger.LogInformation("Seeding roles and permissions...");
                    RoleSeeder.SeedRolesAndPermissions(dbContext);
                    logger.LogInformation("Auth module database setup completed");
                }
            // }

            logger.LogInformation("Auth module configuration completed");
            return app;
        }
    }
}
