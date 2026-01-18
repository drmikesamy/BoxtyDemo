using System.Security.Claims;
using Boxty.ServerBase.Auth.Constants;
using Boxty.ServerBase.Endpoints;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Routing;
using Microsoft.EntityFrameworkCore;
using Boxty.ServerApp.Modules.Auth.Entities;
using Boxty.ServerApp.Modules.Auth.Infrastructure.Commands;
using Boxty.ServerApp.Modules.Auth.Infrastructure.Queries;
using Boxty.ServerBase.Services;
using Boxty.SharedBase.DTOs.Auth;

namespace Boxty.ServerApp.Modules.Auth.Endpoints
{
    public class RoleEndpoints : IEndpoints
    {
        public virtual IEndpointRouteBuilder MapEndpoints(IEndpointRouteBuilder endpoints)
        {
            var group = endpoints.MapGroup($"/api/auth/roles");

            // View permission for GET operations
            var viewPermission = PermissionHelper.GeneratePermission<Role>(PermissionOperations.View);
            // Create permission for POST operations
            var createPermission = PermissionHelper.GeneratePermission<Role>(PermissionOperations.Create);
            // Update permission for PUT operations
            var updatePermission = PermissionHelper.GeneratePermission<Role>(PermissionOperations.Update);
            // Delete permission for DELETE operations
            var deletePermission = PermissionHelper.GeneratePermission<Role>(PermissionOperations.Delete);

            group.MapGet("/GetAll", async (
                [FromServices] IGetAllRolesQuery getAllRolesQuery,
                ClaimsPrincipal user
            ) =>
            {
                try
                {
                    var roles = await getAllRolesQuery.Handle(user);
                    return Results.Ok(roles);
                }
                catch (UnauthorizedAccessException)
                {
                    return Results.Forbid();
                }
                catch (Exception ex)
                {
                    Console.Error.WriteLine($"An error occurred: {ex.Message}");
                    return Results.Problem("An error occurred while retrieving Role entities.");
                }
            }).RequireAuthorization($"Permission:{viewPermission}");

            group.MapGet("/GetById/{id}", async (
                [FromServices] IGetRoleByIdQuery getRoleByIdQuery,
                Guid id
            ) =>
            {
                try
                {
                    var role = await getRoleByIdQuery.Handle(id);
                    if (role == null)
                        return Results.NotFound();
                    return Results.Ok(role);
                }
                catch (Exception ex)
                {
                    Console.Error.WriteLine($"An error occurred: {ex.Message}");
                    return Results.Problem("An error occurred while retrieving the Role details.");
                }
            }).RequireAuthorization($"Permission:{viewPermission}");

            group.MapPost("/Create", async (
                [FromServices] ICreateRoleCommand createRoleCommand,
                ClaimsPrincipal user,
                [FromBody] RoleDto role
            ) =>
            {
                try
                {
                    var dto = await createRoleCommand.Handle(role, user);
                    return Results.Ok(dto);
                }
                catch (Exception ex)
                {
                    Console.Error.WriteLine($"An error occurred: {ex.Message}");
                    return Results.Problem("An error occurred while creating the Role.");
                }
            }).RequireAuthorization($"Permission:{createPermission}");

            group.MapPut("/Update", async (
                [FromServices] IUpdateRoleCommand updateRoleCommand,
                ClaimsPrincipal user,
                [FromBody] RoleDto roleDto
            ) =>
            {
                try
                {
                    var updatedDto = await updateRoleCommand.Handle(roleDto, user);
                    return Results.Ok(updatedDto);
                }
                catch (KeyNotFoundException ex)
                {
                    Console.Error.WriteLine($"Role not found: {ex.Message}");
                    return Results.NotFound(ex.Message);
                }
                catch (InvalidOperationException ex)
                {
                    Console.Error.WriteLine($"Invalid operation: {ex.Message}");
                    return Results.Problem(ex.Message);
                }
                catch (DbUpdateException ex)
                {
                    Console.Error.WriteLine($"A database update error occurred: {ex.Message}");
                    if (ex.InnerException != null)
                    {
                        Console.Error.WriteLine($"Inner exception: {ex.InnerException.Message}");
                    }
                    return Results.Problem("An error occurred while updating the Role due to a database issue. Check server logs for details.");
                }
                catch (Exception ex)
                {
                    Console.Error.WriteLine($"An unexpected error occurred: {ex.Message}");
                    return Results.Problem("An unexpected error occurred while updating the Role.");
                }
            }).RequireAuthorization($"Permission:{updatePermission}");

            group.MapPost("/Delete/{id}", async (
                [FromServices] IDeleteRoleCommand deleteRoleCommand,
                ClaimsPrincipal user,
                Guid id
            ) =>
            {
                try
                {
                    await deleteRoleCommand.Handle(id, user);
                    return Results.Ok();
                }
                catch (KeyNotFoundException ex)
                {
                    Console.Error.WriteLine($"Role not found: {ex.Message}");
                    return Results.NotFound();
                }
                catch (Exception ex)
                {
                    Console.Error.WriteLine($"An error occurred: {ex.Message}");
                    return Results.Problem("An error occurred while deleting the Role.");
                }
            }).RequireAuthorization($"Permission:{deletePermission}");

            return endpoints;
        }
    }

    public class EncryptionEndpoints : IEndpoints
    {
        public virtual IEndpointRouteBuilder MapEndpoints(IEndpointRouteBuilder endpoints)
        {
            var group = endpoints.MapGroup($"/api/encryption");

            group.MapGet("/userkey", async (
                [FromServices] IGetOrCreateUserKeyCommand getOrCreateUserKeyCommand,
                ClaimsPrincipal user
            ) =>
            {
                try
                {
                    // Get the user's ID from claims
                    var userIdClaim = user.FindFirstValue("sub");
                    if (string.IsNullOrEmpty(userIdClaim))
                    {
                        return Results.Unauthorized();
                    }

                    // Get or create the user's encryption key using the sophisticated key management system
                    var userKeyBytes = await getOrCreateUserKeyCommand.Handle(userIdClaim, user);

                    return Results.Ok(userKeyBytes);
                }
                catch (Exception ex)
                {
                    return Results.Problem($"An error occurred while retrieving encryption key: {ex.Message}");
                }
            }).RequireAuthorization();

            group.MapPost("/userkey/rotate", async (
                [FromServices] IRotateUserKeyCommand rotateUserKeyCommand,
                ClaimsPrincipal user
            ) =>
            {
                try
                {
                    var userIdClaim = user.FindFirstValue("sub");
                    if (string.IsNullOrEmpty(userIdClaim))
                    {
                        return Results.Unauthorized();
                    }

                    var success = await rotateUserKeyCommand.Handle(userIdClaim, user);
                    if (success)
                    {
                        return Results.Ok(new { message = "User encryption key rotated successfully" });
                    }
                    else
                    {
                        return Results.Problem("Failed to rotate user encryption key");
                    }
                }
                catch (Exception ex)
                {
                    return Results.Problem($"An error occurred while rotating encryption key: {ex.Message}");
                }
            }).RequireAuthorization();

            group.MapPost("/userkey/revoke", async (
                [FromServices] IRevokeUserKeyCommand revokeUserKeyCommand,
                ClaimsPrincipal user
            ) =>
            {
                try
                {
                    var userIdClaim = user.FindFirstValue("sub");
                    if (string.IsNullOrEmpty(userIdClaim))
                    {
                        return Results.Unauthorized();
                    }

                    var success = await revokeUserKeyCommand.Handle(userIdClaim, user);
                    if (success)
                    {
                        return Results.Ok(new { message = "User encryption key revoked successfully" });
                    }
                    else
                    {
                        return Results.Problem("Failed to revoke user encryption key");
                    }
                }
                catch (Exception ex)
                {
                    return Results.Problem($"An error occurred while revoking encryption key: {ex.Message}");
                }
            }).RequireAuthorization();

            group.MapGet("/userkey/info", async (
                [FromServices] IGetUserEncryptionKeyQuery getUserEncryptionKeyQuery,
                ClaimsPrincipal user
            ) =>
            {
                try
                {
                    var userIdClaim = user.FindFirstValue("sub");
                    if (string.IsNullOrEmpty(userIdClaim))
                    {
                        return Results.Unauthorized();
                    }

                    var keyInfo = await getUserEncryptionKeyQuery.Handle(userIdClaim);
                    if (keyInfo == null)
                    {
                        return Results.NotFound("No encryption key found for user");
                    }

                    return Results.Ok(new
                    {
                        keyId = keyInfo.Id,
                        keyGeneratedDate = keyInfo.KeyGeneratedDate,
                        keyExpiryDate = keyInfo.KeyExpiryDate,
                        masterKeyVersion = keyInfo.MasterKeyVersion,
                        isActive = keyInfo.IsActive
                    });
                }
                catch (Exception ex)
                {
                    return Results.Problem($"An error occurred while retrieving key information: {ex.Message}");
                }
            }).RequireAuthorization();

            // Admin endpoint for cleanup (requires special permission)
            group.MapPost("/admin/cleanup-expired", async (
                [FromServices] ICleanupExpiredKeysCommand cleanupExpiredKeysCommand,
                ClaimsPrincipal user
            ) =>
            {
                try
                {
                    // Check if user has admin permissions (you can customize this check)
                    if (!user.IsInRole("Administrator"))
                    {
                        return Results.Forbid();
                    }

                    var cleanedCount = await cleanupExpiredKeysCommand.Handle(user);
                    return Results.Ok(new { message = $"Cleaned up {cleanedCount} expired keys" });
                }
                catch (Exception ex)
                {
                    return Results.Problem($"An error occurred during cleanup: {ex.Message}");
                }
            }).RequireAuthorization();

            return endpoints;
        }
    }

    public class PermissionEndpoints : IEndpoints
    {
        public virtual IEndpointRouteBuilder MapEndpoints(IEndpointRouteBuilder endpoints)
        {
            var group = endpoints.MapGroup($"/api/auth/permissions");

            // View permission for GET operations
            var viewPermission = PermissionHelper.GeneratePermission<Permission>(PermissionOperations.View);

            group.MapGet("/GetAll", async (
                [FromServices] IGetAllPermissionsQuery getAllPermissionsQuery
            ) =>
            {
                try
                {
                    var permissions = await getAllPermissionsQuery.Handle();
                    return Results.Ok(permissions);
                }
                catch (Exception ex)
                {
                    Console.Error.WriteLine($"An error occurred: {ex.Message}");
                    return Results.Problem("An error occurred while retrieving Permission entities.");
                }
            }).RequireAuthorization($"Permission:{viewPermission}");

            return endpoints;
        }
    }
}
