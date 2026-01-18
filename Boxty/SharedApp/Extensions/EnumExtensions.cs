using System.ComponentModel.DataAnnotations;
using System.Reflection;
using Boxty.SharedBase.Attributes;

namespace Boxty.SharedApp.Extensions;

public static class EnumExtensions
{
    public static string GetDisplayName(this Enum enumValue)
    {
        var field = enumValue.GetType().GetField(enumValue.ToString());
        var displayAttribute = field?.GetCustomAttribute<DisplayAttribute>();
        return displayAttribute?.Name ?? enumValue.ToString();
    }
    public static string GetDisplayClass(this Enum enumValue)
    {
        var field = enumValue.GetType().GetField(enumValue.ToString());
        var displayPropertiesAttribute = field?.GetCustomAttribute<DisplayPropertiesAttribute>();
        return displayPropertiesAttribute?.Class ?? string.Empty;
    }
}