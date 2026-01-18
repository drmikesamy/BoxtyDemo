using FluentValidation;
using Boxty.SharedApp.DTOs.UserManagement;
using Boxty.SharedBase.Validation;
using Boxty.SharedBase.Enums;

namespace Boxty.SharedApp.Validators
{
    public class TenantNoteValidator : BaseValidator<TenantNoteDto>
    {
        public TenantNoteValidator()
        {
            RuleFor(note => note.Content)
                .NotEmpty().WithMessage("Note content is required.")
                .MaximumLength(1000).WithMessage("Note content must be at most 1000 characters long.");

            RuleFor(note => note.TenantId)
                .NotEmpty().WithMessage("Tenant ID is required.");
        }
    }
}
