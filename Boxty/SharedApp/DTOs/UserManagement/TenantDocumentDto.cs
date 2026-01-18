using Boxty.SharedBase.DTOs;
using Boxty.SharedBase.Interfaces;
using Boxty.SharedBase.Models;
using Boxty.SharedApp.Enums;

namespace Boxty.SharedApp.DTOs.UserManagement
{
    public class TenantDocumentDto : BaseDocumentDto, IDto
    {
        public TenantDocumentTypeEnum TenantDocumentType { get; set; }
    }
}
