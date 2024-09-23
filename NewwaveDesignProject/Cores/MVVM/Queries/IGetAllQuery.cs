using System.Collections.ObjectModel;

namespace NewwaveDesignProject.Cores.MVVM.Queries
{
	public interface IGetAllQuery<T>
	{
		Task<ObservableCollection<T>> Execute();

		
	}

	
}
