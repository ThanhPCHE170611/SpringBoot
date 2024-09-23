using NewwaveDesignProject.Cores.MVVM.Command;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace NewwaveDesignProject.Feartures.Example.Commands
{
	public class UserProfileCommand : BaseCommand<object>
	{
		public override void Execute(object? parameter)
		{
			MessageBox.Show("Đây là user profile");

		}
	}
}
