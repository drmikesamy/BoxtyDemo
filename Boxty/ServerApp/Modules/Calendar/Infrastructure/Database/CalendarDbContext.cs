using Boxty.ServerBase.Database;
using Boxty.ServerBase.Entities;
using Microsoft.EntityFrameworkCore;
using Boxty.ServerApp.Modules.Calendar.Entities;
using Boxty.SharedApp.Enums;

namespace Boxty.ServerApp.Modules.Calendar.Infrastructure.Database
{
    public sealed class CalendarDbContext(DbContextOptions<CalendarDbContext> options) : BaseDbContext<CalendarDbContext>(options), IDbContext<CalendarDbContext>
    {
        // Add your DbSet properties here
        // Example: public DbSet<YourEntity> YourEntities { get; set; }

        public DbSet<Appointment> Appointments { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasDefaultSchema(Schema.Calendar);
            modelBuilder.ApplyConfigurationsFromAssembly(typeof(CalendarDbContext).Assembly);

            // Add your entity configurations here
            // Example:
            // modelBuilder.Entity<YourEntity>()
            //     .Property(p => p.Id)
            //     .HasDefaultValueSql("gen_random_uuid()");

            modelBuilder.Entity<Appointment>()
                .Property(p => p.Id)
                .HasDefaultValueSql("gen_random_uuid()");
        }
    }
}
