using System.Text.RegularExpressions;
using FluentValidation;
using Boxty.SharedApp.DTOs.UserManagement;
using Boxty.SharedBase.Validation;
using Boxty.SharedBase.Enums;

namespace Boxty.SharedApp.Validators
{
    public class SubjectValidator : BaseValidator<SubjectDto>
    {
        public SubjectValidator()
        {
            RuleFor(e => e.FirstName)
                .NotEmpty().WithMessage("First Name is required.")
                .MinimumLength(2).WithMessage("First Name must be at least 2 characters.")
                .MaximumLength(50).WithMessage("First Name must be at most 50 characters.")
                .Matches("^[a-zA-Z\\-' ]+$").WithMessage("First Name can only contain letters, spaces, hyphens, and apostrophes.");

            RuleFor(e => e.LastName)
                .NotEmpty().WithMessage("Last Name is required.")
                .MinimumLength(2).WithMessage("Last Name must be at least 2 characters.")
                .MaximumLength(50).WithMessage("Last Name must be at most 50 characters.")
                .Matches("^[a-zA-Z\\-' ]+$").WithMessage("Last Name can only contain letters, spaces, hyphens, and apostrophes.");

            RuleFor(e => e.DOB)
                .NotEmpty().WithMessage("Date of Birth is required.")
                .Must(dob => dob != null && dob <= DateTime.Today.AddYears(-18))
                .WithMessage("Subject must be at least 18 years old.");

            RuleFor(e => e.Address1)
                .NotEmpty().WithMessage("Address Line 1 is required.")
                .MinimumLength(5).WithMessage("Address Line 1 must be at least 5 characters.")
                .MaximumLength(100).WithMessage("Address Line 1 must be at most 100 characters.");

            RuleFor(e => e.Address2)
                .MaximumLength(100).WithMessage("Address Line 2 must be at most 100 characters.");

            RuleFor(e => e.Postcode)
                .NotEmpty().WithMessage("Postcode is required.")
                .Matches(@"^[A-Z]{1,2}\d[A-Z\d]? ?\d[A-Z]{2}$")
                .WithMessage("Postcode must be a valid UK postcode.");

            RuleFor(e => e.Email)
                .NotEmpty().WithMessage("A valid Email is required.")
                .EmailAddress().WithMessage("A valid Email is required.")
                .MaximumLength(100).WithMessage("Email must be at most 100 characters.");

            RuleFor(e => e.Telephone)
                .NotEmpty().WithMessage("Telephone is required.")
                .Matches(@"^(\+44\s?7\d{3}|\(?07\d{3}\)?)\s?\d{3}\s?\d{3}$")
                .WithMessage("Telephone must be a valid UK mobile number.");

            RuleFor(e => e.TenantId)
                .NotEqual(Guid.Empty).WithMessage("Tenant selection is required.");
        }
    }
}