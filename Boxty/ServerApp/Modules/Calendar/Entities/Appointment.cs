using Boxty.ServerBase.Entities;
using Boxty.SharedBase.Interfaces;
using Boxty.SharedBase.Enums;

namespace Boxty.ServerApp.Modules.Calendar.Entities
{
    public class Appointment : BaseEntity<Appointment>, IEntity
    {
        public DateTime? Start { get; set; }
        public DateTime? End { get; set; }
        public required string Title { get; set; }
        public required string Description { get; set; }
        public ScheduleTypeEnum ScheduleType { get; set; } = ScheduleTypeEnum.AdHocAppointment;
        public DateTime? RecurrenceEndDate { get; set; }
    }
}
