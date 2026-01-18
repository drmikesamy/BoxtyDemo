using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FluentValidation;
using Boxty.SharedApp.DTOs.UserManagement;
using Boxty.SharedBase.Validation;
using Boxty.SharedBase.Enums;

namespace Boxty.SharedApp.Validators
{
    public class TenantValidator : BaseValidator<TenantDto>
    {
        public TenantValidator()
        {
            RuleFor(x => x.Name)
                .NotEmpty().WithMessage("Tenant name is required.")
                .Length(2, 100).WithMessage("Tenant name must be between 2 and 100 characters.")
                .Must(n => n == null || !n.StartsWith(" ") && !n.EndsWith(" "))
                .WithMessage("Tenant name cannot start or end with spaces.")
                .Matches(@"^[a-zA-Z0-9\s]+$")
                .WithMessage("Tenant name can only contain letters, numbers, and spaces.");

            RuleFor(x => x.Telephone)
                .NotEmpty().WithMessage("Telephone number is required.")
                .Matches(@"^(\+44|0)(\d{9,10})$")
                .WithMessage("Please enter a valid UK telephone number.");

            RuleFor(x => x.Email)
                .Cascade(CascadeMode.Stop)
                .NotEmpty().WithMessage("Email address is required.")
                .EmailAddress().WithMessage("Please enter a valid email address.")
                .MaximumLength(100).WithMessage("Email must be at most 100 characters.")
                .Must(e => !e.Contains("example.com") && !e.Contains("test.com"))
                .WithMessage("Please provide an actual business email.");

            RuleFor(x => x.Address)
                .NotEmpty().WithMessage("Address is required.")
                .Length(5, 200).WithMessage("Address must be between 5 and 200 characters.");

            RuleFor(x => x.Postcode)
                .NotEmpty().WithMessage("Postcode is required.")
                .Matches(@"^[A-Z]{1,2}\d[A-Z\d]? ?\d[A-Z]{2}$")
                .WithMessage("Please enter a valid UK postcode.");

            RuleFor(x => x.Domain)
                .NotEmpty().WithMessage("Domain is required.")
                .MaximumLength(200).WithMessage("Domain must be at most 200 characters.")
                .Matches(@"^(?!:\/\/)([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$")
                .WithMessage("Domain must be a valid domain name (e.g. testing.com), not a full URL.");
        }
    }
}
