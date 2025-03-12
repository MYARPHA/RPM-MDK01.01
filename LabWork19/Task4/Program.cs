using Task4;

Subject subject = new Subject();

new HexaObserver(subject);
new OctalObserver(subject);
new BinaryObserver(subject);
new DecimalObserver(subject);

Console.WriteLine("First state change: 15");
subject.State = 15;
Console.WriteLine();
Console.WriteLine("Second state change: 10");
subject.State = 10;