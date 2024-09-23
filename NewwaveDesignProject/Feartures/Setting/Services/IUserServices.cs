using NewwaveDesignProject.Feartures.Setting.Models;

namespace NewwaveDesignProject.Services
{
    public interface IUserServices
    {
        Task<UserDTO> GetUserAsync(int Id);
        Task<(UserDTO? user, string message)> UpdateUserAsync(UserDTO user, string? currentPassword, string? newPassword);
        (string? avatar, string message) ChooseAvatar();
    }
}
