using FluentValidation;
using Boxty.SharedApp.DTOs.UserManagement;
using Boxty.SharedApp.Enums;
using Boxty.SharedBase.Validation;
using Boxty.SharedBase.Enums;

namespace Boxty.SharedApp.Validators
{
    public class SubjectDocumentValidator : BaseValidator<SubjectDocumentDto>
    {
        public SubjectDocumentValidator()
        {
            RuleFor(x => x.Name)
                .NotEmpty().WithMessage("Document name is required.")
                .MinimumLength(2).WithMessage("Document name must be at least 2 characters long.")
                .MaximumLength(255).WithMessage("Document name must be at most 255 characters long.");

            RuleFor(x => x.Description)
                .MaximumLength(1000).WithMessage("Description must be at most 1000 characters long.")
                .When(x => !string.IsNullOrEmpty(x.Description));
        }
    }
}
