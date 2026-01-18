using System.Security.Claims;
using Boxty.SharedBase.DTOs;
using Boxty.ServerBase.Endpoints;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Routing;
using Boxty.ServerApp.Modules.UserManagement.Entities;
using Boxty.ServerApp.Modules.UserManagement.Infrastructure.Database;
using Boxty.SharedApp.DTOs.UserManagement;

namespace Boxty.ServerApp.Modules.UserManagement.Endpoints
{
    public class SubjectSecurityEndpoints : KeycloakSubjectEndpoints<Subject, SubjectDto, UserManagementDbContext>, IEndpoints { }
    public class TenantSecurityEndpoints : KeycloakTenantEndpoints<Tenant, TenantDto, UserManagementDbContext>, IEndpoints { }
    public class TenantDocumentEndpoints : DocumentEndpoints<TenantDocument, TenantDocumentDto, UserManagementDbContext>, IEndpoints { }
    public class SubjectDocumentEndpoints : DocumentEndpoints<SubjectDocument, SubjectDocumentDto, UserManagementDbContext>, IEndpoints { }
    public class TenantNoteEndpoints : BaseEndpoints<TenantNote, TenantNoteDto, UserManagementDbContext>, IEndpoints { }
    public class SubjectNoteEndpoints : BaseEndpoints<SubjectNote, SubjectNoteDto, UserManagementDbContext>, IEndpoints { }
}
