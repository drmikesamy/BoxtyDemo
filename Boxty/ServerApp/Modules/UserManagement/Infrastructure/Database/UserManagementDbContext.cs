using Boxty.ServerBase.Database;
using Boxty.ServerBase.Entities;
using Microsoft.EntityFrameworkCore;
using Boxty.ServerApp.Modules.UserManagement.Entities;
using Boxty.SharedApp.Enums;

namespace Boxty.ServerApp.Modules.UserManagement.Infrastructure.Database
{
    public sealed class UserManagementDbContext(DbContextOptions<UserManagementDbContext> options) : BaseDbContext<UserManagementDbContext>(options), IDbContext<UserManagementDbContext>
    {
        public DbSet<Subject> Subjects { get; set; }
        public DbSet<Tenant> Tenants { get; set; }
        public DbSet<TenantDocument> TenantDocuments { get; set; }
        public DbSet<SubjectDocument> SubjectDocuments { get; set; }
        public DbSet<TenantNote> TenantNotes { get; set; }
        public DbSet<SubjectNote> SubjectNotes { get; set; }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasDefaultSchema(Schema.UserManagement);
            modelBuilder.ApplyConfigurationsFromAssembly(typeof(UserManagementDbContext).Assembly);

            modelBuilder.Entity<Subject>()
                .Property(p => p.Id)
                .HasDefaultValueSql("gen_random_uuid()");

            modelBuilder.Entity<Tenant>()
                .Property(p => p.Id)
                .HasDefaultValueSql("gen_random_uuid()");

            modelBuilder.Entity<TenantNote>()
                .Property(p => p.Id)
                .HasDefaultValueSql("gen_random_uuid()");

            modelBuilder.Entity<SubjectNote>()
                .Property(p => p.Id)
                .HasDefaultValueSql("gen_random_uuid()");

            modelBuilder.Entity<TenantDocument>()
                .Property(p => p.Id)
                .HasDefaultValueSql("gen_random_uuid()");

            modelBuilder.Entity<SubjectDocument>()
                .Property(p => p.Id)
                .HasDefaultValueSql("gen_random_uuid()");
        }
    }
}
