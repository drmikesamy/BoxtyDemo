using Boxty.SharedApp.DTOs.UserManagement;

namespace Boxty.ServerApp.Modules.Shared.Contracts
{
    public interface IGetTenantByIdQuery
    {
        Task<TenantDto?> Handle(Guid tenantId);
    }
}
