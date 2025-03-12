using System;
using System.Collections.Generic;

namespace LabWork17.Models;

public partial class Film
{
    public int FilmId { get; set; }

    public string FilmTitle { get; set; } = null!;

    public short FilmSession { get; set; }

    public short Date { get; set; }

    public string? Description { get; set; }

    public string? FilmPoster { get; set; }

    public string? AgeRating { get; set; }

    public DateOnly? RentalBeginning { get; set; }

    public DateOnly? RentalEnd { get; set; }

    public string? Genre { get; set; }

    public bool IsDeleted { get; set; }

    public virtual Genre? GenreNavigation { get; set; }
}
