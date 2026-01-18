using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Boxty.ServerApp.Modules.Auth.Entities;

namespace Boxty.ServerApp.Modules.Auth.Infrastructure.Database.Configurations
{
    public class RoleConfiguration : IEntityTypeConfiguration<Role>
    {
        public void Configure(EntityTypeBuilder<Role> builder)
        {
            builder.ToTable(nameof(Role), Schema.Auth);

            builder.HasMany(r => r.Permissions)
                .WithMany()
                .UsingEntity<RolePermission>();

            builder.HasData(
                new Role { Id = new Guid("11111111-1111-1111-1111-111111111111"), Name = "Administrator" },
                new Role { Id = new Guid("22222222-2222-2222-2222-222222222222"), Name = "TenantAdministrator" },
                new Role { Id = new Guid("33333333-3333-3333-3333-333333333333"), Name = "TenantLimitedAdministrator" },
                new Role { Id = new Guid("44444444-4444-4444-4444-444444444444"), Name = "Subject" }
            );
        }
    }
}
