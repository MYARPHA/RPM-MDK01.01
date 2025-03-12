namespace Task4
{
    public class Subject
    {
        private List<Observer> observers = new List<Observer>();
        private int state;

        public int State
        {
            get => state;
            set
            {
                state = value;
                NotifyAllObservers();
            }
        }

        public void Attach(Observer observer)
        {
            observers.Add(observer);
        }

        public void NotifyAllObservers()
        {
            foreach (Observer observer in observers)
            {
                observer.Update();
            }
        }
    }
}