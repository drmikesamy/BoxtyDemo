using Boxty.ServerBase.Interfaces;
using Boxty.ServerBase.Mappers;
using Microsoft.EntityFrameworkCore;
using Boxty.ServerApp.Modules.UserManagement.Entities;
using Boxty.ServerApp.Modules.UserManagement.Infrastructure.Database;
using Boxty.ServerApp.Modules.Shared.Contracts;
using Boxty.SharedApp.DTOs.UserManagement;

namespace Boxty.ServerApp.Modules.UserManagement.Infrastructure.Queries
{
    public class GetSubjectByIdQuery : IGetSubjectByIdQuery, IQuery
    {
        private readonly UserManagementDbContext _dbContext;
        private readonly IMapper<Subject, SubjectDto> _mapper;

        public GetSubjectByIdQuery(UserManagementDbContext dbContext, IMapper<Subject, SubjectDto> mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public async Task<SubjectDto?> Handle(Guid subjectId)
        {
            var subject = await _dbContext.Set<Subject>()
                .AsNoTracking()
                .FirstOrDefaultAsync(c => c.Id == subjectId);

            return subject != null ? _mapper.Map(subject) : null;
        }
    }
}
