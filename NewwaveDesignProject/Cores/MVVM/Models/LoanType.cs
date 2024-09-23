using System.Collections.ObjectModel;
using System.ComponentModel.DataAnnotations;

namespace NewwaveDesignProject.Cores.MVVM.Models
{
    public class LoanType : Entity
    {
        public string? Name { get; set; }
        public string? Description { get; set; }
        public string? Icon { get; set; }
        public virtual ObservableCollection<Loan>? Loans { get; set; }

        public LoanType(int id, string name, string description, string icon)
        {
            Id = id;
            Name = name;
            Description = description;
            Icon = icon;
        }
    }
}
