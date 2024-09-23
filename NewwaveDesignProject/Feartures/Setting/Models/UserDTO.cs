using NewwaveDesignProject.Cores.MVVM;
using System.Windows.Media;
namespace NewwaveDesignProject.Feartures.Setting.Models
{
    public class UserDTO : ModelBase
    {
        public int Id { get; set; }
        public ImageSource? Avatar { get; set; }
        public string? UserName { get; set; }
        public string? FullName { get; set; }
        public string? Email { get; set; }
        public string? Password { get; set; }
        public string? DateOfBirth { get; set; }
        public string? PermanentAddress { get; set; }
        public string? PresentAddress { get; set; }
        public string? City { get; set; }
        public string? PostalCode { get; set; }
        public string? Country { get; set; }
        public bool IsReceiveDigitaCurrency { get; set; }
        public bool IsReceiveMerchantOrder { get; set; }
        public bool IsRecommendation { get; set; }
        public string? Currency { get; set; }
        public string? TimeZone { get; set; }
        public bool? IsTwoFactorAuthentication { get; set; }

        public UserDTO(UserDTO userDTO)
        {
            Id = userDTO.Id;
            Avatar = userDTO.Avatar;
            UserName = userDTO.UserName;
            FullName = userDTO.FullName;
            Email = userDTO.Email;
            Password = userDTO.Password;
            DateOfBirth = userDTO.DateOfBirth;
            PermanentAddress = userDTO.PermanentAddress;
            PresentAddress = userDTO.PresentAddress;
            City = userDTO.City;
            PostalCode = userDTO.PostalCode;
            Country = userDTO.Country;
            TimeZone = userDTO.TimeZone;
            Currency = userDTO.Currency;
            IsReceiveDigitaCurrency = userDTO.IsReceiveDigitaCurrency;
            IsReceiveMerchantOrder = userDTO.IsReceiveMerchantOrder;
            IsRecommendation = userDTO.IsRecommendation;
            IsTwoFactorAuthentication = userDTO.IsTwoFactorAuthentication;
        }
        public UserDTO(){}
        public override bool Equals(object? obj)
        {
            if (obj is not UserDTO other) return false;

            return Id == Id &&
                   Avatar == other.Avatar &&
                   UserName == other.UserName &&
                   FullName == other.FullName &&
                   Email == other.Email &&
                   Password == other.Password &&
                   DateOfBirth == other.DateOfBirth &&
                   PermanentAddress == other.PermanentAddress &&
                   PresentAddress == other.PresentAddress &&
                   PostalCode == other.PostalCode &&
                   City == other.City &&
                   Country == other.Country &&
                   Currency == other.Currency &&
                   TimeZone == other.TimeZone &&
                   IsReceiveDigitaCurrency == other.IsReceiveDigitaCurrency &&
                   IsRecommendation == other.IsRecommendation &&
                   IsTwoFactorAuthentication == other.IsTwoFactorAuthentication;
        }
    }

}

