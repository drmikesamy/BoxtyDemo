using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Boxty.ServerApp.Modules.Auth.Entities;

namespace Boxty.ServerApp.Modules.Auth.Infrastructure.Database.Configurations
{
    public class RolePermissionConfiguration : IEntityTypeConfiguration<RolePermission>
    {
        public void Configure(EntityTypeBuilder<RolePermission> builder)
        {
            builder.ToTable(nameof(RolePermission), Schema.Auth);

            builder.HasKey(rp => new { rp.RoleId, rp.PermissionId });
        }
    }
}
