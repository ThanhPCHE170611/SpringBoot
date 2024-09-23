using NewwaveDesignProject.Feartures.Investments.Models;

namespace NewwaveDesignProject.Cores.MVVM.Commands
{
	public interface IUpdateCommand<T>
	{
		Task Execute(T parameter);
	}
}
