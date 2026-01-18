namespace Boxty.ClientApp.Configuration;

public class ApplicationSettingsOptions
{
    public const string SectionName = "ApplicationSettings";
    public Guid RootTenantId { get; set; } = Guid.Empty;
}