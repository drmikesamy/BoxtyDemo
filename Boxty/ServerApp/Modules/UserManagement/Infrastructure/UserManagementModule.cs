using Boxty.ServerBase.Auth.Providers;
using Boxty.ServerBase.Database;
using Boxty.ServerBase.Modules;
using Boxty.ServerBase.Queries;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Builder;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Boxty.ServerApp.Modules.UserManagement.Entities;
using Boxty.ServerApp.Modules.UserManagement.Infrastructure.AuthorizationHandlers;
using Boxty.ServerApp.Modules.UserManagement.Infrastructure.Database;
using Boxty.ServerApp.Modules.UserManagement.Infrastructure.Queries;
using Boxty.ServerApp.Modules.Shared.Contracts;
using Boxty.SharedApp.DTOs.UserManagement;

namespace Boxty.ServerApp.Modules.UserManagement.Infrastructure
{
    public class UserManagementModule : IModule
    {
        public IServiceCollection RegisterModuleServices(IServiceCollection services, IConfiguration configuration)
        {
            var connectionString = configuration.GetConnectionString("DefaultConnection") ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");
            services.AddDbContext<IDbContext<UserManagementDbContext>, UserManagementDbContext>(options =>
                            options.UseNpgsql(configuration.GetConnectionString("DefaultConnection")));

            services.AddScoped<IGetTenantByIdQuery, GetTenantByIdQuery>();
            services.AddScoped<IGetSubjectByIdQuery, GetSubjectByIdQuery>();

            services.AddScoped<IAuthorizationHandler, UserManagementResourceAccessAuthorizationHandler>();

            return services;
        }
        public WebApplication ConfigureModuleServices(WebApplication app, bool isDevelopment)
        {
            // if (isDevelopment)
            // {
            using (var scope = app.Services.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<UserManagementDbContext>();
                dbContext.Database.Migrate();
            }
            // }
            return app;
        }
    }
}
