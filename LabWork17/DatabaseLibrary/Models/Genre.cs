using System;
using System.Collections.Generic;

namespace DatabaseLibrary.Models;

public partial class Genre
{
    public string Genre1 { get; set; } = null!;

    public virtual ICollection<Film> Films { get; set; } = new List<Film>();
}
