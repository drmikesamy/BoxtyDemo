namespace Boxty.ClientApp.Configuration;

public class ApiOptions
{
    public const string SectionName = "Api";

    public string BaseUrl { get; set; } = string.Empty;
    public string[] AuthorizedUrls { get; set; } = Array.Empty<string>();
}
