using System.ComponentModel.DataAnnotations.Schema;

namespace NewwaveDesignProject.Cores.MVVM.Models
{
    public class BankService : Entity
    {
        public string? ServiceName { get; set; }
        public string? Image { get; set; }
        public string? Slogan { get; set; }
        public string? Description { get; set; }
        public string? FirstText { get; set; }
        public string? SecondText { get; set; }
        public string? ThirdText { get; set; }
        public string? FourthText { get; set; }
        public string? FifthText { get; set; }
        public string? SixthText { get; set; }
        public int UsageCount { get; set; } 

        [ForeignKey("Bank")]
        public int BankId { get; set; }

        public virtual Bank? Bank { get; set; }

    }
}
