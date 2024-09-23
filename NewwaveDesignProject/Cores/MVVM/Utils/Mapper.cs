using NewwaveDesignProject.Cores.MVVM.Models;
using NewwaveDesignProject.Feartures.ServicesFeature.Models;
using NewwaveDesignProject.Feartures.Setting.Models;

namespace NewwaveDesignProject.Cores.MVVM.Utils
{
    public static class Mapper
    {
        /// <summary>
        /// Extension method map User to UserDTO
        /// </summary>
        /// <param name="user"></param>
        /// <returns>userDTO</returns>
        public static UserDTO ToDTO(this User user)
        {
            if (user == null) return null;

            return new UserDTO
            {
                Id = user.Id,
                Avatar = UserInterface.CreateBitmap(UserInterface.ExtractFileNameFromPackUri(user.Avatar)),
                UserName = user.UserName,
                FullName = user.FullName,
                Email = user.Email,
                Password = user.Password,
                DateOfBirth = user.DateOfBirth.ToString("dd MMMM yyyy"),
                PresentAddress = user.PresentAddress,
                PermanentAddress = user.PermanentAddress,
                City = user.City,
                Country = user.Country,
                PostalCode = user.PostalCode,
                Currency = user.Currency,
                TimeZone = user.TimeZone,
                IsReceiveDigitaCurrency = user.IsReceiveDigitalCurrency,
                IsReceiveMerchantOrder = user.IsReceiveMerchantOrder,
                IsRecommendation = user.IsRecommendation,
                IsTwoFactorAuthentication = user.IsTwoFactorAuthentication
            };
        }
        /// <summary>
        /// Extension method map UserDTO to User
        /// </summary>
        /// <param name="userDTO"></param>
        /// <returns>userModel</returns>
        public static User ToModel(this UserDTO userDTO)
        {
            if (userDTO == null) return null;
            return new User
            {
                Id = userDTO.Id,
                Avatar = UserInterface.ExtractFileNameFromPackUri(userDTO.Avatar.ToString()),
                FullName = userDTO.FullName ?? throw new ArgumentException("Username cannot be null."),
                UserName = userDTO.UserName,
                Email = userDTO.Email,
                Password = userDTO.Password,
                DateOfBirth = DateTime.TryParse(userDTO.DateOfBirth, out var date) ? date : default,
                PresentAddress = userDTO.PresentAddress,
                PermanentAddress = userDTO.PermanentAddress,
                City = userDTO.City,
                Country = userDTO.Country,
                PostalCode = userDTO.PostalCode,
                Currency = userDTO.Currency,
                TimeZone = userDTO.TimeZone,
                IsReceiveDigitalCurrency = userDTO.IsReceiveDigitaCurrency,
                IsReceiveMerchantOrder = userDTO.IsReceiveMerchantOrder,
                IsRecommendation = userDTO.IsRecommendation,
                IsTwoFactorAuthentication = userDTO.IsTwoFactorAuthentication ?? false
            };
        }

        /// <summary>
        /// Extension method map BankService to CardServicesDTO
        /// </summary>
        /// <param name="bankService"></param>
        /// <returns>userModel</returns>
        public static CardServicesDTO ToCardServicesDTO(this BankService bankService)
        {
            return new CardServicesDTO
            {
                ServiceImage = UserInterface.CreateBitmapImage("BankServices", bankService.Image),
                ServiceName = bankService.ServiceName,
                Slogan = bankService.Slogan,
            };
        }
        /// <summary>
        /// Extension method map BankService to ServiceListItemDTO
        /// </summary>
        /// <param name="bankService"></param>
        /// <returns></returns>
        public static ServiceListItemDTO ToListServiceDTO(this BankService bankService)
        {
            return new ServiceListItemDTO
            {
                ServiceImage = UserInterface.CreateBitmapImage("BankServices", bankService.Image),
                ServiceName = bankService.ServiceName,
                Description = bankService.Description,
                FirstText = bankService.FirstText,
                SecondText = bankService.SecondText,
                ThirdText = bankService.ThirdText,
                FourthText = bankService.FourthText,
                FifthText = bankService.FifthText,
                SixthText = bankService.SixthText
            };
        }
    } 
}

