namespace Task4
{
    public class BinaryObserver : Observer
    {
        private Subject subject;

        public BinaryObserver(Subject subject)
        {
            this.subject = subject;
            subject.Attach(this);
        }

        public override void Update()
        {
            Console.WriteLine($"Binary string: {Convert.ToString(subject.State, 2)}");
        }
    }
}