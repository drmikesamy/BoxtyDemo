using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Boxty.ServerApp.Modules.UserManagement.Entities;

namespace Boxty.ServerApp.Modules.UserManagement.Infrastructure.Database.Configurations
{
    public class TenantConfiguration : IEntityTypeConfiguration<Tenant>
    {
        public void Configure(EntityTypeBuilder<Tenant> builder)
        {
            builder.ToTable(nameof(Tenant) + "s", Schema.UserManagement);

            // Seed root tenant (Boxty organization from Keycloak)
            builder.HasData(
                new Tenant
                {
                    Id = new Guid("c1e30e05-0655-42b6-9e4f-32310eb650c8"),
                    Name = "Boxty",
                    Domain = "boxty.org",
                    Telephone = "",
                    Address = "",
                    Postcode = "",
                    Website = "https://boxty.org",
                    Email = "admin@boxty.org",
                    Notes = "Root tenant organization",
                    RelatedDocumentIds = Array.Empty<Guid>(),
                    TenantId = new Guid("c1e30e05-0655-42b6-9e4f-32310eb650c8"),
                    SearchTags = "",
                    IsActive = true,
                    CreatedBy = "System",
                    LastModifiedBy = "System",
                    CreatedDate = new DateTime(2025, 1, 1, 0, 0, 0, DateTimeKind.Utc),
                    ModifiedDate = new DateTime(2025, 1, 1, 0, 0, 0, DateTimeKind.Utc),
                    SubjectId = new Guid("de8d2617-58f1-4965-a523-811e2f1a1eec"),
                    CreatedById = new Guid("de8d2617-58f1-4965-a523-811e2f1a1eec"),
                    ModifiedById = new Guid("de8d2617-58f1-4965-a523-811e2f1a1eec")
                }
            );
        }
    }
}
