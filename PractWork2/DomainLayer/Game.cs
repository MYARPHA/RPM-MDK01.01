namespace DomainLayer
{
    public class Game
    {
        public int GameId { get; set; }

        public int CategoryId { get; set; }

        public string Name { get; set; } = null!;

        public decimal Price { get; set; }

        public string? Description { get; set; }

        public virtual Category Category { get; set; } = null!;
    }
}