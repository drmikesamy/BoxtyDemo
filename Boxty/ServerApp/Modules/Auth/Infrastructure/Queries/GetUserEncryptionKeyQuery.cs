using Boxty.ServerBase.Interfaces;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Boxty.ServerApp.Modules.Auth.Entities;
using Boxty.ServerApp.Modules.Auth.Infrastructure.Database;

namespace Boxty.ServerApp.Modules.Auth.Infrastructure.Queries
{
    public interface IGetUserEncryptionKeyQuery : IQuery
    {
        Task<UserEncryptionKey?> Handle(string userId);
    }

    public class GetUserEncryptionKeyQuery : IGetUserEncryptionKeyQuery
    {
        private readonly AuthDbContext _dbContext;
        private readonly ILogger<GetUserEncryptionKeyQuery> _logger;

        public GetUserEncryptionKeyQuery(
            AuthDbContext dbContext,
            ILogger<GetUserEncryptionKeyQuery> logger)
        {
            _dbContext = dbContext;
            _logger = logger;
        }

        public async Task<UserEncryptionKey?> Handle(string userId)
        {
            try
            {
                return await _dbContext.Set<UserEncryptionKey>()
                    .Where(k => k.UserId == userId && k.IsActive)
                    .OrderByDescending(k => k.KeyGeneratedDate)
                    .FirstOrDefaultAsync();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to get user encryption key entity for user: {UserId}", userId);
                return null;
            }
        }
    }
}
