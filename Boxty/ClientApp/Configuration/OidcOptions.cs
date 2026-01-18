namespace Boxty.ClientApp.Configuration;

public class OidcOptions
{
    public const string SectionName = "Oidc";

    public string Authority { get; set; } = string.Empty;
    public string ClientId { get; set; } = string.Empty;
    public string ResponseType { get; set; } = "code";
    public string[] DefaultScopes { get; set; } = Array.Empty<string>();
    public string RoleClaim { get; set; } = "role";
}
