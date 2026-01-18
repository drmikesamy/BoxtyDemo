using Boxty.SharedBase.DTOs;
using Boxty.SharedBase.Interfaces;
using Boxty.SharedApp.DTOs;

namespace Boxty.SharedApp.DTOs.UserManagement
{
    public class TenantNoteDto : BaseDto<TenantNoteDto>, IDto, IAuditDto, IAutoCrud
    {
        public string Content { get; set; } = string.Empty;
        public string DisplayName => Content;
        public Guid TenantId
        {
            get
            {
                return TenantId;
            }
            set
            {
                TenantId = value;
            }
        }
    }
}
