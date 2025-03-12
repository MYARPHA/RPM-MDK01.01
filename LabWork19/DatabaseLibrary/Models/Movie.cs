using System;
using System.Collections.Generic;

namespace DatabaseLibrary.Models;

public partial class Movie
{
    public int MovieId { get; set; }

    public string Title { get; set; } = null!;

    public short Duration { get; set; }

    public short ReleaseYear { get; set; }

    public string? Description { get; set; }

    public string? Poster { get; set; }

    public string? AgeRating { get; set; }

    public DateOnly? RentStart { get; set; }

    public DateOnly? RentEnd { get; set; }

    public bool? IsDeleted { get; set; }
}
