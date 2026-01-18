using FluentValidation;
using Boxty.SharedApp.DTOs.UserManagement;
using Boxty.SharedBase.Validation;
using Boxty.SharedBase.Enums;

namespace Boxty.SharedApp.Validators
{
    public class SubjectNoteValidator : BaseValidator<SubjectNoteDto>
    {
        public SubjectNoteValidator()
        {
            RuleFor(note => note.Content)
                .NotEmpty().WithMessage("Note content is required.")
                .MaximumLength(1000).WithMessage("Note content must be at most 1000 characters long.");

            RuleFor(note => note.SubjectId)
                .NotEmpty().WithMessage("Subject ID is required.");
        }
    }
}
