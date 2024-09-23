using System.Windows.Input;

namespace NewwaveDesignProject.Cores.MVVM.Command
{
    public class RelayCommand<T> : ICommand
    {
        private readonly Action<T> _execute;
        private readonly Func<T, bool> _canExecute;

        public RelayCommand(Action<T> execute, Func<T, bool> canExecute = null)
        {
            _execute = execute ?? throw new ArgumentNullException(nameof(execute));
            _canExecute = canExecute;
        }

        public RelayCommand(Action<T> execute)
        {
            _execute = execute ?? throw new ArgumentNullException(nameof(execute));
            _canExecute = (arg) => true;
        }

		public bool CanExecute(object? parameter) => _canExecute == null || _canExecute((T)parameter!);

		public void Execute(object? parameter) => _execute((T)parameter!);

        public event EventHandler? CanExecuteChanged
		{
			add => CommandManager.RequerySuggested += value;
			remove => CommandManager.RequerySuggested -= value;
		}
        public void RaiseCanExecuteChanged()
        {
            CommandManager.InvalidateRequerySuggested();
        }
    }


	public abstract class BaseCommand<T> : ICommand
	{

		public event EventHandler? CanExecuteChanged
		{
			add => CommandManager.RequerySuggested += value;
			remove => CommandManager.RequerySuggested -= value;
		}

		public virtual bool CanExecute(object? parameter)
		{
			return true;
		}

		public abstract void Execute(object? parameter);

	}


}
