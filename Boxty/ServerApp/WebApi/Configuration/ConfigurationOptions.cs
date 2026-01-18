using System.ComponentModel.DataAnnotations;

namespace WebApi.Configuration;

/// <summary>
/// Configuration options for JWT authentication
/// </summary>
public class JwtOptions
{
    public const string SectionName = "Jwt";

    [Required]
    [Url]
    public string MetadataAddress { get; set; } = string.Empty;

    [Required]
    public string Issuer { get; set; } = string.Empty;

    [Required]
    public string Audience { get; set; } = string.Empty;

    public bool RequireHttpsMetadata { get; set; } = true;

    public TimeSpan ClockSkew { get; set; } = TimeSpan.FromMinutes(5);
}

/// <summary>
/// Configuration options for Keycloak admin client
/// </summary>
public class KeycloakAdminClientOptions
{
    public const string SectionName = "KeycloakAdminClient";

    [Required]
    [Url]
    public string KeycloakUrl { get; set; } = string.Empty;

    [Required]
    public string Realm { get; set; } = string.Empty;

    [Required]
    public string ClientId { get; set; } = string.Empty;

    [Required]
    public string ClientSecret { get; set; } = string.Empty;

    public TimeSpan Timeout { get; set; } = TimeSpan.FromSeconds(30);

    [Range(1, 10)]
    public int RetryCount { get; set; } = 3;
}

/// <summary>
/// Configuration options for CORS settings
/// </summary>
public class CorsOptions
{
    public const string SectionName = "Cors";

    [Required]
    [Url]
    public string AllowedClientOrigin { get; set; } = string.Empty;

    [Required]
    [Url]
    public string AllowedServerOrigin { get; set; } = string.Empty;

    public string AllowedMethods { get; set; } = "GET, PUT, POST, DELETE, OPTIONS";

    public string AllowedHeaders { get; set; } = "*";

    public string ExposedHeaders { get; set; } = "*";

    [Range(0, 86400)]
    public int MaxAge { get; set; } = 3600;

    public bool AllowCredentials { get; set; } = true;
}

/// <summary>
/// Configuration options for Azure Key Vault
/// </summary>
public class KeyVaultOptions
{
    public const string SectionName = "KeyVault";

    [Url]
    public string VaultUri { get; set; } = string.Empty;

    public string ClientId { get; set; } = string.Empty;

    public string ClientSecret { get; set; } = string.Empty;

    public string TenantId { get; set; } = string.Empty;
}
