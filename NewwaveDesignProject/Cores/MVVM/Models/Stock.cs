using System.Collections.ObjectModel;
using System.ComponentModel.DataAnnotations;

namespace NewwaveDesignProject.Cores.MVVM.Models
{
    public class Stock: Entity
    {
        [Key]
        public int Id { get; set; }
        public string? Name { get; set; }
        public string? Logo { get; set; }
        public string? Description { get; set; }
        public decimal Price { get; set; }
        public decimal ReturnValue { get; set; }

        public virtual ObservableCollection<Investment>? Investments { get; set; }
    }
}
