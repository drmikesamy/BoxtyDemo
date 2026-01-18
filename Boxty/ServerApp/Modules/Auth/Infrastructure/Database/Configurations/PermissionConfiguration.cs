using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Boxty.ServerApp.Modules.Auth.Entities;

namespace Boxty.ServerApp.Modules.Auth.Infrastructure.Database.Configurations
{
    public class PermissionConfiguration : IEntityTypeConfiguration<Permission>
    {
        public void Configure(EntityTypeBuilder<Permission> builder)
        {
            builder.ToTable(nameof(Permission), Schema.Auth);
        }
    }
}
