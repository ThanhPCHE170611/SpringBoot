using System.Collections.ObjectModel;

namespace NewwaveDesignProject.Cores.MVVM.Models
{
    public class User : Entity
    {
      
        public string? UserName { get; set; }
        public string? FullName { get; set; }
        public string? Email { get; set; }
        public string? Password { get; set; }
        public DateTime DateOfBirth { get; set; }
        public string? PresentAddress { get; set; }
        public string? PermanentAddress { get; set; }
        public string? City { get; set; }
        public string? Country { get; set; }
        public string? PostalCode { get; set; }
        public string? Currency { get; set; }
        public string? TimeZone { get; set; }
        public bool IsReceiveDigitalCurrency { get; set; }
        public bool IsReceiveMerchantOrder { get; set; }
        public bool IsRecommendation { get; set; }
        
        public string? Avatar { get; set; }
        public bool IsTwoFactorAuthentication { get; set; }
        public virtual ObservableCollection<Card>? Cards { get; set; }
        public virtual ObservableCollection<Bank>? Banks { get; set; }
    }
}
