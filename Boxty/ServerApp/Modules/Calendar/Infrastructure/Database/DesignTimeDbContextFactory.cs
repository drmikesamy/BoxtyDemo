using Boxty.ServerBase.Database;
using Microsoft.EntityFrameworkCore;

namespace Boxty.ServerApp.Modules.Calendar.Infrastructure.Database
{
    public class DesignTimeCalendarDbContextFactory : DesignTimeDbContextFactory<CalendarDbContext>
    {
    }
}
