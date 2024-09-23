namespace NewwaveDesignProject.Cores.MVVM.Commands
{
	public interface ICreateCommand<T>
	{
		Task Execute(T parameter);
		
	}
}
