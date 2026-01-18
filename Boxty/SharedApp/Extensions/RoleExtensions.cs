using Boxty.SharedBase.DTOs.Auth;

namespace Boxty.SharedApp.Extensions;

public static class RoleExtensions
{
    //retrieve role Display Name from roleDto
    public static string GetAuthDisplayName(this RoleDto role)
    {
        return GetAuthDisplayName(role?.Name);
    }

    //retrieve role Display Name from string 
    public static string GetAuthDisplayName(this string roleName)
    {
        return roleName?.ToLower() switch
        {
            "administrator" => "Administrator",
            "tenantadministrator" => "Tenant Super User",
            "tenantlimitedadministrator" => "Tenant Manager",
            "subject" => "Subject",
            _ => roleName ?? ""
        };
    }
}