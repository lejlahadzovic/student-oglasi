using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace StudentOglasi.Services.Database;

public partial class StudentoglasiContext : DbContext
{
    public StudentoglasiContext()
    {
    }

    public StudentoglasiContext(DbContextOptions<StudentoglasiContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Fakulteti> Fakultetis { get; set; }

    public virtual DbSet<Grad> Grads { get; set; }

    public virtual DbSet<Kategorija> Kategorijas { get; set; }

    public virtual DbSet<Komentari> Komentaris { get; set; }

    public virtual DbSet<Korisnici> Korisnicis { get; set; }

    public virtual DbSet<NacinStudiranja> NacinStudiranjas { get; set; }

    public virtual DbSet<Objave> Objaves { get; set; }

    public virtual DbSet<Ocjene> Ocjenes { get; set; }

    public virtual DbSet<Oglasi> Oglasis { get; set; }

    public virtual DbSet<Organizacije> Organizacijes { get; set; }

    public virtual DbSet<Prakse> Prakses { get; set; }

    public virtual DbSet<PrijavePraksa> PrijavePraksas { get; set; }

    public virtual DbSet<PrijaveStipendija> PrijaveStipendijas { get; set; }

    public virtual DbSet<Rezervacije> Rezervacijes { get; set; }

    public virtual DbSet<Smjerovi> Smjerovis { get; set; }

    public virtual DbSet<SmjeroviFakulteti> SmjeroviFakultetis { get; set; }

    public virtual DbSet<Smjestaji> Smjestajis { get; set; }

    public virtual DbSet<SmjestajnaJedinica> SmjestajnaJedinicas { get; set; }

    public virtual DbSet<StatusOglasi> StatusOglasis { get; set; }

    public virtual DbSet<StatusPrijave> StatusPrijaves { get; set; }

    public virtual DbSet<Stipendije> Stipendijes { get; set; }

    public virtual DbSet<Stipenditori> Stipenditoris { get; set; }

    public virtual DbSet<Studenti> Studentis { get; set; }

    public virtual DbSet<Uloge> Uloges { get; set; }

    public virtual DbSet<Univerziteti> Univerzitetis { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=localhost;Initial Catalog=Studentoglasi;Trusted_Connection=True;TrustServerCertificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Fakulteti>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_Fakultet");

            entity.ToTable("Fakulteti");

            entity.HasIndex(e => e.UniverzitetId, "IX_Fakultet_UniverzitetID");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Adresa).HasMaxLength(50);
            entity.Property(e => e.Email).HasMaxLength(50);
            entity.Property(e => e.Link).HasMaxLength(50);
            entity.Property(e => e.Logo).HasMaxLength(50);
            entity.Property(e => e.Naziv).HasMaxLength(50);
            entity.Property(e => e.Opis).HasMaxLength(50);
            entity.Property(e => e.Slika).HasMaxLength(50);
            entity.Property(e => e.Telefon).HasMaxLength(50);
            entity.Property(e => e.UniverzitetId).HasColumnName("UniverzitetID");

            entity.HasOne(d => d.Univerzitet).WithMany(p => p.Fakultetis)
                .HasForeignKey(d => d.UniverzitetId)
                .HasConstraintName("FK_Fakultet_Univerzitet_UniverzitetID");
        });

        modelBuilder.Entity<Grad>(entity =>
        {
            entity.ToTable("Grad");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Naziv).HasMaxLength(50);
        });

        modelBuilder.Entity<Kategorija>(entity =>
        {
            entity.ToTable("Kategorija");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Naziv).HasMaxLength(50);
            entity.Property(e => e.Opis).HasMaxLength(50);
        });

        modelBuilder.Entity<Komentari>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_Komentar");

            entity.ToTable("Komentari");

            entity.HasIndex(e => e.KomentarId, "IX_Komentar_KomentarID");

            entity.HasIndex(e => e.KorisnikId, "IX_Komentar_KorisnikID");

            entity.HasIndex(e => e.ObjavaId, "IX_Komentar_ObjavaID");

            entity.HasIndex(e => e.OglasId, "IX_Komentar_OglasID");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.KomentarId).HasColumnName("KomentarID");
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.ObjavaId).HasColumnName("ObjavaID");
            entity.Property(e => e.OglasId).HasColumnName("OglasID");
            entity.Property(e => e.Text).HasMaxLength(50);

            entity.HasOne(d => d.Komentar).WithMany(p => p.InverseKomentar)
                .HasForeignKey(d => d.KomentarId)
                .HasConstraintName("FK_Komentar_Komentar_KomentarID");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Komentaris)
                .HasForeignKey(d => d.KorisnikId)
                .HasConstraintName("FK_Komentar_Korisnik_KorisnikID");

            entity.HasOne(d => d.Objava).WithMany(p => p.Komentaris)
                .HasForeignKey(d => d.ObjavaId)
                .HasConstraintName("FK_Komentar_Objava_ObjavaID");

            entity.HasOne(d => d.Oglas).WithMany(p => p.Komentaris)
                .HasForeignKey(d => d.OglasId)
                .HasConstraintName("FK_Komentar_Oglas_OglasID");
        });

        modelBuilder.Entity<Korisnici>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_Korisnik");

            entity.ToTable("Korisnici");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Email).HasMaxLength(50);
            entity.Property(e => e.Ime).HasMaxLength(50);
            entity.Property(e => e.KroisnickoIme).HasMaxLength(50);
            entity.Property(e => e.LozinkaHash).HasMaxLength(50);
            entity.Property(e => e.LozinkaSalt).HasMaxLength(50);
            entity.Property(e => e.Prezime).HasMaxLength(50);
            entity.Property(e => e.Slika).HasMaxLength(50);
            entity.Property(e => e.UlogaId).HasColumnName("UlogaID");

            entity.HasOne(d => d.Uloga).WithMany(p => p.Korisnicis)
                .HasForeignKey(d => d.UlogaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Korisnici_Uloge");
        });

        modelBuilder.Entity<NacinStudiranja>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__NacinStu__3214EC27E3E6A60C");

            entity.ToTable("NacinStudiranja");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.Naziv).HasMaxLength(50);
            entity.Property(e => e.Opis).HasMaxLength(250);
        });

        modelBuilder.Entity<Objave>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_Objava");

            entity.ToTable("Objave");

            entity.HasIndex(e => e.KategorijaId, "IX_Objava_KategorijaID");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.KategorijaId).HasColumnName("KategorijaID");
            entity.Property(e => e.Naslov).HasMaxLength(50);
            entity.Property(e => e.Sadrzaj).HasMaxLength(500);
            entity.Property(e => e.Slika).HasMaxLength(50);

            entity.HasOne(d => d.Kategorija).WithMany(p => p.Objaves)
                .HasForeignKey(d => d.KategorijaId)
                .HasConstraintName("FK_Objava_Kategorija_KategorijaID");
        });

        modelBuilder.Entity<Ocjene>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_Ocjena");

            entity.ToTable("Ocjene");

            entity.HasIndex(e => e.FakultetId, "IX_Ocjena_FakultetID");

            entity.HasIndex(e => e.FirmaId, "IX_Ocjena_FirmaID");

            entity.HasIndex(e => e.SmjestajId, "IX_Ocjena_SmjestajID");

            entity.HasIndex(e => e.StipenditorId, "IX_Ocjena_StipenditorID");

            entity.HasIndex(e => e.StudentId, "IX_Ocjena_StudentId");

            entity.HasIndex(e => e.UniverzitetId, "IX_Ocjena_UniverzitetID");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.FakultetId).HasColumnName("FakultetID");
            entity.Property(e => e.FirmaId).HasColumnName("FirmaID");
            entity.Property(e => e.Komentar).HasMaxLength(50);
            entity.Property(e => e.SmjestajId).HasColumnName("SmjestajID");
            entity.Property(e => e.StipenditorId).HasColumnName("StipenditorID");
            entity.Property(e => e.UniverzitetId).HasColumnName("UniverzitetID");

            entity.HasOne(d => d.Fakultet).WithMany(p => p.Ocjenes)
                .HasForeignKey(d => d.FakultetId)
                .HasConstraintName("FK_Ocjena_Fakultet_FakultetID");

            entity.HasOne(d => d.Firma).WithMany(p => p.Ocjenes)
                .HasForeignKey(d => d.FirmaId)
                .HasConstraintName("FK_Ocjena_Firma_FirmaID");

            entity.HasOne(d => d.Smjestaj).WithMany(p => p.Ocjenes)
                .HasForeignKey(d => d.SmjestajId)
                .HasConstraintName("FK_Ocjena_Smjestaj_SmjestajID");

            entity.HasOne(d => d.Stipenditor).WithMany(p => p.Ocjenes)
                .HasForeignKey(d => d.StipenditorId)
                .HasConstraintName("FK_Ocjena_Stipenditor_StipenditorID");

            entity.HasOne(d => d.Student).WithMany(p => p.Ocjenes)
                .HasForeignKey(d => d.StudentId)
                .HasConstraintName("FK_Ocjena_Student_StudentId");

            entity.HasOne(d => d.Univerzitet).WithMany(p => p.Ocjenes)
                .HasForeignKey(d => d.UniverzitetId)
                .HasConstraintName("FK_Ocjena_Univerzitet_UniverzitetID");
        });

        modelBuilder.Entity<Oglasi>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_Oglas");

            entity.ToTable("Oglasi");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Naslov).HasMaxLength(50);
            entity.Property(e => e.Opis).HasMaxLength(500);
            entity.Property(e => e.Slika).HasMaxLength(50);
        });

        modelBuilder.Entity<Organizacije>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_Firma");

            entity.ToTable("Organizacije");

            entity.HasIndex(e => e.GradId, "IX_Firma_GradID");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Adresa).HasMaxLength(50);
            entity.Property(e => e.Email).HasMaxLength(50);
            entity.Property(e => e.GradId).HasColumnName("GradID");
            entity.Property(e => e.Link).HasMaxLength(50);
            entity.Property(e => e.Naziv).HasMaxLength(50);
            entity.Property(e => e.Telefon).HasMaxLength(50);

            entity.HasOne(d => d.Grad).WithMany(p => p.Organizacijes)
                .HasForeignKey(d => d.GradId)
                .HasConstraintName("FK_Firma_Grad_GradID");
        });

        modelBuilder.Entity<Prakse>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_Praksa");

            entity.ToTable("Prakse");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.Benefiti).HasMaxLength(200);
            entity.Property(e => e.Kvalifikacije).HasMaxLength(200);
            entity.Property(e => e.OrganizacijaId).HasColumnName("OrganizacijaID");
            entity.Property(e => e.StatusId).HasColumnName("StatusID");

            entity.HasOne(d => d.IdNavigation).WithOne(p => p.Prakse)
                .HasForeignKey<Prakse>(d => d.Id)
                .HasConstraintName("FK_Praksa_Oglas_ID");

            entity.HasOne(d => d.Organizacija).WithMany(p => p.Prakses)
                .HasForeignKey(d => d.OrganizacijaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Stipendije_Organizacija");

            entity.HasOne(d => d.Status).WithMany(p => p.Prakses)
                .HasForeignKey(d => d.StatusId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Prakse_StatusOglasi");
        });

        modelBuilder.Entity<PrijavePraksa>(entity =>
        {
            entity.HasKey(e => new { e.StudentId, e.PraksaId }).HasName("PK_PrijavaPraksa");

            entity.ToTable("PrijavePraksa");

            entity.HasIndex(e => e.PraksaId, "IX_PrijavaPraksa_PraksaId");

            entity.Property(e => e.Certifikati).HasMaxLength(50);
            entity.Property(e => e.Cv)
                .HasMaxLength(50)
                .HasColumnName("CV");
            entity.Property(e => e.PropratnoPismo).HasMaxLength(50);
            entity.Property(e => e.StatusId).HasColumnName("StatusID");

            entity.HasOne(d => d.Praksa).WithMany(p => p.PrijavePraksas)
                .HasForeignKey(d => d.PraksaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_PrijavaPraksa_Praksa_PraksaId");

            entity.HasOne(d => d.Status).WithMany(p => p.PrijavePraksas)
                .HasForeignKey(d => d.StatusId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_PrijavePraksa_StatusPrijave");

            entity.HasOne(d => d.Student).WithMany(p => p.PrijavePraksas)
                .HasForeignKey(d => d.StudentId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_PrijavaPraksa_Student_StudentId");
        });

        modelBuilder.Entity<PrijaveStipendija>(entity =>
        {
            entity.HasKey(e => new { e.StudentId, e.StipendijaId }).HasName("PK_PrijavaStipendija");

            entity.ToTable("PrijaveStipendija");

            entity.HasIndex(e => e.StipendijaId, "IX_PrijavaStipendija_StipendijaID");

            entity.Property(e => e.StipendijaId).HasColumnName("StipendijaID");
            entity.Property(e => e.Cv)
                .HasMaxLength(50)
                .HasColumnName("CV");
            entity.Property(e => e.Dokumentacija).HasMaxLength(50);
            entity.Property(e => e.ProsjekOcjena).HasColumnType("decimal(4, 2)");
            entity.Property(e => e.StatusId).HasColumnName("StatusID");

            entity.HasOne(d => d.Status).WithMany(p => p.PrijaveStipendijas)
                .HasForeignKey(d => d.StatusId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_PrijaveStipendija_StatusPrijave");

            entity.HasOne(d => d.Stipendija).WithMany(p => p.PrijaveStipendijas)
                .HasForeignKey(d => d.StipendijaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_PrijavaStipendija_Stipendija_StipendijaID");

            entity.HasOne(d => d.Student).WithMany(p => p.PrijaveStipendijas)
                .HasForeignKey(d => d.StudentId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_PrijavaStipendija_Student_StudentId");
        });

        modelBuilder.Entity<Rezervacije>(entity =>
        {
            entity.HasKey(e => new { e.StudentId, e.SmjestajId }).HasName("PK_Rezervacija");

            entity.ToTable("Rezervacije");

            entity.HasIndex(e => e.SmjestajId, "IX_Rezervacija_SmjestajId");

            entity.Property(e => e.Napomena).HasMaxLength(50);
            entity.Property(e => e.StatusId).HasColumnName("StatusID");

            entity.HasOne(d => d.Smjestaj).WithMany(p => p.Rezervacijes)
                .HasForeignKey(d => d.SmjestajId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Rezervacija_Smjestaj_SmjestajId");

            entity.HasOne(d => d.Status).WithMany(p => p.Rezervacijes)
                .HasForeignKey(d => d.StatusId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Rezervacije_StatusPrijave");

            entity.HasOne(d => d.Student).WithMany(p => p.Rezervacijes)
                .HasForeignKey(d => d.StudentId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Rezervacija_Student_StudentId");
        });

        modelBuilder.Entity<Smjerovi>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Smjerovi__3214EC273399A25C");

            entity.ToTable("Smjerovi");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.Naziv).HasMaxLength(50);
            entity.Property(e => e.Opis).HasMaxLength(250);
        });

        modelBuilder.Entity<SmjeroviFakulteti>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Smjerovi__3214EC275C1E8183");

            entity.ToTable("SmjeroviFakulteti");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.FakultetId).HasColumnName("FakultetID");
            entity.Property(e => e.SmjerId).HasColumnName("SmjerID");

            entity.HasOne(d => d.Fakultet).WithMany(p => p.SmjeroviFakultetis)
                .HasForeignKey(d => d.FakultetId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__SmjeroviF__Fakul__6CD828CA");

            entity.HasOne(d => d.Smjer).WithMany(p => p.SmjeroviFakultetis)
                .HasForeignKey(d => d.SmjerId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__SmjeroviF__Smjer__6BE40491");
        });

        modelBuilder.Entity<Smjestaji>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_Smjestaj");

            entity.ToTable("Smjestaji");

            entity.HasIndex(e => e.GradId, "IX_Smjestaj_GradID");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.DodatneUsluge).HasMaxLength(200);
            entity.Property(e => e.GradId).HasColumnName("GradID");
            entity.Property(e => e.NacinGrijanja).HasMaxLength(50);

            entity.HasOne(d => d.Grad).WithMany(p => p.Smjestajis)
                .HasForeignKey(d => d.GradId)
                .HasConstraintName("FK_Smjestaj_Grad_GradID");

            entity.HasOne(d => d.IdNavigation).WithOne(p => p.Smjestaji)
                .HasForeignKey<Smjestaji>(d => d.Id)
                .HasConstraintName("FK_Smjestaj_Oglas_ID");
        });

        modelBuilder.Entity<SmjestajnaJedinica>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Smjestaj__3214EC272D2D6DC1");

            entity.ToTable("SmjestajnaJedinica");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.Cijena).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.DodatneUsluge).HasMaxLength(50);
            entity.Property(e => e.Opis).HasMaxLength(250);
            entity.Property(e => e.SmjestajId).HasColumnName("SmjestajID");

            entity.HasOne(d => d.Smjestaj).WithMany(p => p.SmjestajnaJedinicas)
                .HasForeignKey(d => d.SmjestajId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Smjestajn__Smjes__0D44F85C");
        });

        modelBuilder.Entity<StatusOglasi>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__StatusOg__3214EC27976EBE5C");

            entity.ToTable("StatusOglasi");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.Naziv).HasMaxLength(50);
        });

        modelBuilder.Entity<StatusPrijave>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__StatusPr__3214EC27C7C93E3C");

            entity.ToTable("StatusPrijave");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.Naziv).HasMaxLength(50);
            entity.Property(e => e.Opis).HasMaxLength(250);
        });

        modelBuilder.Entity<Stipendije>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_Stipendija");

            entity.ToTable("Stipendije");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.Izvor).HasMaxLength(50);
            entity.Property(e => e.Kriterij).HasColumnType("numeric(18, 0)");
            entity.Property(e => e.NivoObrazovanja).HasMaxLength(50);
            entity.Property(e => e.PotrebnaDokumentacija).HasMaxLength(50);
            entity.Property(e => e.StatusId).HasColumnName("StatusID");
            entity.Property(e => e.Uslovi).HasMaxLength(200);

            entity.HasOne(d => d.IdNavigation).WithOne(p => p.Stipendije)
                .HasForeignKey<Stipendije>(d => d.Id)
                .HasConstraintName("FK_Stipendija_Oglas_ID");

            entity.HasOne(d => d.Status).WithMany(p => p.Stipendijes)
                .HasForeignKey(d => d.StatusId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Stipendije_StatusOglasi");
        });

        modelBuilder.Entity<Stipenditori>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_Stipenditor");

            entity.ToTable("Stipenditori");

            entity.HasIndex(e => e.GradId, "IX_Stipenditor_GradID");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Adresa).HasMaxLength(50);
            entity.Property(e => e.Email).HasMaxLength(50);
            entity.Property(e => e.GradId).HasColumnName("GradID");
            entity.Property(e => e.Link).HasMaxLength(50);
            entity.Property(e => e.Naziv).HasMaxLength(50);
            entity.Property(e => e.TipUstanove).HasMaxLength(50);

            entity.HasOne(d => d.Grad).WithMany(p => p.Stipenditoris)
                .HasForeignKey(d => d.GradId)
                .HasConstraintName("FK_Stipenditor_Grad_GradID");
        });

        modelBuilder.Entity<Studenti>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_Student");

            entity.ToTable("Studenti");

            entity.HasIndex(e => e.FakultetId, "IX_Student_FakultetID");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.BrojIndeksa).HasMaxLength(50);
            entity.Property(e => e.FakultetId).HasColumnName("FakultetID");
            entity.Property(e => e.NacinStudiranjaId).HasColumnName("NacinStudiranjaID");
            entity.Property(e => e.ProsjecnaOcjena).HasColumnType("decimal(4, 2)");
            entity.Property(e => e.SmjerId).HasColumnName("SmjerID");

            entity.HasOne(d => d.Fakultet).WithMany(p => p.Studentis)
                .HasForeignKey(d => d.FakultetId)
                .HasConstraintName("FK_Student_Fakultet_FakultetID");

            entity.HasOne(d => d.IdNavigation).WithOne(p => p.Studenti)
                .HasForeignKey<Studenti>(d => d.Id)
                .HasConstraintName("FK_Student_Korisnik_ID");

            entity.HasOne(d => d.NacinStudiranja).WithMany(p => p.Studentis)
                .HasForeignKey(d => d.NacinStudiranjaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Studenti_NacinStudiranja");

            entity.HasOne(d => d.Smjer).WithMany(p => p.Studentis)
                .HasForeignKey(d => d.SmjerId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Studenti_Smjerovi");
        });

        modelBuilder.Entity<Uloge>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Uloge__3214EC27140192D2");

            entity.ToTable("Uloge");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.Naziv).HasMaxLength(50);
            entity.Property(e => e.Opis).HasMaxLength(250);
        });

        modelBuilder.Entity<Univerziteti>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_Univerzitet");

            entity.ToTable("Univerziteti");

            entity.HasIndex(e => e.GradId, "IX_Univerzitet_GradID");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Email).HasMaxLength(50);
            entity.Property(e => e.GradId).HasColumnName("GradID");
            entity.Property(e => e.Link).HasMaxLength(50);
            entity.Property(e => e.Logo).HasMaxLength(50);
            entity.Property(e => e.Naziv).HasMaxLength(50);
            entity.Property(e => e.Slika).HasMaxLength(50);
            entity.Property(e => e.Telefon).HasMaxLength(50);

            entity.HasOne(d => d.Grad).WithMany(p => p.Univerzitetis)
                .HasForeignKey(d => d.GradId)
                .HasConstraintName("FK_Univerzitet_Grad_GradID");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
