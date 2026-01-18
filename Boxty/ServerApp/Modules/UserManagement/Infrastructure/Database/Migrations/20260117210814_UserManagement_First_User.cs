using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Boxty.ServerApp.Modules.UserManagement.Infrastructure.Database.Migrations
{
    /// <inheritdoc />
    public partial class UserManagement_First_User : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                schema: "usermanagement",
                table: "Tenants",
                columns: new[] { "Id", "Address", "CreatedBy", "CreatedById", "CreatedDate", "Domain", "Email", "IsActive", "LastModifiedBy", "ModifiedById", "ModifiedDate", "Name", "Notes", "Postcode", "RelatedDocumentIds", "SearchTags", "SubjectId", "Telephone", "TenantId", "Website" },
                values: new object[] { new Guid("c1e30e05-0655-42b6-9e4f-32310eb650c8"), "", "System", new Guid("de8d2617-58f1-4965-a523-811e2f1a1eec"), new DateTime(2026, 1, 17, 21, 8, 13, 675, DateTimeKind.Utc).AddTicks(1700), "boxty.org", "admin@boxty.org", true, "System", new Guid("de8d2617-58f1-4965-a523-811e2f1a1eec"), new DateTime(2026, 1, 17, 21, 8, 13, 675, DateTimeKind.Utc).AddTicks(1701), "Boxty", "Root tenant organization", "", new Guid[0], "", new Guid("de8d2617-58f1-4965-a523-811e2f1a1eec"), "", new Guid("c1e30e05-0655-42b6-9e4f-32310eb650c8"), "https://boxty.org" });

            migrationBuilder.InsertData(
                schema: "usermanagement",
                table: "Subjects",
                columns: new[] { "Id", "Address1", "Address2", "Address3", "AvatarDescription", "AvatarImage", "AvatarImageGuid", "AvatarTitle", "CreatedBy", "CreatedById", "CreatedDate", "DOB", "Email", "FirstName", "IsActive", "LastModifiedBy", "LastName", "ModifiedById", "ModifiedDate", "Notes", "Postcode", "RelatedDocumentIds", "RoleName", "SearchTags", "SubjectId", "Telephone", "TenantId", "Username" },
                values: new object[] { new Guid("de8d2617-58f1-4965-a523-811e2f1a1eec"), "", null, null, null, null, new Guid("00000000-0000-0000-0000-000000000000"), null, "System", new Guid("de8d2617-58f1-4965-a523-811e2f1a1eec"), new DateTime(2026, 1, 17, 21, 8, 13, 674, DateTimeKind.Utc).AddTicks(407), null, "admin@boxty.org", "Admin", true, "System", "User", new Guid("de8d2617-58f1-4965-a523-811e2f1a1eec"), new DateTime(2026, 1, 17, 21, 8, 13, 674, DateTimeKind.Utc).AddTicks(518), "Root administrator", "", new Guid[0], "Administrator", "", new Guid("de8d2617-58f1-4965-a523-811e2f1a1eec"), "", new Guid("c1e30e05-0655-42b6-9e4f-32310eb650c8"), "admin" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                schema: "usermanagement",
                table: "Subjects",
                keyColumn: "Id",
                keyValue: new Guid("de8d2617-58f1-4965-a523-811e2f1a1eec"));

            migrationBuilder.DeleteData(
                schema: "usermanagement",
                table: "Tenants",
                keyColumn: "Id",
                keyValue: new Guid("c1e30e05-0655-42b6-9e4f-32310eb650c8"));
        }
    }
}
