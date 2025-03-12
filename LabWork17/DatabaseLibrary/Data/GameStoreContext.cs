using System;
using System.Collections.Generic;
using DatabaseLibrary.Models;
using Microsoft.EntityFrameworkCore;

namespace DatabaseLibrary.Data;

public partial class GameStoreContext : DbContext
{
    public GameStoreContext()
    {
    }

    public GameStoreContext(DbContextOptions<GameStoreContext> options)
        : base(options)
    {
        ChangeTracker.LazyLoadingEnabled = true; // вкл загрузка связанных данных
    }

    public virtual DbSet<Film> Films { get; set; }

    public virtual DbSet<Genre> Genres { get; set; }

    public virtual DbSet<Ticket> Tickets { get; set; }

    public virtual DbSet<Visitor> Visitors { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseSqlServer("Data Source = mssql; Initial Catalog = ispp3511; User ID = ispp3511; Password = 3511; Trust Server Certificate=True");
        optionsBuilder.UseQueryTrackingBehavior(QueryTrackingBehavior.NoTracking); // отключение отслеживания изменений
    }
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Film>(entity =>
        {
            entity.ToTable("Film", tb => tb.HasTrigger("trDeletedFilm"));

            entity.Property(e => e.AgeRating)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.Date).HasDefaultValueSql("(datepart(year,getdate()))");
            entity.Property(e => e.Description).HasMaxLength(500);
            entity.Property(e => e.FilmPoster).IsUnicode(false);
            entity.Property(e => e.FilmSession).HasDefaultValue((short)90);
            entity.Property(e => e.FilmTitle).HasMaxLength(100);
            entity.Property(e => e.Genre).HasMaxLength(50);

            entity.HasOne(d => d.GenreNavigation).WithMany(p => p.Films)
                .HasForeignKey(d => d.Genre)
                .HasConstraintName("FK_Film_Genre");
        });

        modelBuilder.Entity<Genre>(entity =>
        {
            entity.HasKey(e => e.Genre1).HasName("PK_Genre_1");

            entity.ToTable("Genre");

            entity.Property(e => e.Genre1)
                .HasMaxLength(50)
                .HasColumnName("Genre");
        });

        modelBuilder.Entity<Ticket>(entity =>
        {
            entity.ToTable("Ticket");

            entity.HasIndex(e => e.Place, "UQ_Place").IsUnique();

            entity.HasIndex(e => e.Row, "UQ_Row").IsUnique();

            entity.HasOne(d => d.Visitor).WithMany(p => p.Tickets)
                .HasForeignKey(d => d.VisitorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKVisitorId");
        });

        modelBuilder.Entity<Visitor>(entity =>
        {
            entity.ToTable("Visitor", tb =>
                {
                    tb.HasTrigger("trSaveEmail");
                    tb.HasTrigger("trSaveVisitor");
                });

            entity.HasIndex(e => e.Email, "UQ_VisitorEmail").IsUnique();

            entity.HasIndex(e => e.PhoneNumber, "UQ_VisitorPhone").IsUnique();

            entity.Property(e => e.Email)
                .HasMaxLength(150)
                .IsUnicode(false);
            entity.Property(e => e.Name).HasMaxLength(50);
            entity.Property(e => e.PhoneNumber)
                .HasMaxLength(20)
                .IsUnicode(false)
                .IsFixedLength();
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
