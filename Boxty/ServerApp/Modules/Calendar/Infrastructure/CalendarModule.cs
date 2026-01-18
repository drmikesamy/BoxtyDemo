using Boxty.ServerBase.Auth.Providers;
using Boxty.ServerBase.Database;
using Boxty.ServerBase.Modules;
using Boxty.ServerBase.Queries;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Builder;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Boxty.ServerApp.Modules.Calendar.Entities;
using Boxty.ServerApp.Modules.Calendar.Infrastructure.Database;
using Boxty.ServerApp.Modules.Shared.Contracts;

namespace Boxty.ServerApp.Modules.Calendar.Infrastructure
{
    public class CalendarModule : IModule
    {
        public IServiceCollection RegisterModuleServices(IServiceCollection services, IConfiguration configuration)
        {
            var connectionString = configuration.GetConnectionString("DefaultConnection") ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");
            services.AddDbContext<IDbContext<CalendarDbContext>, CalendarDbContext>(options =>
                            options.UseNpgsql(configuration.GetConnectionString("DefaultConnection")));

            // Add your service registrations here
            // Example: services.AddScoped<IYourQuery, YourQuery>();
            // Example: services.AddScoped<IAuthorizationHandler, YourAuthorizationHandler>();

            return services;
        }
        
        public WebApplication ConfigureModuleServices(WebApplication app, bool isDevelopment)
        {
            using (var scope = app.Services.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<CalendarDbContext>();
                dbContext.Database.Migrate();
            }
            return app;
        }
    }
}
