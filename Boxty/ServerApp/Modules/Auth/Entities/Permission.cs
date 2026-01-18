using Boxty.ServerBase.Entities;

namespace Boxty.ServerApp.Modules.Auth.Entities
{
    public class Permission : ISimpleEntity
    {
        public Guid Id { get; set; }
        public string Name { get; set; } = string.Empty;
    }
}
