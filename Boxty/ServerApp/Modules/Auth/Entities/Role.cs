using Boxty.ServerBase.Entities;

namespace Boxty.ServerApp.Modules.Auth.Entities
{
    public class Role : ISimpleEntity
    {
        public Guid Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public ICollection<Permission> Permissions { get; set; } = new List<Permission>();
    }
}
