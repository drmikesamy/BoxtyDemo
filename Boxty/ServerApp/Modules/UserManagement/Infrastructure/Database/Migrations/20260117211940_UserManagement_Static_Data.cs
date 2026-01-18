using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Boxty.ServerApp.Modules.UserManagement.Infrastructure.Database.Migrations
{
    /// <inheritdoc />
    public partial class UserManagement_Static_Data : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                schema: "usermanagement",
                table: "Subjects",
                keyColumn: "Id",
                keyValue: new Guid("de8d2617-58f1-4965-a523-811e2f1a1eec"),
                columns: new[] { "CreatedDate", "ModifiedDate" },
                values: new object[] { new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) });

            migrationBuilder.UpdateData(
                schema: "usermanagement",
                table: "Tenants",
                keyColumn: "Id",
                keyValue: new Guid("c1e30e05-0655-42b6-9e4f-32310eb650c8"),
                columns: new[] { "CreatedDate", "ModifiedDate" },
                values: new object[] { new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                schema: "usermanagement",
                table: "Subjects",
                keyColumn: "Id",
                keyValue: new Guid("de8d2617-58f1-4965-a523-811e2f1a1eec"),
                columns: new[] { "CreatedDate", "ModifiedDate" },
                values: new object[] { new DateTime(2026, 1, 17, 21, 8, 13, 674, DateTimeKind.Utc).AddTicks(407), new DateTime(2026, 1, 17, 21, 8, 13, 674, DateTimeKind.Utc).AddTicks(518) });

            migrationBuilder.UpdateData(
                schema: "usermanagement",
                table: "Tenants",
                keyColumn: "Id",
                keyValue: new Guid("c1e30e05-0655-42b6-9e4f-32310eb650c8"),
                columns: new[] { "CreatedDate", "ModifiedDate" },
                values: new object[] { new DateTime(2026, 1, 17, 21, 8, 13, 675, DateTimeKind.Utc).AddTicks(1700), new DateTime(2026, 1, 17, 21, 8, 13, 675, DateTimeKind.Utc).AddTicks(1701) });
        }
    }
}
