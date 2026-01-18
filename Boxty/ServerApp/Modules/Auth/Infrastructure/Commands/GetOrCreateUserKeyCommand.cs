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
    public interface IGetOrCreateUserKeyCommand : ICommand
    {
        Task<byte[]> Handle(string userId, ClaimsPrincipal user);
    }

    public class GetOrCreateUserKeyCommand : IGetOrCreateUserKeyCommand
    {
        private readonly AuthDbContext _dbContext;
        private readonly IAzureKeyVaultService _keyVaultService;
        private readonly ILogger<GetOrCreateUserKeyCommand> _logger;

        public GetOrCreateUserKeyCommand(
            AuthDbContext dbContext,
            IAzureKeyVaultService keyVaultService,
            ILogger<GetOrCreateUserKeyCommand> logger)
        {
            _dbContext = dbContext;
            _keyVaultService = keyVaultService;
            _logger = logger;
        }

        public async Task<byte[]> Handle(string userId, ClaimsPrincipal user)
        {
            try
            {
                _logger.LogDebug("Getting or creating encryption key for user: {UserId}", userId);

                // Try to get existing active key
                var existingKey = await _dbContext.Set<UserEncryptionKey>()
                    .Where(k => k.UserId == userId && k.IsActive)
                    .OrderByDescending(k => k.KeyGeneratedDate)
                    .FirstOrDefaultAsync();

                if (existingKey != null)
                {
                    // Check if key is expired
                    if (existingKey.KeyExpiryDate.HasValue && existingKey.KeyExpiryDate < DateTime.UtcNow)
                    {
                        _logger.LogInformation("User key expired, creating new key for user: {UserId}", userId);
                        return await CreateNewUserKeyAsync(userId);
                    }

                    // Decrypt and return existing key
                    var decryptedKey = await _keyVaultService.DecryptUserKeyAsync(existingKey.EncryptedKey, existingKey.IV);
                    _logger.LogDebug("Retrieved existing encryption key for user: {UserId}", userId);
                    return decryptedKey;
                }

                // No existing key, create new one
                _logger.LogInformation("No existing key found, creating new encryption key for user: {UserId}", userId);
                return await CreateNewUserKeyAsync(userId);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to get or create user encryption key for user: {UserId}", userId);
                throw new InvalidOperationException($"Failed to get encryption key for user {userId}", ex);
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
            await _dbContext.SaveChangesAsync();

            _logger.LogInformation("Created new encryption key for user: {UserId}, expires: {ExpiryDate}",
                userId, userEncryptionKey.KeyExpiryDate);

            return userKeyBytes;
        }
    }
}
