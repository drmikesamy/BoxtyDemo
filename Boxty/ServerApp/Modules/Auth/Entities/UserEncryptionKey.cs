using Boxty.ServerBase.Entities;

namespace Boxty.ServerApp.Modules.Auth.Entities
{
    /// <summary>
    /// Stores encrypted user-specific encryption keys for local backup encryption
    /// The actual encryption key is AES-encrypted using a master key from Azure Key Vault
    /// </summary>
    public class UserEncryptionKey : BaseEntity<UserEncryptionKey>, IEntity
    {
        /// <summary>
        /// The user's identifier (from claims)
        /// </summary>
        public required string UserId { get; set; }

        /// <summary>
        /// The user's encryption key, encrypted with the master key from Azure Key Vault
        /// </summary>
        public required byte[] EncryptedKey { get; set; }

        /// <summary>
        /// Initialization vector used for AES encryption of the key
        /// </summary>
        public required byte[] IV { get; set; }

        /// <summary>
        /// When this key was generated
        /// </summary>
        public DateTime KeyGeneratedDate { get; set; } = DateTime.UtcNow;

        /// <summary>
        /// When this key expires (for key rotation)
        /// </summary>
        public DateTime? KeyExpiryDate { get; set; }

        /// <summary>
        /// Version of the master key used to encrypt this user key (for key rotation)
        /// </summary>
        public string MasterKeyVersion { get; set; } = "1.0";

        /// <summary>
        /// Optional notes about this key
        /// </summary>
        public string? Notes { get; set; }
    }
}
