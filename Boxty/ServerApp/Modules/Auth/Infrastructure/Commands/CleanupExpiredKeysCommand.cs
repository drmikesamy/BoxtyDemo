using System.Security.Claims;
using Boxty.ServerBase.Interfaces;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Boxty.ServerApp.Modules.Auth.Entities;
using Boxty.ServerApp.Modules.Auth.Infrastructure.Database;

namespace Boxty.ServerApp.Modules.Auth.Infrastructure.Commands
{
    public interface ICleanupExpiredKeysCommand : ICommand
    {
        Task<int> Handle(ClaimsPrincipal user);
    }

    public class CleanupExpiredKeysCommand : ICleanupExpiredKeysCommand
    {
        private readonly AuthDbContext _dbContext;
        private readonly ILogger<CleanupExpiredKeysCommand> _logger;

        public CleanupExpiredKeysCommand(
            AuthDbContext dbContext,
            ILogger<CleanupExpiredKeysCommand> logger)
        {
            _dbContext = dbContext;
            _logger = logger;
        }

        public async Task<int> Handle(ClaimsPrincipal user)
        {
            try
            {
                var cutoffDate = DateTime.UtcNow.AddDays(-30);

                var expiredKeys = await _dbContext.Set<UserEncryptionKey>()
                    .Where(k => !k.IsActive && k.ModifiedDate < cutoffDate)
                    .ToListAsync();

                if (expiredKeys.Any())
                {
                    _dbContext.Set<UserEncryptionKey>().RemoveRange(expiredKeys);
                    await _dbContext.SaveChangesAsync();

                    _logger.LogInformation("Cleaned up {KeyCount} expired encryption keys", expiredKeys.Count);
                }

                return expiredKeys.Count;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to cleanup expired encryption keys");
                return 0;
            }
        }
    }
}
