using Boxty.ServerBase.Mappers;
using Boxty.ServerApp.Modules.Calendar.Entities;
using Boxty.SharedApp.DTOs.Calendar;
using System.Security.Claims;

namespace Boxty.ServerApp.Modules.Calendar.Infrastructure.Mappers
{
    public class AppointmentMapper : IMapper<Appointment, AppointmentDto>
    {
        public AppointmentDto Map(Appointment entity, ClaimsPrincipal? user = null)
        {
            return new AppointmentDto
            {
                Id = entity.Id,
                Start = entity.Start,
                End = entity.End,
                Title = entity.Title,
                Description = entity.Description,
                ScheduleType = entity.ScheduleType,
                RecurrenceEndDate = entity.RecurrenceEndDate,
                CreatedDate = entity.CreatedDate,
                CreatedBy = entity.CreatedBy,
                ModifiedDate = entity.ModifiedDate,
                LastModifiedBy = entity.LastModifiedBy
            };
        }

        public Appointment Map(AppointmentDto dto, ClaimsPrincipal? user = null)
        {
            return new Appointment
            {
                Id = dto.Id,
                Start = dto.Start,
                End = dto.End,
                Title = dto.Title,
                Description = dto.Description,
                ScheduleType = dto.ScheduleType,
                RecurrenceEndDate = dto.RecurrenceEndDate,
                CreatedDate = dto.CreatedDate,
                CreatedBy = dto.CreatedBy,
                ModifiedDate = dto.ModifiedDate,
                LastModifiedBy = dto.LastModifiedBy
            };
        }

        public IEnumerable<AppointmentDto> Map(IEnumerable<Appointment> entities, ClaimsPrincipal? user = null)
        {
            return entities.Select(entity => Map(entity, user));
        }

        public IEnumerable<Appointment> Map(IEnumerable<AppointmentDto> dtos, ClaimsPrincipal? user = null)
        {
            return dtos.Select(dto => Map(dto, user));
        }

        public void Map(AppointmentDto dto, Appointment entity, ClaimsPrincipal? user = null)
        {
            entity.Id = dto.Id;
            entity.Start = dto.Start;
            entity.End = dto.End;
            entity.Title = dto.Title;
            entity.Description = dto.Description;
            entity.ScheduleType = dto.ScheduleType;
            entity.RecurrenceEndDate = dto.RecurrenceEndDate;
            entity.CreatedDate = dto.CreatedDate;
            entity.CreatedBy = dto.CreatedBy;
            entity.ModifiedDate = dto.ModifiedDate;
            entity.LastModifiedBy = dto.LastModifiedBy;
        }

        public void Map(Appointment entity, AppointmentDto dto, ClaimsPrincipal? user = null)
        {
            dto.Id = entity.Id;
            dto.Start = entity.Start;
            dto.End = entity.End;
            dto.Title = entity.Title;
            dto.Description = entity.Description;
            dto.ScheduleType = entity.ScheduleType;
            dto.RecurrenceEndDate = entity.RecurrenceEndDate;
            dto.CreatedDate = entity.CreatedDate;
            dto.CreatedBy = entity.CreatedBy;
            dto.ModifiedDate = entity.ModifiedDate;
            dto.LastModifiedBy = entity.LastModifiedBy;
        }
    }
}
