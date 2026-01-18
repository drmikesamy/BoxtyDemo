using Boxty.SharedBase.DTOs;
using Boxty.SharedBase.Enums;
using Boxty.SharedBase.Models;

namespace Boxty.SharedApp.DTOs.Calendar
{
    public class AppointmentDto : BaseCalendarItem
    {
        public DateTime? Start { get; set; }
        public DateTime? End { get; set; }
        public required string Title { get; set; }
        public required string Description { get; set; }
        public ScheduleTypeEnum ScheduleType { get; set; } = ScheduleTypeEnum.AdHocAppointment;
        public DateTime? RecurrenceEndDate { get; set; }
    }
}