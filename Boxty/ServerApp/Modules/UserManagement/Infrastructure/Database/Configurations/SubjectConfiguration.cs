using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Boxty.ServerApp.Modules.UserManagement.Entities;

namespace Boxty.ServerApp.Modules.UserManagement.Infrastructure.Database.Configurations
{
    public class SubjectConfiguration : IEntityTypeConfiguration<Subject>
    {
        public void Configure(EntityTypeBuilder<Subject> builder)
        {
            builder.ToTable(nameof(Subject) + "s", Schema.UserManagement);

            // Seed root subject (admin user from Keycloak)
            builder.HasData(
                new Subject
                {
                    Id = new Guid("de8d2617-58f1-4965-a523-811e2f1a1eec"),
                    FirstName = "Admin",
                    LastName = "User",
                    Username = "admin",
                    Telephone = "",
                    Email = "admin@boxty.org",
                    AvatarImageGuid = Guid.Empty,
                    AvatarImage = null,
                    AvatarTitle = null,
                    AvatarDescription = null,
                    DOB = null,
                    Address1 = "",
                    Address2 = null,
                    Address3 = null,
                    Postcode = "",
                    Notes = "Root administrator",
                    RelatedDocumentIds = Array.Empty<Guid>(),
                    SubjectId = new Guid("de8d2617-58f1-4965-a523-811e2f1a1eec"),
                    TenantId = new Guid("c1e30e05-0655-42b6-9e4f-32310eb650c8"),
                    SearchTags = "",
                    RoleName = "Administrator",
                    IsActive = true,
                    CreatedBy = "System",
                    LastModifiedBy = "System",
                    CreatedDate = new DateTime(2025, 1, 1, 0, 0, 0, DateTimeKind.Utc),
                    ModifiedDate = new DateTime(2025, 1, 1, 0, 0, 0, DateTimeKind.Utc),
                    CreatedById = new Guid("de8d2617-58f1-4965-a523-811e2f1a1eec"),
                    ModifiedById = new Guid("de8d2617-58f1-4965-a523-811e2f1a1eec")
                }
            );
        }
    }
}
