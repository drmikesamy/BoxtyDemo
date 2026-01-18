using Boxty.SharedBase.DTOs;
using Boxty.SharedBase.Interfaces;
using Boxty.SharedApp.DTOs;

namespace Boxty.SharedApp.DTOs.UserManagement
{
    public class SubjectNoteDto : BaseDto<SubjectNoteDto>, IDto, IAuditDto, IAutoCrud
    {
        public string Content { get; set; } = string.Empty;
        public string DisplayName => Content;
        public Guid SubjectId { get; set; }
        public Guid TenantId { get; set; }
    }
}
