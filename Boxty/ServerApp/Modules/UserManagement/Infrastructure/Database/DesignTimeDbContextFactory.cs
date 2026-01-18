using Boxty.ServerBase.Database;
using Microsoft.EntityFrameworkCore;

namespace Boxty.ServerApp.Modules.UserManagement.Infrastructure.Database
{
    public class DesignTimeUserManagementDbContextFactory : DesignTimeDbContextFactory<UserManagementDbContext>
    {
    }
}
