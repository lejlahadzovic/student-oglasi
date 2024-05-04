using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Model.Requests
{
    public class PrakseInsertRequest
    {
        [Required]
        [DateMustBeAfter(nameof(IdNavigation), nameof(PocetakPrakse))]
        public DateTime PocetakPrakse { get; set; }

        [Required]
        [DateMustBeAfter(nameof(PocetakPrakse), nameof(KrajPrakse))]
        public DateTime KrajPrakse { get; set; }
        public string Kvalifikacije { get; set; } = null!;

        public string Benefiti { get; set; } = null!;

        public bool Placena { get; set; }

        public Model.Oglasi? IdNavigation { get; set; }

        public int StatusId { get; set; }

        public int OrganizacijaId { get; set; }
    }

    public class DateMustBeAfterAttribute : ValidationAttribute
    {
        private readonly string _startDatePropertyName;
        private readonly string _endDatePropertyName;

        public DateMustBeAfterAttribute(string startDatePropertyName, string endDatePropertyName)
        {
            _startDatePropertyName = startDatePropertyName;
            _endDatePropertyName = endDatePropertyName;
        }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            var startDatePropertyInfo = validationContext.ObjectType.GetProperty(_startDatePropertyName);

            if (startDatePropertyInfo == null)
            {
                return new ValidationResult($"Unknown property {_startDatePropertyName}");
            }
            if(_startDatePropertyName.Contains("IdNavigation"))
            {
                var idNavigationValue = startDatePropertyInfo.GetValue(validationContext.ObjectInstance);

                var nestedPropertyInfo = idNavigationValue?.GetType().GetProperty("RokPrijave");

                if (nestedPropertyInfo == null)
                {
                    return new ValidationResult($"Unknown RokPrijave property");
                }

                var firstDate = (DateTime)nestedPropertyInfo.GetValue(idNavigationValue);
                var secondDate = (DateTime)value;

                if (firstDate >= secondDate)
                {
                    return new ValidationResult($"The {_endDatePropertyName} must be after RokPrijave");
                }

                return ValidationResult.Success;

            }
            var startDate = (DateTime)startDatePropertyInfo.GetValue(validationContext.ObjectInstance);
            var endDate = (DateTime)value;

            if (endDate <= startDate)
            {
                return new ValidationResult($"The {_endDatePropertyName} must be after {_startDatePropertyName}");
            }

            return ValidationResult.Success;
        }
    }
}

