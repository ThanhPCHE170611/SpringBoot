using Microsoft.Win32;
using NewwaveDesignProject.Cores.MVVM.Models;
using NewwaveDesignProject.Cores.MVVM.Repository;
using NewwaveDesignProject.Cores.MVVM.Utils;
using NewwaveDesignProject.Feartures.Setting.Models;
using System.IO;

namespace NewwaveDesignProject.Services
{
    public class UserServices : IUserServices
    {
        private readonly IRepository<User> repository;
        private UserDTO? originalUser;

        public UserServices(IRepository<User> repository)
        {
            this.repository = repository;
        }

        public async Task<UserDTO> GetUserAsync(int id)
        {
            User foundUser = await repository.Get(id);
            UserDTO userDTO = foundUser.ToDTO();

            // Store a copy of the original user
            originalUser = new UserDTO(userDTO);

            return userDTO;
        }

        public async Task<(UserDTO? user, string message)> UpdateUserAsync(UserDTO user, string? currentPassword, string? newPassword)
        {
            if (!IsUserInfoChanged(user) && !IsPasswordChangeRequested(newPassword))
            {
                return (null, "Unable to detect any changes for update");
            }

            if (IsPasswordChangeRequested(newPassword))
            {
                if (!IsValidPasswordUpdate(user, currentPassword, newPassword))
                {
                    return (null, "You have entered the wrong current password or the new password does not meet the requirements (at least 8 characters, includes a special character, and an uppercase letter).");
                }
                user.Password = newPassword;
            }

            bool isUpdated = await repository.UpdateAsync(user.ToModel());
            if (isUpdated)
            {
                originalUser = new UserDTO(user);
                return (user, "Your info has been updated!");
            }
            return (null, "Something went wrong, cannot update yet!");
        }

        public (string? avatar, string message) ChooseAvatar()
        {
            OpenFileDialog openFileDialog = new OpenFileDialog
            {
                Filter = "Image files (*.png;*.jpeg;*.jpg)|*.png;*.jpeg;*.jpg|All files (*.*)|*.*"
            };

            if (openFileDialog.ShowDialog() == true)
            {
                string sourceFilePath = openFileDialog.FileName;
                string fileName = Path.GetFileName(sourceFilePath);
                string destinationFolder = Path.GetFullPath(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"..\..\..\UI\Images"));
                string destinationFilePath = Path.Combine(destinationFolder, fileName);

                try
                {
                    if (!Directory.Exists(destinationFolder))
                    {
                        Directory.CreateDirectory(destinationFolder);
                    }

                    File.Copy(sourceFilePath, destinationFilePath, true);
                    return (fileName, "Avatar updated successfully");
                }
                catch (Exception ex)
                {
                    return (null, $"Something went wrong: {ex.Message}");
                }
            }

            return (null, "No file selected");
        }

        private bool IsUserInfoChanged(UserDTO user) => user != null && originalUser != null && !user.Equals(originalUser);

        private bool IsPasswordChangeRequested(string? newPassword) => !string.IsNullOrEmpty(newPassword);

        private bool IsValidPasswordUpdate(UserDTO user, string? currentPassword, string? newPassword)
        {
            if (string.IsNullOrEmpty(currentPassword) || string.IsNullOrEmpty(newPassword))
                return false;

            if (user == null || currentPassword != user.Password)
                return false;

            if (currentPassword == newPassword)
                return false;

            return IsValidPassword(newPassword);
        }

        private bool IsValidPassword(string password)
        {
            if (string.IsNullOrEmpty(password)) return false;
            return password.Length >= 8 && password.Any(char.IsUpper) && password.Any(ch => !char.IsLetterOrDigit(ch));
        }
    }
}