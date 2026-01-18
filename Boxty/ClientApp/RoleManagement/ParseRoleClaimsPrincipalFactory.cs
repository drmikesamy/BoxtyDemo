using System.Security.Claims;
using System.Text.Json;
using Microsoft.AspNetCore.Components.WebAssembly.Authentication;
using Microsoft.AspNetCore.Components.WebAssembly.Authentication.Internal;

namespace Boxty.ClientApp.RoleManagement;

public class ParseRoleClaimsPrincipalFactory : AccountClaimsPrincipalFactory<RemoteUserAccount>
{
    public ParseRoleClaimsPrincipalFactory(IAccessTokenProviderAccessor accessor) : base(accessor)
    {
    }
    public async override ValueTask<ClaimsPrincipal> CreateUserAsync(RemoteUserAccount account, RemoteAuthenticationUserOptions options)
    {
        var user = await base.CreateUserAsync(account, options);
        if (user.Identity is not ClaimsIdentity)
        {
            throw new InvalidOperationException("The user identity is not a ClaimsIdentity.");
        }
        var identity = (ClaimsIdentity)user.Identity;
        if (account is not null)
        {
            ParseArrayClaims(account, identity);
        }

        return user;
    }
    private static void ParseArrayClaims(RemoteUserAccount account, ClaimsIdentity identity)
    {
        foreach (var prop in account.AdditionalProperties)
        {
            var key = prop.Key;
            var value = prop.Value;

            if (value is not null && (value is JsonElement element && element.ValueKind == JsonValueKind.Array))
            {
                identity.RemoveClaim(identity.FindFirst(key));
                var claims = element.EnumerateArray()
                    .Select(x => new Claim(key, x.ToString()));
                identity.AddClaims(claims);
            }
        }
    }
}
