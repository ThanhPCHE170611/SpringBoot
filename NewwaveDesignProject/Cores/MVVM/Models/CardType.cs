using System.Collections.ObjectModel;
using System.ComponentModel.DataAnnotations;

namespace NewwaveDesignProject.Cores.MVVM.Models
{
    public class CardType : Entity
    {
        [Key]
        public int Id { get; set; }
        public string? Name { get; set; }
        public virtual ObservableCollection<Card>? Cards { get; set; }
    }
}
