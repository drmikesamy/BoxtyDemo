using System.Security.Claims;
using Boxty.ServerBase.Interfaces;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Boxty.ServerApp.Modules.Auth.Entities;
using Boxty.ServerApp.Modules.Auth.Infrastructure.Database;

namespace Boxty.ServerApp.Modules.Auth.Infrastructure.Commands
{
    public interface IRevokeUserKeyCommand : ICommand
    {
        Task<bool> Handle(string userId, ClaimsPrincipal user);
    }

    public class RevokeUserKeyCommand : IRevokeUserKeyCommand
    {
        private readonly AuthDbContext _dbContext;
        private readonly ILogger<RevokeUserKeyCommand> _logger;

        public RevokeUserKeyCommand(
            AuthDbContext dbContext,
            ILogger<RevokeUserKeyCommand> logger)
        {
            _dbContext = dbContext;
            _logger = logger;
        }

        public async Task<bool> Handle(string userId, ClaimsPrincipal user)
        {
            try
            {
                _logger.LogInformation("Revoking all encryption keys for user: {UserId}", userId);

                var existingKeys = await _dbContext.Set<UserEncryptionKey>()
                    .Where(k => k.UserId == userId && k.IsActive)
                    .ToListAsync();

                foreach (var key in existingKeys)
                {
                    key.IsActive = false;
                    key.Notes = $"Revoked on {DateTime.UtcNow:yyyy-MM-dd HH:mm:ss} UTC";
                }

                await _dbContext.SaveChangesAsync();

                _logger.LogInformation("Successfully revoked {KeyCount} encryption keys for user: {UserId}",
                    existingKeys.Count, userId);
                return true;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to revoke encryption keys for user: {UserId}", userId);
                return false;
            }
        }
    }
}
