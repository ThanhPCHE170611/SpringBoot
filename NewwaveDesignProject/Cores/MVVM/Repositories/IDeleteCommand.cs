namespace NewwaveDesignProject.Cores.MVVM.Commands
{
	public interface IDeleteCommand<T>
	{
		Task Execute(T parameter);
	}
}
