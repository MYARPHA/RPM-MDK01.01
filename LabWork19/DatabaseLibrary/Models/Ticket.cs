using System;
using System.Collections.Generic;

namespace DatabaseLibrary.Models;

public partial class Ticket
{
    public int TicketId { get; set; }

    public int SessionId { get; set; }

    public int VisitorId { get; set; }

    public byte Seat { get; set; }

    public byte Row { get; set; }

    public virtual Visitor Visitor { get; set; } = null!;
}
