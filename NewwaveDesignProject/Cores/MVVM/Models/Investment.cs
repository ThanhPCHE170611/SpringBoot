using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace NewwaveDesignProject.Cores.MVVM.Models
{
    public class Investment : Entity
    {
        [Key]
        public int Id { get; set; }

        [ForeignKey("Card")]
        public int CardId { get; set; }

        [ForeignKey("Stock")]
        public int StockId { get; set; }
        public decimal Amount { get; set; }
        public virtual Card? Card { get; set; }
        public virtual Stock? Stock { get; set; }
    }
}
