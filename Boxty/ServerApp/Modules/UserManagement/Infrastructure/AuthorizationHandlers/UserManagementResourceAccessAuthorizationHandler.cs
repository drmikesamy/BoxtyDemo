using Boxty.ServerBase.Auth.Requirements;
using Boxty.ServerBase.Entities;
using Boxty.ServerBase.Services;
using Microsoft.AspNetCore.Authorization;
using Boxty.ServerApp.Modules.UserManagement.Entities;
using Boxty.ServerApp.Modules.Shared.Contracts;
using Boxty.ServerApp.Modules.UserManagement.Infrastructure.Queries;

namespace Boxty.ServerApp.Modules.UserManagement.Infrastructure.AuthorizationHandlers
{
    public class UserManagementResourceAccessAuthorizationHandler :
        AuthorizationHandler<ResourceAccessRequirement, IEntity>
    {
        private readonly IUserContextService _userContextService;

        public UserManagementResourceAccessAuthorizationHandler(
            IUserContextService userContextService)
        {
            _userContextService = userContextService;
        }

        protected override Task HandleRequirementAsync(
            AuthorizationHandlerContext context,
            ResourceAccessRequirement requirement,
            IEntity resource)
        {

            if (resource is not Tenant and
                not Subject)
            {
                return Task.CompletedTask;
            }
            return Task.CompletedTask;
        }
    }
}
