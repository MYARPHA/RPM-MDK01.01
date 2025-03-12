using System;
using System.Collections.Generic;

namespace LabWork21.Models;

public partial class Lw21game
{
    public int IdGame { get; set; }

    public string Name { get; set; } = null!;

    public string? Description { get; set; }

    public int IdCategory { get; set; }

    public decimal Price { get; set; }

    public string? LogoFile { get; set; }
}
