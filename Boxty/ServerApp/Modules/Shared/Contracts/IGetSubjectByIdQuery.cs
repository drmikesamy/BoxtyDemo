using Boxty.SharedApp.DTOs.UserManagement;

namespace Boxty.ServerApp.Modules.Shared.Contracts
{
    public interface IGetSubjectByIdQuery
    {
        Task<SubjectDto?> Handle(Guid subjectId);
    }
}