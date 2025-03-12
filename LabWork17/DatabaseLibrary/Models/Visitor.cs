using DatabaseLibrary.Data;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;

namespace DatabaseLibrary.Models;

public class Visitor 
{
    public int VisitorId { get; set; }

    public string PhoneNumber { get; set; } = null!;

    public string? Name { get; set; }

    public DateTime? BirthDay { get; set; }

    public string? Email { get; set; }

    public virtual ICollection<Ticket> Tickets { get; set; } = new List<Ticket>();
}
