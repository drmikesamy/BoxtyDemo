using Boxty.ServerBase.Database;
using Boxty.ServerBase.Entities;
using Microsoft.EntityFrameworkCore;
using Boxty.ServerApp.Modules.Auth.Entities;

namespace Boxty.ServerApp.Modules.Auth.Infrastructure.Database
{
    public sealed class AuthDbContext(DbContextOptions<AuthDbContext> options) : BaseDbContext<AuthDbContext>(options), IDbContext<AuthDbContext>
    {
        public DbSet<Role> Roles { get; set; }
        public DbSet<RolePermission> RolePermissions { get; set; }
        public DbSet<Permission> Permissions { get; set; }
        public DbSet<UserEncryptionKey> UserEncryptionKeys { get; set; }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasDefaultSchema(Schema.Auth);
            modelBuilder.ApplyConfigurationsFromAssembly(typeof(AuthDbContext).Assembly);

            modelBuilder.Entity<Permission>()
                .Property(p => p.Id)
                .HasDefaultValueSql("gen_random_uuid()");

            modelBuilder.Entity<Role>()
                .Property(p => p.Id)
                .HasDefaultValueSql("gen_random_uuid()");

            modelBuilder.Entity<UserEncryptionKey>()
                .Property(p => p.Id)
                .HasDefaultValueSql("gen_random_uuid()");

            // Configure UserEncryptionKey entity
            modelBuilder.Entity<UserEncryptionKey>()
                .HasIndex(u => u.UserId)
                .HasDatabaseName("IX_UserEncryptionKeys_UserId");

            modelBuilder.Entity<UserEncryptionKey>()
                .HasIndex(u => new { u.UserId, u.IsActive })
                .HasDatabaseName("IX_UserEncryptionKeys_UserId_IsActive");
        }
    }
}
