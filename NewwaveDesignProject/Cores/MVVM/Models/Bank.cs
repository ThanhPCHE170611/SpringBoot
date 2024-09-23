using System.Collections.ObjectModel;

namespace NewwaveDesignProject.Cores.MVVM.Models
{
    public class Bank : Entity
    {
        public string? Name { get; set; }
        public virtual ObservableCollection<Card>? Cards { get; set; }
    }
}
