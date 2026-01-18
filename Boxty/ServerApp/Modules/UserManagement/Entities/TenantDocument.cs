using Boxty.ServerBase.Entities;
using Boxty.SharedApp.Enums;

namespace Boxty.ServerApp.Modules.UserManagement.Entities
{
    public class TenantDocument : BaseEntity<TenantDocument>, IEntity, IDocument, ISearchTags
    {
        public string BlobContainerName { get; set; } = string.Empty;
        public string BlobName { get; set; } = string.Empty;
        public required string Name { get; set; }
        public string? Description { get; set; }
        public string SearchTags { get; set; } = string.Empty;
        public TenantDocumentTypeEnum TenantDocumentType { get; set; } = TenantDocumentTypeEnum.Unknown;
    }
}
