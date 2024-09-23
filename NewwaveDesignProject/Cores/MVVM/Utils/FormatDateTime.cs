namespace NewwaveDesignProject.Cores.MVVM.Utils
{
	public class FormatDateTime
	{
		public static string GetRelativeTimeString(DateTime dateTime)
		{
			var now = DateTime.Now;
			var diff = now - dateTime;

			if (diff.TotalHours < 24)
			{
				return $"{(int)diff.TotalHours}h ago";
			}
			else if (diff.TotalDays < 30)
			{
				return $"{(int)diff.TotalDays} days ago";
			}
			else if (diff.TotalDays < 365)
			{
				int months = (int)(diff.TotalDays / 30);  // Ước tính số tháng
				return $"{months} month{(months > 1 ? "s" : "")} ago";
			}
			else
			{
				return dateTime.ToString("MMM dd, yyyy");
			}
		}
	}
}
