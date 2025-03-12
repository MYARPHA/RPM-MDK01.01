using System;
using System.Collections.Generic;

namespace DatabaseLibrary.Models;

public partial class Visitor
{
    public int VisitorId { get; set; }

    public string Phone { get; set; } = null!;

    public string? Name { get; set; }

    public DateTime? BirthDate { get; set; }

    public string Email { get; set; } = null!;

    public byte[]? Photo { get; set; }

    public virtual ICollection<Ticket> Tickets { get; set; } = new List<Ticket>();
}
