using System.IO;
using System.Windows.Media;
using System.Windows.Media.Imaging;

namespace NewwaveDesignProject.Cores.MVVM.Utils
{
    public class UserInterface
    {
        public static BitmapImage CreateBitmapImage(string folderName, string imageName)
        {
            string imagePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"..\..\..\UI\Images", $"{folderName}\\{imageName}");
            return new BitmapImage(new Uri(imagePath, UriKind.Absolute));
        }
        public static BitmapImage CreateBitmap(string imageName)
        {
            string imagePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"..\..\..\UI\Images", imageName);
            return new BitmapImage(new Uri(imagePath, UriKind.Absolute));
        }
        public static string ExtractFileNameFromPackUri(string packUri)
        {
            if (string.IsNullOrEmpty(packUri))
                return string.Empty;

            // find last index of "/"
            int lastSlashIndex = packUri.LastIndexOf('/');

            // return origin string if cannot find
            if (lastSlashIndex == -1)
                return packUri;

            // get image name
            string fileName = packUri.Substring(lastSlashIndex + 1);

            return fileName;
        }
        public static SolidColorBrush CreateSolidColorBrush(string colorHex)
        {
            var color = (Color)ColorConverter.ConvertFromString(colorHex);
            return new SolidColorBrush(color);
        }

    }
}
