using System.Security.Claims;
using Boxty.ServerBase.Interfaces;
using Boxty.ServerBase.Services;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Boxty.ServerApp.Modules.Auth.Entities;
using Boxty.ServerApp.Modules.Auth.Infrastructure.Database;
using System.Security.Cryptography;

namespace Boxty.ServerApp.Modules.Auth.Infrastructure.Commands
{
    public interface IRotateUserKeyCommand : ICommand
    {
        Task<bool> Handle(string userId, ClaimsPrincipal user);
    }

    public class RotateUserKeyCommand : IRotateUserKeyCommand
    {
        private readonly AuthDbContext _dbContext;
        private readonly IAzureKeyVaultService _keyVaultService;
        private readonly ILogger<RotateUserKeyCommand> _logger;

        public RotateUserKeyCommand(
            AuthDbContext dbContext,
            IAzureKeyVaultService keyVaultService,
            ILogger<RotateUserKeyCommand> logger)
        {
            _dbContext = dbContext;
            _keyVaultService = keyVaultService;
            _logger = logger;
        }

        public async Task<bool> Handle(string userId, ClaimsPrincipal user)
        {
            try
            {
                _logger.LogInformation("Rotating encryption key for user: {UserId}", userId);

                using var transaction = await _dbContext.Database.BeginTransactionAsync();

                // Mark existing keys as inactive
                var existingKeys = await _dbContext.Set<UserEncryptionKey>()
                    .Where(k => k.UserId == userId && k.IsActive)
                    .ToListAsync();

                foreach (var key in existingKeys)
                {
                    key.IsActive = false;
                    key.Notes = $"Rotated on {DateTime.UtcNow:yyyy-MM-dd HH:mm:ss} UTC";
                }

                // Create new key directly (to avoid circular dependency)
                await CreateNewUserKeyAsync(userId);

                await _dbContext.SaveChangesAsync();
                await transaction.CommitAsync();

                _logger.LogInformation("Successfully rotated encryption key for user: {UserId}", userId);
                return true;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to rotate encryption key for user: {UserId}", userId);
                return false;
            }
        }

        private async Task<byte[]> CreateNewUserKeyAsync(string userId)
        {
            // Generate a new 256-bit encryption key for the user
            using var rng = RandomNumberGenerator.Create();
            var userKeyBytes = new byte[32]; // 256 bits
            rng.GetBytes(userKeyBytes);

            // Encrypt the user key with the master key
            var encryptedData = await _keyVaultService.EncryptUserKeyAsync(userKeyBytes);

            // Extract IV (first 16 bytes) and encrypted key (remaining bytes)
            var iv = new byte[16];
            var encryptedKey = new byte[encryptedData.Length - 16];
            Array.Copy(encryptedData, 0, iv, 0, 16);
            Array.Copy(encryptedData, 16, encryptedKey, 0, encryptedKey.Length);

            // Get master key version
            var masterKeyVersion = await _keyVaultService.GetMasterKeyVersionAsync();

            // Create the entity
            var userEncryptionKey = new UserEncryptionKey
            {
                UserId = userId,
                EncryptedKey = encryptedKey,
                IV = iv,
                KeyGeneratedDate = DateTime.UtcNow,
                KeyExpiryDate = DateTime.UtcNow.AddYears(1), // Keys expire after 1 year
                MasterKeyVersion = masterKeyVersion,
                IsActive = true,
                Notes = "Auto-generated user encryption key"
            };

            _dbContext.Set<UserEncryptionKey>().Add(userEncryptionKey);

            _logger.LogInformation("Created new encryption key for user: {UserId}, expires: {ExpiryDate}",
                userId, userEncryptionKey.KeyExpiryDate);

            return userKeyBytes;
        }
    }
}
