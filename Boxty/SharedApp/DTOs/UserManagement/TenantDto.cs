using Boxty.SharedBase.DTOs;
using Boxty.SharedBase.Interfaces;
using Boxty.SharedApp.DTOs;

namespace Boxty.SharedApp.DTOs.UserManagement
{
    public class TenantDto : BaseDto<TenantDto>, IDto, IAuditDto, IAutoCrud, ITenant
    {
        public string Name { get; set; } = string.Empty;
        public string Domain { get; set; } = string.Empty;
        public string Telephone { get; set; } = string.Empty;
        public string Address { get; set; } = string.Empty;
        public string Postcode { get; set; } = string.Empty;
        public string Website { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string Notes { get; set; } = string.Empty;
        public List<Guid> RelatedDocumentIds { get; set; } = new List<Guid>();
        public string DisplayName => $"{Name}";
    }
}
