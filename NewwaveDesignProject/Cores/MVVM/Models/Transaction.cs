using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace NewwaveDesignProject.Cores.MVVM.Models
{
	public class Transaction : Entity
    {
        [Key]
        public int Id { get; set; }
        [ForeignKey("Invoice")]
		public int InvoiceId { get; set; }
		public DateTime Date { get; set; }
        public string? Description { get; set; }
        public decimal Amount { get; set; }
        public string? Type { get; set; }
        public string? Status { get; set; }
        public string? ImageType { get; set; }

        public virtual Invoice? Invoice { get; set; }

    }
}
