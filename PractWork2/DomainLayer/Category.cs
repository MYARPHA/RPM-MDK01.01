using System.Text.Json.Serialization;

namespace DomainLayer
{
    public class Category
    {
        public int CategoryId { get; set; }

        public string Name { get; set; } = null!;
        public virtual ICollection<Game> Games { get; set; } = new List<Game>();
    }
}

