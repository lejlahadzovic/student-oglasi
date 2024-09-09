using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model;

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

    public virtual DbSet<Like> Likes { get; set; }

    public virtual DbSet<NacinStudiranja> NacinStudiranjas { get; set; }

    public virtual DbSet<Obavijesti> Obavijestis { get; set; }

    public virtual DbSet<Objave> Objaves { get; set; }

    public virtual DbSet<Ocjene> Ocjenes { get; set; }

    public virtual DbSet<Oglasi> Oglasis { get; set; }

    public virtual DbSet<Organizacije> Organizacijes { get; set; }

    public virtual DbSet<Prakse> Prakses { get; set; }

    public virtual DbSet<PrijavePraksa> PrijavePraksas { get; set; }

    public virtual DbSet<PrijaveStipendija> PrijaveStipendijas { get; set; }

    public virtual DbSet<Rezervacije> Rezervacijes { get; set; }

    public virtual DbSet<Slike> Slikes { get; set; }

    public virtual DbSet<Smjerovi> Smjerovis { get; set; }

    public virtual DbSet<SmjeroviFakulteti> SmjeroviFakultetis { get; set; }

    public virtual DbSet<Smjestaji> Smjestajis { get; set; }

    public virtual DbSet<SmjestajnaJedinica> SmjestajnaJedinicas { get; set; }

    public virtual DbSet<StatusOglasi> StatusOglasis { get; set; }

    public virtual DbSet<StatusPrijave> StatusPrijaves { get; set; }

    public virtual DbSet<Stipendije> Stipendijes { get; set; }

    public virtual DbSet<Stipenditori> Stipenditoris { get; set; }

    public virtual DbSet<Studenti> Studentis { get; set; }

    public virtual DbSet<TipSmjestaja> TipSmjestajas { get; set; }

    public virtual DbSet<Uloge> Uloges { get; set; }

    public virtual DbSet<Univerziteti> Univerzitetis { get; set; }

protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        if (!optionsBuilder.IsConfigured)
        {
            optionsBuilder.UseSqlServer("Data Source=localhost, 1433;Initial Catalog=200062_200090;User=sa;Password=QWElkj132!;TrustServerCertificate=True");
        }
    }
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Fakulteti>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_Fakultet");

            entity.ToTable("Fakulteti");

            entity.HasIndex(e => e.UniverzitetId, "IX_Fakultet_UniverzitetID");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Adresa).HasMaxLength(200);
            entity.Property(e => e.Email).HasMaxLength(50);
            entity.Property(e => e.Link).HasMaxLength(100);
            entity.Property(e => e.Logo).HasMaxLength(100);
            entity.Property(e => e.Naziv).HasMaxLength(200);
            entity.Property(e => e.Skracenica).HasMaxLength(10);
            entity.Property(e => e.Slika).HasMaxLength(100);
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
            entity.Property(e => e.Opis).HasMaxLength(500);
        });

        modelBuilder.Entity<Komentari>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Komentar__3214EC073529E1CC");

            entity.ToTable("Komentari");

            entity.HasIndex(e => e.KorisnikId, "IX_Komentar_KorisnikID");

            entity.HasIndex(e => e.ParentKomentarId, "IX_Komentar_ParentKomentarId");

            entity.HasIndex(e => e.PostId, "IX_Komentar_PostID");

            entity.Property(e => e.PostType)
                .HasMaxLength(50)
                .HasDefaultValue("");
            entity.Property(e => e.Text).HasMaxLength(3000);
            entity.Property(e => e.VrijemeObjave).HasColumnType("datetime");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Komentaris)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Komentar_Korisnik");

            entity.HasOne(d => d.ParentKomentar).WithMany(p => p.InverseParentKomentar)
                .HasForeignKey(d => d.ParentKomentarId)
                .HasConstraintName("FK_Komentar_ParentComment");
        });

        modelBuilder.Entity<Korisnici>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_Korisnik");

            entity.ToTable("Korisnici");

            entity.HasIndex(e => e.UlogaId, "IX_Korisnici_UlogaID");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.BrojTelefona).HasMaxLength(50);
            entity.Property(e => e.Email).HasMaxLength(50);
            entity.Property(e => e.Ime).HasMaxLength(50);
            entity.Property(e => e.KorisnickoIme).HasMaxLength(50);
            entity.Property(e => e.LozinkaHash).HasMaxLength(50);
            entity.Property(e => e.LozinkaSalt).HasMaxLength(50);
            entity.Property(e => e.Prezime).HasMaxLength(50);
            entity.Property(e => e.Slika).HasMaxLength(100);
            entity.Property(e => e.UlogaId).HasColumnName("UlogaID");

            entity.HasOne(d => d.Uloga).WithMany(p => p.Korisnicis)
                .HasForeignKey(d => d.UlogaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Korisnici_Uloge");
        });

        modelBuilder.Entity<Like>(entity =>
        {
            entity.ToTable("Like");

            entity.HasIndex(e => e.KorisnikId, "IX_Like_KorisnikID");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.ItemId).HasColumnName("ItemID");
            entity.Property(e => e.ItemType).HasMaxLength(100);
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Likes)
                .HasForeignKey(d => d.KorisnikId)
                .HasConstraintName("FK_Like_Korisnik_KorisnikID");
        });

        modelBuilder.Entity<NacinStudiranja>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__NacinStu__3214EC27E3E6A60C");

            entity.ToTable("NacinStudiranja");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.Naziv).HasMaxLength(100);
        });

        modelBuilder.Entity<Obavijesti>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Obavijes__3214EC0753F85485");

            entity.ToTable("Obavijesti");

            entity.HasIndex(e => e.OglasiId, "IX_Obavijesti_OglasiId");

            entity.HasIndex(e => e.SmjestajiId, "IX_Obavijesti_SmjestajiId");

            entity.Property(e => e.DatumKreiranja)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Naziv).HasMaxLength(255);

            entity.HasOne(d => d.Oglasi).WithMany(p => p.Obavijestis)
                .HasForeignKey(d => d.OglasiId)
                .HasConstraintName("FK_Obavijesti_Oglasi");

            entity.HasOne(d => d.Smjestaji).WithMany(p => p.Obavijestis)
                .HasForeignKey(d => d.SmjestajiId)
                .HasConstraintName("FK_Obavijesti_Smjestaji");
        });

        modelBuilder.Entity<Objave>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_Objava");

            entity.ToTable("Objave");

            entity.HasIndex(e => e.KategorijaId, "IX_Objava_KategorijaID");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.KategorijaId).HasColumnName("KategorijaID");
            entity.Property(e => e.Naslov).HasMaxLength(200);
            entity.Property(e => e.Slika).HasMaxLength(100);

            entity.HasOne(d => d.Kategorija).WithMany(p => p.Objaves)
                .HasForeignKey(d => d.KategorijaId)
                .HasConstraintName("FK_Objava_Kategorija_KategorijaID");
        });

        modelBuilder.Entity<Ocjene>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Ocjene__3214EC27B212595A");

            entity.ToTable("Ocjene");

            entity.HasIndex(e => e.StudentId, "IX_Ocjene_StudentId");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Ocjena).HasColumnType("decimal(3, 2)");
            entity.Property(e => e.PostType)
                .HasMaxLength(50)
                .HasDefaultValue("");

            entity.HasOne(d => d.Student).WithMany(p => p.Ocjenes)
                .HasForeignKey(d => d.StudentId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Ocjene__StudentI__339FAB6E");
        });

        modelBuilder.Entity<Oglasi>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_Oglas");

            entity.ToTable("Oglasi");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Naslov).HasMaxLength(200);
            entity.Property(e => e.Slika).HasMaxLength(100);
        });

        modelBuilder.Entity<Organizacije>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_Firma");

            entity.ToTable("Organizacije");

            entity.HasIndex(e => e.GradId, "IX_Firma_GradID");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Adresa).HasMaxLength(200);
            entity.Property(e => e.Email).HasMaxLength(50);
            entity.Property(e => e.GradId).HasColumnName("GradID");
            entity.Property(e => e.Link).HasMaxLength(50);
            entity.Property(e => e.Naziv).HasMaxLength(200);
            entity.Property(e => e.Telefon).HasMaxLength(50);

            entity.HasOne(d => d.Grad).WithMany(p => p.Organizacijes)
                .HasForeignKey(d => d.GradId)
                .HasConstraintName("FK_Firma_Grad_GradID");
        });

        modelBuilder.Entity<Prakse>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_Praksa");

            entity.ToTable("Prakse");

            entity.HasIndex(e => e.OrganizacijaId, "IX_Prakse_OrganizacijaID");

            entity.HasIndex(e => e.StatusId, "IX_Prakse_StatusID");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.Benefiti).HasMaxLength(3000);
            entity.Property(e => e.Kvalifikacije).HasMaxLength(3000);
            entity.Property(e => e.OrganizacijaId).HasColumnName("OrganizacijaID");
            entity.Property(e => e.StatusId).HasColumnName("StatusID");

            entity.HasOne(d => d.IdNavigation).WithOne(p => p.Prakse)
                .HasForeignKey<Prakse>(d => d.Id)
                .HasConstraintName("FK_Praksa_Oglas_ID");

            entity.HasOne(d => d.Organizacija).WithMany(p => p.Prakses)
                .HasForeignKey(d => d.OrganizacijaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Prakse_Organizacija");

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

            entity.HasIndex(e => e.StatusId, "IX_PrijavePraksa_StatusID");

            entity.Property(e => e.Certifikati).HasMaxLength(100);
            entity.Property(e => e.Cv)
                .HasMaxLength(100)
                .HasColumnName("CV");
            entity.Property(e => e.PropratnoPismo).HasMaxLength(100);
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

            entity.HasIndex(e => e.StatusId, "IX_PrijaveStipendija_StatusID");

            entity.Property(e => e.StipendijaId).HasColumnName("StipendijaID");
            entity.Property(e => e.Cv)
                .HasMaxLength(100)
                .HasColumnName("CV");
            entity.Property(e => e.Dokumentacija).HasMaxLength(100);
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
            entity.HasKey(e => e.Id).HasName("PK__Rezervac__CABA44DDB20D5066");

            entity.ToTable("Rezervacije");

            entity.HasIndex(e => e.SmjestajnaJedinicaId, "IX_Rezervacije_SmjestajnaJedinicaId");

            entity.HasIndex(e => e.StatusId, "IX_Rezervacije_StatusId");

            entity.HasIndex(e => e.StudentId, "IX_Rezervacije_StudentId");

            entity.Property(e => e.Cijena).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.DatumOdjave).HasColumnType("datetime");
            entity.Property(e => e.DatumPrijave).HasColumnType("datetime");

            entity.HasOne(d => d.SmjestajnaJedinica).WithMany(p => p.Rezervacijes)
                .HasForeignKey(d => d.SmjestajnaJedinicaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Rezervaci__Smjes__3D2915A8");

            entity.HasOne(d => d.Status).WithMany(p => p.Rezervacijes)
                .HasForeignKey(d => d.StatusId)
                .HasConstraintName("FK__Rezervaci__Statu__3E1D39E1");

            entity.HasOne(d => d.Student).WithMany(p => p.Rezervacijes)
                .HasForeignKey(d => d.StudentId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Rezervaci__Stude__3C34F16F");
        });

        modelBuilder.Entity<Slike>(entity =>
        {
            entity.HasKey(e => e.SlikaId).HasName("PK__Slike__FFAE2D46D39CF4CB");

            entity.ToTable("Slike");

            entity.HasIndex(e => e.SmjestajId, "IX_Slike_SmjestajID");

            entity.HasIndex(e => e.SmjestajnaJedinicaId, "IX_Slike_SmjestajnaJedinicaID");

            entity.Property(e => e.SlikaId).HasColumnName("SlikaID");
            entity.Property(e => e.Naziv).HasMaxLength(255);
            entity.Property(e => e.SmjestajId).HasColumnName("SmjestajID");
            entity.Property(e => e.SmjestajnaJedinicaId).HasColumnName("SmjestajnaJedinicaID");

            entity.HasOne(d => d.Smjestaj).WithMany(p => p.Slikes)
                .HasForeignKey(d => d.SmjestajId)
                .HasConstraintName("FK_Slike_Smjestaji");

            entity.HasOne(d => d.SmjestajnaJedinica).WithMany(p => p.Slikes)
                .HasForeignKey(d => d.SmjestajnaJedinicaId)
                .HasConstraintName("FK_Slike_SmjestajnaJedinica");
        });

        modelBuilder.Entity<Smjerovi>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Smjerovi__3214EC273399A25C");

            entity.ToTable("Smjerovi");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.Naziv).HasMaxLength(50);
        });

        modelBuilder.Entity<SmjeroviFakulteti>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Smjerovi__3214EC275C1E8183");

            entity.ToTable("SmjeroviFakulteti");

            entity.HasIndex(e => e.FakultetId, "IX_SmjeroviFakulteti_FakultetID");

            entity.HasIndex(e => e.SmjerId, "IX_SmjeroviFakulteti_SmjerID");

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
            entity.HasKey(e => e.Id).HasName("PK__Smjestaj__3214EC27DA80F33F");

            entity.ToTable("Smjestaji");

            entity.HasIndex(e => e.GradId, "IX_Smjestaji_GradID");

            entity.HasIndex(e => e.TipSmjestajaId, "IX_Smjestaji_TipSmjestajaID");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Adresa).HasMaxLength(250);
            entity.Property(e => e.DodatneUsluge).HasMaxLength(3000);
            entity.Property(e => e.FitnessCentar)
                .HasDefaultValue(false)
                .HasColumnName("fitness_centar");
            entity.Property(e => e.GradId).HasColumnName("GradID");
            entity.Property(e => e.Naziv).HasMaxLength(250);
            entity.Property(e => e.Parking)
                .HasDefaultValue(false)
                .HasColumnName("parking");
            entity.Property(e => e.Restoran)
                .HasDefaultValue(false)
                .HasColumnName("restoran");
            entity.Property(e => e.TipSmjestajaId).HasColumnName("TipSmjestajaID");
            entity.Property(e => e.UslugePrijevoza)
                .HasDefaultValue(false)
                .HasColumnName("usluge_prijevoza");
            entity.Property(e => e.WiFi)
                .HasDefaultValue(false)
                .HasColumnName("wi_fi");

            entity.HasOne(d => d.Grad).WithMany(p => p.Smjestajis)
                .HasForeignKey(d => d.GradId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Smjestaji__GradI__2180FB33");

            entity.HasOne(d => d.TipSmjestaja).WithMany(p => p.Smjestajis)
                .HasForeignKey(d => d.TipSmjestajaId)
                .HasConstraintName("FK__Smjestaji__TipSm__40F9A68C");
        });

        modelBuilder.Entity<SmjestajnaJedinica>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Smjestaj__3214EC276AF062E5");

            entity.ToTable("SmjestajnaJedinica");

            entity.HasIndex(e => e.SmjestajId, "IX_SmjestajnaJedinica_SmjestajID");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Cijena).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.Naziv).HasMaxLength(255);
            entity.Property(e => e.SmjestajId).HasColumnName("SmjestajID");

            entity.HasOne(d => d.Smjestaj).WithMany(p => p.SmjestajnaJedinicas)
                .HasForeignKey(d => d.SmjestajId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Smjestajn__Smjes__4F47C5E3");
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
        });

        modelBuilder.Entity<Stipendije>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_Stipendija");

            entity.ToTable("Stipendije");

            entity.HasIndex(e => e.StatusId, "IX_Stipendije_StatusID");

            entity.HasIndex(e => e.StipenditorId, "IX_Stipendije_StipenditorID");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.Izvor).HasMaxLength(3000);
            entity.Property(e => e.Kriterij).HasMaxLength(2000);
            entity.Property(e => e.NivoObrazovanja).HasMaxLength(3000);
            entity.Property(e => e.PotrebnaDokumentacija).HasMaxLength(3000);
            entity.Property(e => e.StatusId).HasColumnName("StatusID");
            entity.Property(e => e.StipenditorId).HasColumnName("StipenditorID");

            entity.HasOne(d => d.IdNavigation).WithOne(p => p.Stipendije)
                .HasForeignKey<Stipendije>(d => d.Id)
                .HasConstraintName("FK_Stipendija_Oglas_ID");

            entity.HasOne(d => d.Status).WithMany(p => p.Stipendijes)
                .HasForeignKey(d => d.StatusId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Stipendije_StatusOglasi");

            entity.HasOne(d => d.Stipenditor).WithMany(p => p.Stipendijes)
                .HasForeignKey(d => d.StipenditorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Stipendije_Stipenditor");
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
            entity.Property(e => e.Naziv).HasMaxLength(200);
            entity.Property(e => e.TipUstanove).HasMaxLength(200);

            entity.HasOne(d => d.Grad).WithMany(p => p.Stipenditoris)
                .HasForeignKey(d => d.GradId)
                .HasConstraintName("FK_Stipenditor_Grad_GradID");
        });

        modelBuilder.Entity<Studenti>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_Student");

            entity.ToTable("Studenti");

            entity.HasIndex(e => e.FakultetId, "IX_Student_FakultetID");

            entity.HasIndex(e => e.NacinStudiranjaId, "IX_Studenti_NacinStudiranjaID");

            entity.HasIndex(e => e.SmjerId, "IX_Studenti_SmjerID");

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

        modelBuilder.Entity<TipSmjestaja>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__TipSmjes__3214EC27E9E84D99");

            entity.ToTable("TipSmjestaja");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Naziv)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Opis)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Uloge>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Uloge__3214EC27140192D2");

            entity.ToTable("Uloge");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.Naziv).HasMaxLength(200);
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
            entity.Property(e => e.Naziv).HasMaxLength(200);
            entity.Property(e => e.Skracenica).HasMaxLength(10);
            entity.Property(e => e.Slika).HasMaxLength(50);
            entity.Property(e => e.Telefon).HasMaxLength(50);

            entity.HasOne(d => d.Grad).WithMany(p => p.Univerzitetis)
                .HasForeignKey(d => d.GradId)
                .HasConstraintName("FK_Univerzitet_Grad_GradID");
        });

        modelBuilder.Entity<Grad>().HasData(
            new Grad { Id = 1, Naziv = "Banja Luka" },
            new Grad { Id = 2, Naziv = "Bihać" },
            new Grad { Id = 3, Naziv = "Goražde" },
            new Grad { Id = 4, Naziv = "Jablanica" },
            new Grad { Id = 5, Naziv = "Konjic" },
            new Grad { Id = 6, Naziv = "Mostar" },
            new Grad { Id = 7, Naziv = "Sarajevo" },
            new Grad { Id = 8, Naziv = "Tuzla" },
            new Grad { Id = 9, Naziv = "Zenica" }
        );

        modelBuilder.Entity<Kategorija>().HasData(
            new Kategorija { Id = 1, Naziv = "Edukacija", Opis = null },
            new Kategorija { Id = 2, Naziv = "Ponude i popusti", Opis = null },
            new Kategorija { Id = 3, Naziv = "Aktivnosti i događaji", Opis = null },
            new Kategorija { Id = 4, Naziv = "Tehnologija", Opis = null }
            );

        modelBuilder.Entity<NacinStudiranja>().HasData(
            new NacinStudiranja { Id = 1, Naziv = "Redovno", Opis = null },
            new NacinStudiranja { Id = 2, Naziv = "Vanredno", Opis = null },
            new NacinStudiranja { Id = 3, Naziv = "DL", Opis = "Distance learning" }
            );

        modelBuilder.Entity<Oglasi>().HasData(
            new Oglasi
            {
                Id = 1,
                Naslov = "Računovodstvo u praksi",
                RokPrijave = new DateTime(2024, 6, 30),
                Opis = "Ova praksa omogućava sticanje praktičnog iskustva u vođenju knjiga, pripremi financijskih izvještaja, obračunu plata i poreza, te primjeni računovodstvenih standarda.",
                VrijemeObjave = new DateTime(2024, 6, 1),
                Slika = "internship1.png"
            },
            new Oglasi
            {
                Id = 2,
                Naslov = "Praksa u marketingu za studente završnih godina",
                RokPrijave = new DateTime(2024, 7, 15),
                Opis = "Pridružite se našem dinamičnom marketing timu i steknite dragoceno iskustvo! Nudimo plaćenu praksu za studente završnih godina ekonomskih i menadžment fakulteta. Tokom prakse, radit ćete na stvarnim projektima, učiti od iskusnih profesionalaca i razvijati svoje veštine. Prijave su otvorene do kraja meseca. Ne propustite priliku!",
                VrijemeObjave = new DateTime(2024, 6, 1),
                Slika = "internship2.png"
            },
            new Oglasi
            {
                Id = 3,
                Naslov = "Erasmus+ stipendije za zimski semestar na Univerzitetu u Ljubljani",
                RokPrijave = new DateTime(2024, 8, 1),
                Opis = "Ured za međunarodnu saradnju Univerziteta u Zenici objavljuje Konkurs za prijavu studenata za razmjenu u zimskom semestru 2024/25. godine u okviru Erasmus+ programa za Univerzitet u Ljubljani, Slovenija.",
                VrijemeObjave = new DateTime(2024, 6, 1),
                Slika = "scholarship1.jpg"
            },
            new Oglasi
            {
                Id = 4,
                Naslov = "Stipendiranje učenika i studenata za 2023/2024. godinu",
                RokPrijave = new DateTime(2024, 8, 1),
                Opis = "Sa zadovoljstvom objavljujemo konkurs za stipendiranje talentovanih učenika i studenata za školsku 2023/2024. godinu. Ova stipendija je namenjena učenicima srednjih škola i studentima svih nivoa studija koji pokazuju izvrsne akademske rezultate, posvećenost i želju za daljim obrazovanjem.",
                VrijemeObjave = new DateTime(2024, 6, 1),
                Slika = "scholarship1.jpg"
            },
            new Oglasi
            {
                Id = 5,
                Naslov = "Praksa u IT sektoru - Software Development",
                RokPrijave = new DateTime(2024, 7, 20),
                Opis = "Pridružite se našem IT timu i učestvujte u razvoju softverskih rješenja! Ova praksa nudi priliku za rad na stvarnim projektima, upoznavanje sa najsavremenijim tehnologijama i proširivanje vaših vještina u programiranju.",
                VrijemeObjave = new DateTime(2024, 6, 5),
                Slika = "internship3.png"
            },
            new Oglasi
            {
                Id = 6,
                Naslov = "Praksa u oblasti ljudskih resursa",
                RokPrijave = new DateTime(2024, 7, 25),
                Opis = "Ova praksa vam omogućava sticanje praktičnog iskustva u regrutaciji, upravljanju talentima i organizaciji zaposlenih. Idealna prilika za studente koji žele karijeru u HR sektoru.",
                VrijemeObjave = new DateTime(2024, 6, 10),
                Slika = "internship4.png"
            },
            new Oglasi
            {
                Id = 7,
                Naslov = "Praksa u finansijama",
                RokPrijave = new DateTime(2024, 7, 30),
                Opis = "Praksa u našem financijskom timu nudi priliku za rad na analizi financijskih podataka, planiranju budžeta i pripremi izvještaja. Idealan početak za one koji žele karijeru u financijama.",
                VrijemeObjave = new DateTime(2024, 6, 15),
                Slika = "internship5.png"
            },
            new Oglasi
            {
                Id = 8,
                Naslov = "Praksa u dizajnu",
                RokPrijave = new DateTime(2024, 8, 5),
                Opis = "Ako volite kreativni rad, ova praksa vam nudi priliku da radite sa našim dizajnerskim timom na stvaranju vizuelnih rješenja za digitalne i štampane medije.",
                VrijemeObjave = new DateTime(2024, 6, 20),
                Slika = "internship1.png"
            },
            new Oglasi
            {
                Id = 9,
                Naslov = "Praksa u turizmu i hotelijerstvu",
                RokPrijave = new DateTime(2024, 8, 10),
                Opis = "Steknite iskustvo u radu sa gostima i organizaciji turističkih aranžmana. Ova praksa je savršena za studente turizma i ugostiteljstva.",
                VrijemeObjave = new DateTime(2024, 6, 25),
                Slika = "internship2.png"
            },
            new Oglasi
            {
                Id = 10,
                Naslov = "Stipendije za master studije u inostranstvu",
                RokPrijave = new DateTime(2024, 8, 20),
                Opis = "Ova stipendija pokriva troškove školarine i života za master studije u inostranstvu. Idealna prilika za studente koji žele nastaviti obrazovanje na prestižnim univerzitetima.",
                VrijemeObjave = new DateTime(2024, 6, 1),
                Slika = "scholarship2.jpg"
            },
            new Oglasi
            {
                Id = 11,
                Naslov = "Stipendije za studente tehničkih nauka",
                RokPrijave = new DateTime(2024, 8, 25),
                Opis = "Stipendije namijenjene studentima tehničkih fakulteta koji pokazuju izuzetne rezultate u studiranju i želju za usavršavanjem u oblasti tehničkih nauka.",
                VrijemeObjave = new DateTime(2024, 6, 5),
                Slika = "scholarship3.jpg"
            },
            new Oglasi
            {
                Id = 12,
                Naslov = "Stipendije za socijalno ugrožene studente",
                RokPrijave = new DateTime(2024, 9, 1),
                Opis = "Ova stipendija namijenjena je studentima iz socijalno ugroženih porodica, sa ciljem da im se pruži podrška u nastavku obrazovanja.",
                VrijemeObjave = new DateTime(2024, 6, 10),
                Slika = "scholarship4.jpg"
            },
            new Oglasi
            {
                Id = 13,
                Naslov = "Stipendije za istraživačke projekte",
                RokPrijave = new DateTime(2024, 9, 10),
                Opis = "Stipendije za studente koji rade na inovativnim istraživačkim projektima u oblasti prirodnih nauka. Prilika za finansijsku podršku i dalji razvoj istraživačkog rada.",
                VrijemeObjave = new DateTime(2024, 6, 15),
                Slika = "scholarship5.jpg"
            },
            new Oglasi
            {
                Id = 14,
                Naslov = "Erasmus+ stipendije za studente na razmjeni",
                RokPrijave = new DateTime(2024, 9, 15),
                Opis = "Prilika za studente koji žele studirati jedan semestar u inostranstvu kroz Erasmus+ program. Stipendija pokriva troškove puta, smještaja i školarine.",
                VrijemeObjave = new DateTime(2024, 6, 20),
                Slika = "scholarship1.jpg"
            }
            );

        modelBuilder.Entity<Smjerovi>().HasData(
            new Smjerovi { Id = 1, Naziv = "Softverski inženjering", Opis = null },
            new Smjerovi { Id = 2, Naziv = "Razvoj softvera", Opis = null },
            new Smjerovi { Id = 3, Naziv = "Mašinstvo", Opis = null },
            new Smjerovi { Id = 4, Naziv = "Računarstvo i informatika", Opis = null },
            new Smjerovi { Id = 5, Naziv = "Klinicka medicina", Opis = "Studij koji se fokusira na kliničke aspekte medicine." }
            );

        modelBuilder.Entity<StatusOglasi>().HasData(
            new StatusOglasi { Id = 1, Naziv = "Initial", Opis = null },
            new StatusOglasi { Id = 2, Naziv = "Draft", Opis = null },
            new StatusOglasi { Id = 3, Naziv = "Aktivan", Opis = null },
            new StatusOglasi { Id = 4, Naziv = "Update", Opis = null }
        );

        modelBuilder.Entity<StatusPrijave>().HasData(
            new StatusPrijave { Id = 1, Naziv = "Initial", Opis = null },
            new StatusPrijave { Id = 2, Naziv = "Na cekanju", Opis = null },
            new StatusPrijave { Id = 3, Naziv = "Odobrena", Opis = null },
            new StatusPrijave { Id = 4, Naziv = "Otkazana", Opis = null }
        );

        modelBuilder.Entity<TipSmjestaja>().HasData(
            new TipSmjestaja { Id = 1, Naziv = "Hotel", Opis = null },
            new TipSmjestaja { Id = 2, Naziv = "Apartman", Opis = null }
        );

        modelBuilder.Entity<Uloge>().HasData(
            new Uloge { Id = 1, Naziv = "Administrator", Opis = null },
            new Uloge { Id = 2, Naziv = "Student", Opis = null }
        );

        modelBuilder.Entity<Organizacije>().HasData(
            new Organizacije { Id = 1, Naziv = "IT Hub Sarajevo", Telefon = "033-987-654", Email = "contact@ithubsarajevo.com", Adresa = "Maršala Tita 5, Sarajevo", Link = "www.ithubsarajevo.com", GradId = 7 },
            new Organizacije { Id = 2, Naziv = "Marketing Solutions Mostar", Telefon = "036-456-789", Email = "support@msmostar.com", Adresa = "Stjepana Radića 10, Mostar", Link = "www.msmostar.com", GradId = 6 },
            new Organizacije { Id = 3, Naziv = "FinConsult Sarajevo", Telefon = "033-123-456", Email = "info@finconsult.ba", Adresa = "Maršala Tita 15, Sarajevo", Link = "www.finconsult.ba", GradId = 7 },
            new Organizacije { Id = 4, Naziv = "DigitalMarketing", Telefon = "036-234-567", Email = "contact@dmmostar.com", Adresa = "Kralja Tomislava 22, Mostar", Link = "www.dmmostar.com", GradId = 6 },
            new Organizacije { Id = 5, Naziv = "TechHub Tuzla", Telefon = "035-567-890", Email = "support@techhubtuzla.com", Adresa = "Šetalište Slana Banja 7, Tuzla", Link = "www.techhubtuzla.com", GradId = 8 },
            new Organizacije { Id = 6, Naziv = "HR Solutions Zenica", Telefon = "032-345-678", Email = "info@hrsolutionszenica.com", Adresa = "Titova 21, Zenica", Link = "www.hrsolutionszenica.com", GradId = 9 },
            new Organizacije { Id = 7, Naziv = "Finance Experts", Telefon = "033-987-654", Email = "contact@financexperts.ba", Adresa = "Zmaja od Bosne 45, Sarajevo", Link = "www.financexperts.ba", GradId = 7 },
            new Organizacije { Id = 8, Naziv = "Creative Design Studio", Telefon = "051-456-789", Email = "info@creativedesignbl.com", Adresa = "Kralja Petra I Karađorđevića 10, Banja Luka", Link = "www.creativedesignbl.com", GradId = 1 },
            new Organizacije { Id = 9, Naziv = "Tourism Solutions", Telefon = "037-123-456", Email = "contact@tourismsolutionsbihac.com", Adresa = "Zeleni Val 3, Bihać", Link = "www.tourismsolutionsbihac.com", GradId = 2 }
            );


        modelBuilder.Entity<Stipenditori>().HasData(
            new Stipenditori { Id = 1, Naziv = "Erasmus+ Program", Adresa = "Sarajevo, Bosna i Hercegovina", Email = "erasmus@ec.europa.eu", Link = "www.erasmusplus.com", TipUstanove = "Program", GradId = 7 },
            new Stipenditori { Id = 2, Naziv = "Fondacija za obrazovanje", Adresa = "Banja Luka, Bosna i Hercegovina", Email = "info@fondacijaobrazovanja.ba", Link = "www.fondacijaobrazovanja.ba", TipUstanove = "Fondacija", GradId = 1 },
            new Stipenditori { Id = 3, Naziv = "Stipendije za istraživačke projekte Tuzla", Adresa = "Tuzla, Bosna i Hercegovina", Email = "kontakt@istrazivackeprojekt.com", Link = "www.istrazivackeprojekt.com", TipUstanove = "Organizacija", GradId = 8 }
        );

        modelBuilder.Entity<Univerziteti>().HasData(
            new Univerziteti { Id = 1, Naziv = "Univerzitet u Sarajevu", Skracenica = "UNSA", Email = "info@unsa.ba", Telefon = "033-123-456", Logo = null, Slika = null, Link = "www.unsa.ba", GradId = 7 },
            new Univerziteti { Id = 2, Naziv = "Univerzitet \"Džemal Bijedić\"", Skracenica = "UNMO", Email = "info@unmo.ba", Telefon = "036-123-456", Logo = null, Slika = null, Link = "www.unmo.ba", GradId = 6 },
            new Univerziteti { Id = 3, Naziv = "Univerzitet u Tuzli", Skracenica = "UNTZ", Email = "info@untz.ba", Telefon = "035-123-456", Logo = null, Slika = null, Link = "www.untz.ba", GradId = 8 }
        );

        modelBuilder.Entity<Objave>().HasData(
            new Objave { Id = 1, Naslov = "Novi kurs programiranja", Sadrzaj = "Prijavite se za novi kurs programiranja koji počinje uskoro.", VrijemeObjave = new DateTime(2024, 6, 5), Slika = "student.jpg", KategorijaId = 2 },
            new Objave { Id = 2, Naslov = "Poziv za volontiranje", Sadrzaj = "Pridružite se našem timu volontera i steknite dragocjeno iskustvo.", VrijemeObjave = new DateTime(2024, 6, 6), Slika = "students.png", KategorijaId = 3 },
            new Objave { Id = 3, Naslov = "Takmičenje u inovacijama", Sadrzaj = "Učestvujte u takmičenju u inovacijama i osvojite vrijedne nagrade.", VrijemeObjave = new DateTime(2024, 6, 7), Slika = "studentlife.png", KategorijaId = 4 }
            );

        modelBuilder.Entity<Smjestaji>().HasData(
            new Smjestaji { Id = 1, Naziv = "Hotel Sarajevo", Adresa = "Adresa 1", Opis = "Moderan hotel u srcu Sarajeva, nudi savremene sobe, restoran i wellness centar. Idealno za poslovne i turističke posjete.", GradId = 7, DodatneUsluge = null, TipSmjestajaId = 1, WiFi = true, Parking = true, FitnessCentar = true, Restoran = true, UslugePrijevoza = true },
            new Smjestaji { Id = 2, Naziv = "Apartman Mostar", Adresa = "Adresa 3", Opis = "Opis apartmana u Mostaru", GradId = 6, DodatneUsluge = null, TipSmjestajaId = 2, WiFi = true, Parking = false, FitnessCentar = false, Restoran = false, UslugePrijevoza = false },
            new Smjestaji { Id = 3, Naziv = "Apartman Green", Adresa = "Adresa 4", Opis = "Komforan apartman sa velikom terasom.", GradId = 2, DodatneUsluge = null, TipSmjestajaId = 2, WiFi = true, Parking = false, FitnessCentar = false, Restoran = false, UslugePrijevoza = false },
            new Smjestaji { Id = 4, Naziv = "Villa Luxury", Adresa = "Adresa 5", Opis = "Ekskluzivna vila sa bazenom i luksuznim sadržajima.", GradId = 5, DodatneUsluge = "Bazen, sauna", TipSmjestajaId = 1, WiFi = true, Parking = true, FitnessCentar = true, Restoran = false, UslugePrijevoza = true },
            new Smjestaji { Id = 5, Naziv = "Hotel Lux", Adresa = "Adresa 5", Opis = "Ekskluzivni hotel sa luksuznim sadržajima i uslugama.", GradId = 9, DodatneUsluge = "Spa, bazen, sauna", TipSmjestajaId = 1, WiFi = true, Parking = true, FitnessCentar = true, Restoran = true, UslugePrijevoza = true }
            );

        modelBuilder.Entity<Korisnici>().HasData(
            new Korisnici
            {
                Id = 1,
                Ime = "Kemal",
                Prezime = "Hajdarpasic",
                KorisnickoIme = "admin",
                Email = "kh@example.com",
                LozinkaHash = "JfJzsL3ngGWki+Dn67C+8WLy73I=",
                LozinkaSalt = "7TUJfmgkkDvcY3PB/M4fhg==",
                UlogaId = 1
            },
            new Korisnici
            {
                Id = 2,
                Ime = "Lejla",
                Prezime = "Hadzovic",
                KorisnickoIme = "lejla",
                Email = "lh@example.com",
                LozinkaHash = "ug0GgEnT5hKaHsfTn1l1kiGvZAg=",
                LozinkaSalt = "qh31pfpS2ox1h96QPhmR/Q==",
                UlogaId = 2
            },
            new Korisnici
            {
                Id = 3,
                Ime = "Kemal",
                Prezime = "Hajdarpasic",
                KorisnickoIme = "kemal",
                Email = "kh@example.com",
                LozinkaHash = "ug0GgEnT5hKaHsfTn1l1kiGvZAg=",
                LozinkaSalt = "qh31pfpS2ox1h96QPhmR/Q==",
                UlogaId = 2
            },
            new Korisnici
            {
                Id = 4,
                Ime = "Amir",
                Prezime = "Bajric",
                KorisnickoIme = "amir",
                Email = "amir@example.com",
                LozinkaHash = "ug0GgEnT5hKaHsfTn1l1kiGvZAg=",
                LozinkaSalt = "qh31pfpS2ox1h96QPhmR/Q==",
                UlogaId = 2
            },
            new Korisnici
            {
                Id = 5,
                Ime = "Jasmina",
                Prezime = "Nalic",
                KorisnickoIme = "jasmina",
                Email = "jasmina@example.com",
                LozinkaHash = "ug0GgEnT5hKaHsfTn1l1kiGvZAg=",
                LozinkaSalt = "qh31pfpS2ox1h96QPhmR/Q==",
                UlogaId = 2
            },
            new Korisnici
            {
                Id = 6,
                Ime = "Nina",
                Prezime = "Milic",
                KorisnickoIme = "nina",
                Email = "nina@example.com",
                LozinkaHash = "ug0GgEnT5hKaHsfTn1l1kiGvZAg=",
                LozinkaSalt = "qh31pfpS2ox1h96QPhmR/Q==",
                UlogaId = 2
            },
            new Korisnici
            {
                Id = 7,
                Ime = "Selma",
                Prezime = "Mujagic",
                KorisnickoIme = "selma",
                Email = "sm@example.com",
                LozinkaHash = "ug0GgEnT5hKaHsfTn1l1kiGvZAg=",
                LozinkaSalt = "qh31pfpS2ox1h96QPhmR/Q==",
                UlogaId = 2
            },
            new Korisnici
            {
                Id = 8,
                Ime = "Nedim",
                Prezime = "Hodzic",
                KorisnickoIme = "nedim",
                Email = "nh@example.com",
                LozinkaHash = "ug0GgEnT5hKaHsfTn1l1kiGvZAg=",
                LozinkaSalt = "qh31pfpS2ox1h96QPhmR/Q==",
                UlogaId = 2
            },
            new Korisnici
            {
                Id = 9,
                Ime = "Jasmina",
                Prezime = "Hadziabdic",
                KorisnickoIme = "jasmina",
                Email = "jh@example.com",
                LozinkaHash = "ug0GgEnT5hKaHsfTn1l1kiGvZAg=",
                LozinkaSalt = "qh31pfpS2ox1h96QPhmR/Q==",
                UlogaId = 2
            }
            );

        modelBuilder.Entity<Prakse>().HasData(
            new Prakse
            {
                Id = 1,
                PocetakPrakse = new DateTime(2024, 7, 1),
                KrajPrakse = new DateTime(2024, 9, 1),
                Kvalifikacije = "Poznavanje rada na računaru",
                Benefiti = "Besplatan ručak",
                Placena = true,
                StatusId = 2,
                OrganizacijaId = 1
            },
            new Prakse
            {
                Id = 2,
                PocetakPrakse = new DateTime(2024, 8, 1),
                KrajPrakse = new DateTime(2024, 10, 1),
                Kvalifikacije = "Poznavanje programiranja",
                Benefiti = "Besplatan prevoz",
                Placena = false,
                StatusId = 2,
                OrganizacijaId = 2
            },
            new Prakse
            {
                Id = 5,
                PocetakPrakse = new DateTime(2024, 8, 1),
                KrajPrakse = new DateTime(2024, 10, 1),
                Kvalifikacije = "Iskustvo u programiranju",
                Benefiti = "Mentorska podrška",
                Placena = true,
                StatusId = 2,
                OrganizacijaId = 3
            },
            new Prakse
            {
                Id = 6,
                PocetakPrakse = new DateTime(2024, 9, 1),
                KrajPrakse = new DateTime(2024, 11, 1),
                Kvalifikacije = "Osnove regrutacije i upravljanja talentima",
                Benefiti = "Praktično iskustvo u HR-u",
                Placena = false,
                StatusId = 2,
                OrganizacijaId = 4
            },
            new Prakse
            {
                Id = 7,
                PocetakPrakse = new DateTime(2024, 8, 15),
                KrajPrakse = new DateTime(2024, 10, 15),
                Kvalifikacije = "Osnovno znanje financijske analize",
                Benefiti = "Mentorska podrška",
                Placena = true,
                StatusId = 2,
                OrganizacijaId = 5
            },
            new Prakse
            {
                Id = 8,
                PocetakPrakse = new DateTime(2024, 9, 1),
                KrajPrakse = new DateTime(2024, 11, 1),
                Kvalifikacije = "Osnovno znanje dizajna",
                Benefiti = "Rad u kreativnom timu",
                Placena = false,
                StatusId = 2,
                OrganizacijaId = 8  
            },

            new Prakse
            {
                Id = 9,
                PocetakPrakse = new DateTime(2024, 9, 15),
                KrajPrakse = new DateTime(2024, 11, 15),
                Kvalifikacije = "Poznavanje turizma i ugostiteljstva",
                Benefiti = "Iskustvo u radu sa gostima",
                Placena = true,
                StatusId = 2,
                OrganizacijaId = 9
            }
            );

        modelBuilder.Entity<Stipendije>().HasData(
            new Stipendije
            {
                Id = 3,
                Uslovi = "Uslov za prijavu na Erasmus+ program",
                Iznos = 1200,
                Kriterij = "Akademski uspjeh i preporuke",
                PotrebnaDokumentacija = "Motivaciono pismo, akademski transkript",
                Izvor = "Erasmus+ Program",
                NivoObrazovanja = "Studije",
                BrojStipendisata = 5,
                StatusId = 2,
                StipenditorId = 1
            },
            new Stipendije
            {
                Id = 4,
                Uslovi = "Visoki akademski rezultati",
                Iznos = 1500,
                Kriterij = "Izvrsnost u akademskom radu",
                PotrebnaDokumentacija = "Akademski transkript, preporuka profesora",
                Izvor = "Fondacija za obrazovanje",
                NivoObrazovanja = "Srednje škole i univerzitet",
                BrojStipendisata = 10,
                StatusId = 2,
                StipenditorId = 2
            },
            new Stipendije
            {
                Id = 10,
                Uslovi = "Studije u inostranstvu",
                Iznos = 2000,
                Kriterij = "Odličan akademski uspjeh",
                PotrebnaDokumentacija = "Prijava za stipendiju, akademski transkript",
                Izvor = "Stipendije za master studije",
                NivoObrazovanja = "Master studije",
                BrojStipendisata = 7,
                StatusId = 2,
                StipenditorId = 3 
            },
            new Stipendije
            {
                Id = 11,
                Uslovi = "Izuzetni rezultati u tehničkim naukama",
                Iznos = 1800,
                Kriterij = "Visoki akademski rezultati u tehničkim naukama",
                PotrebnaDokumentacija = "Akademski transkript, preporuka profesora",
                Izvor = "Stipendije za tehničke nauke",
                NivoObrazovanja = "Studije",
                BrojStipendisata = 8,
                StatusId = 2,
                StipenditorId = 1 
            },
            new Stipendije
            {
                Id = 12,
                Uslovi = "Socijalno ugroženi studenti",
                Iznos = 1200,
                Kriterij = "Dokaz o socijalnom statusu",
                PotrebnaDokumentacija = "Dokumentacija o socijalnom statusu, akademski transkript",
                Izvor = "Stipendije za socijalno ugrožene",
                NivoObrazovanja = "Studije",
                BrojStipendisata = 10,
                StatusId = 2,
                StipenditorId = 2 
            },
            new Stipendije
            {
                Id = 13,
                Uslovi = "Rad na istraživačkom projektu",
                Iznos = 1500,
                Kriterij = "Inovativni istraživački rad",
                PotrebnaDokumentacija = "Opis istraživačkog projekta, akademski transkript",
                Izvor = "Stipendije za istraživačke projekte",
                NivoObrazovanja = "Studije",
                BrojStipendisata = 5,
                StatusId = 2,
                StipenditorId = 3
            },
            new Stipendije
            {
                Id = 14,
                Uslovi = "Studije u inostranstvu kroz Erasmus+",
                Iznos = 1500,
                Kriterij = "Odličan akademski uspjeh",
                PotrebnaDokumentacija = "Motivaciono pismo, akademski transkript",
                Izvor = "Erasmus+ program",
                NivoObrazovanja = "Studije",
                BrojStipendisata = 5,
                StatusId = 2,
                StipenditorId = 1
            }
            );

        modelBuilder.Entity<Fakulteti>().HasData(
            new Fakulteti
            {
                Id = 1,
                Naziv = "Elektrotehnički fakultet",
                Skracenica = "ETF",
                Adresa = "Adresa 1",
                Email = "etf@unsa.com",
                Telefon = "123-456",
                Link = "https://www.etf.unsa.ba/",
                UniverzitetId = 1
            },
            new Fakulteti
            {
                Id = 2,
                Naziv = "Medicinski fakultet",
                Skracenica = "MF",
                Adresa = "Adresa 2",
                Email = "mf@unsa.com",
                Telefon = "123-457",
                Link = "https://www.mf.unsa.ba/",
                UniverzitetId = 1
            },
            new Fakulteti
            {
                Id = 3,
                Naziv = "Fakultet informacijskih tehnologija",
                Skracenica = "FIT",
                Adresa = "Adresa 3",
                Email = "fit@unmo.com",
                Telefon = "123-458",
                Link = "https://www.fit.ba/",
                UniverzitetId = 2
            }
            );

        modelBuilder.Entity<SmjestajnaJedinica>().HasData(
            new SmjestajnaJedinica
            {
                Id = 1,
                Naziv = "Standardna Soba",
                Cijena = 50.00m,
                Kapacitet = 2,
                Opis = "Standardna soba sa osnovnim sadržajima.",
                Kuhinja = true,
                Tv = true,
                KlimaUredjaj = true,
                Terasa = false,
                SmjestajId = 1
            },
            new SmjestajnaJedinica
            {
                Id = 2,
                Naziv = "Deluxe Soba",
                Cijena = 80.00m,
                Kapacitet = 3,
                Opis = "Deluxe soba sa dodatnim uslugama.",
                DodatneUsluge = "Uključen doručak",
                Kuhinja = true,
                Tv = true,
                KlimaUredjaj = true,
                Terasa = true,
                SmjestajId = 1
            },
            new SmjestajnaJedinica
            {
                Id = 3,
                Naziv = "Porodični Apartman",
                Cijena = 120.00m,
                Kapacitet = 4,
                Opis = "Prostrani apartman pogodan za porodice.",
                DodatneUsluge = "Uključeni doručak i večera",
                Kuhinja = true,
                Tv = true,
                KlimaUredjaj = true,
                Terasa = true,
                SmjestajId = 2
            },
            new SmjestajnaJedinica
            {
                Id = 4,
                Naziv = "Apartman",
                Cijena = 70.00m,
                Kapacitet = 2,
                Opis = "Kompaktan apartman idealan za kraći boravak.",
                Kuhinja = true,
                Tv = true,
                KlimaUredjaj = true,
                Terasa = false,
                SmjestajId = 3
            },
            new SmjestajnaJedinica
            {
                Id = 5,
                Naziv = "Luksuzni apartman",
                Cijena = 200.00m,
                Kapacitet = 4,
                Opis = "Luksuzan apartman sa prostranom terasom i pogledom na grad.",
                DodatneUsluge = "Uključen doručak i večera",
                Kuhinja = true,
                Tv = true,
                KlimaUredjaj = true,
                Terasa = true,
                SmjestajId = 4
            },
            new SmjestajnaJedinica
            {
                Id = 6,
                Naziv = "Penthouse",
                Cijena = 300.00m,
                Kapacitet = 6,
                Opis = "Penthouse sa privatnim bazenom i ekskluzivnim sadržajima.",
                DodatneUsluge = "Privatni bazen, sauna",
                Kuhinja = true,
                Tv = true,
                KlimaUredjaj = true,
                Terasa = true,
                SmjestajId = 4
            },
            new SmjestajnaJedinica
            {
                Id = 7,
                Naziv = "Ekonomična soba",
                Cijena = 40.00m,
                Kapacitet = 2,
                Opis = "Jednostavna soba za kraće boravke po pristupačnoj cijeni.",
                Kuhinja = false,
                Tv = true,
                KlimaUredjaj = false,
                Terasa = false,
                SmjestajId = 5
            },
            new SmjestajnaJedinica
            {
                Id = 8,
                Naziv = "Executive suite",
                Cijena = 250.00m,
                Kapacitet = 3,
                Opis = "Ekskluzivan suite sa vrhunskim sadržajima.",
                DodatneUsluge = "Uključeni svi obroci",
                Kuhinja = true,
                Tv = true,
                KlimaUredjaj = true,
                Terasa = true,
                SmjestajId = 5
            }
            );

        modelBuilder.Entity<SmjeroviFakulteti>().HasData(
            new SmjeroviFakulteti { Id = 1, SmjerId = 1, FakultetId = 3 },
            new SmjeroviFakulteti { Id = 2, SmjerId = 2, FakultetId = 3 },
            new SmjeroviFakulteti { Id = 3, SmjerId = 1, FakultetId = 1 },
            new SmjeroviFakulteti { Id = 4, SmjerId = 4, FakultetId = 1 },
            new SmjeroviFakulteti { Id = 5, SmjerId = 5, FakultetId = 2 }
            );

        modelBuilder.Entity<Studenti>().HasData(
            new Studenti { Id = 2, BrojIndeksa = "IB200002", GodinaStudija = 4, ProsjecnaOcjena = 10.00m, Status = true, FakultetId = 3, SmjerId = 1, NacinStudiranjaId = 1 },
            new Studenti { Id = 3, BrojIndeksa = "IB200003", GodinaStudija = 4, ProsjecnaOcjena = 10.00m, Status = true, FakultetId = 3, SmjerId = 1, NacinStudiranjaId = 1 },
            new Studenti { Id = 4, BrojIndeksa = "IB210004", GodinaStudija = 3, ProsjecnaOcjena = 9.50m, Status = true, FakultetId = 2, SmjerId = 5, NacinStudiranjaId = 1 },
            new Studenti { Id = 5, BrojIndeksa = "IB210005", GodinaStudija = 3, ProsjecnaOcjena = 9.75m, Status = true, FakultetId = 1, SmjerId = 1, NacinStudiranjaId = 2 },
            new Studenti { Id = 6, BrojIndeksa = "IB220006", GodinaStudija = 2, ProsjecnaOcjena = 8.90m, Status = true, FakultetId = 3, SmjerId = 2, NacinStudiranjaId = 1 },
            new Studenti { Id = 7, BrojIndeksa = "IB220007", GodinaStudija = 2, ProsjecnaOcjena = 8.50m, Status = true, FakultetId = 1, SmjerId = 4, NacinStudiranjaId = 2 },
            new Studenti { Id = 8, BrojIndeksa = "IB230008", GodinaStudija = 1, ProsjecnaOcjena = 8.00m, Status = true, FakultetId = 3, SmjerId = 1, NacinStudiranjaId = 1 },
            new Studenti { Id = 9, BrojIndeksa = "IB230009", GodinaStudija = 1, ProsjecnaOcjena = 7.80m, Status = true, FakultetId = 2, SmjerId = 5, NacinStudiranjaId = 2 }
            );

        modelBuilder.Entity<Slike>().HasData(
            new Slike { SlikaId = 1, Naziv = "hotel1.jpg", SmjestajId = 1 },
            new Slike { SlikaId = 2, Naziv = "apartment_a1.jpg", SmjestajnaJedinicaId = 1 },
            new Slike { SlikaId = 3, Naziv = "apartment_a2.jpg", SmjestajnaJedinicaId = 1 },
            new Slike { SlikaId = 4, Naziv = "hotel2.jpg", SmjestajId = 2 },
            new Slike { SlikaId = 5, Naziv = "hotel3.jpg", SmjestajId = 3 },
            new Slike { SlikaId = 6, Naziv = "ap1.jpg", SmjestajnaJedinicaId = 4 },
            new Slike { SlikaId = 7, Naziv = "ap2.jpg", SmjestajnaJedinicaId = 5 },
            new Slike { SlikaId = 8, Naziv = "ap4.jpg", SmjestajnaJedinicaId = 6 },
            new Slike { SlikaId = 9, Naziv = "ap6.jpg", SmjestajnaJedinicaId = 6 },
            new Slike { SlikaId = 10, Naziv = "ap1.jpg", SmjestajnaJedinicaId = 1 },
            new Slike { SlikaId = 11, Naziv = "ap2.jpg", SmjestajnaJedinicaId = 4 },
            new Slike { SlikaId = 12, Naziv = "ap9.jpg", SmjestajnaJedinicaId = 3 },
            new Slike { SlikaId = 13, Naziv = "hotel2.jpg", SmjestajId = 1 },
            new Slike { SlikaId = 14, Naziv = "hotel3.jpg", SmjestajId = 3 },
            new Slike { SlikaId = 15, Naziv = "hotel2.jpg", SmjestajId = 4 }
        );

        modelBuilder.Entity<Ocjene>().HasData(
            new Ocjene { Id = 1, StudentId = 2, PostId = 1, Ocjena = 5, PostType = "internship" },
            new Ocjene { Id = 2, StudentId = 2, PostId = 2, Ocjena = 5, PostType = "internship" },
            new Ocjene { Id = 3, StudentId = 3, PostId = 1, Ocjena = 4, PostType = "internship" },
            new Ocjene { Id = 4, StudentId = 3, PostId = 2, Ocjena = 3, PostType = "internship" },
            new Ocjene { Id = 5, StudentId = 4, PostId = 5, Ocjena = 5, PostType = "internship" },
            new Ocjene { Id = 6, StudentId = 4, PostId = 6, Ocjena = 4, PostType = "internship" },
            new Ocjene { Id = 7, StudentId = 5, PostId = 7, Ocjena = 3, PostType = "internship" },
            new Ocjene { Id = 8, StudentId = 5, PostId = 8, Ocjena = 5, PostType = "internship" },
            new Ocjene { Id = 9, StudentId = 6, PostId = 9, Ocjena = 4, PostType = "internship" },
            new Ocjene { Id = 10, StudentId = 6, PostId = 1, Ocjena = 3, PostType = "internship" },
            new Ocjene { Id = 11, StudentId = 7, PostId = 2, Ocjena = 5, PostType = "internship" },
            new Ocjene { Id = 12, StudentId = 7, PostId = 5, Ocjena = 4, PostType = "internship" },
            new Ocjene { Id = 13, StudentId = 8, PostId = 6, Ocjena = 3, PostType = "internship" },
            new Ocjene { Id = 14, StudentId = 8, PostId = 7, Ocjena = 5, PostType = "internship" },
            new Ocjene { Id = 15, StudentId = 9, PostId = 8, Ocjena = 4, PostType = "internship" },
            new Ocjene { Id = 16, StudentId = 9, PostId = 9, Ocjena = 5, PostType = "internship" },
            new Ocjene { Id = 17, StudentId = 2, PostId = 5, Ocjena = 3, PostType = "internship" },
            new Ocjene { Id = 18, StudentId = 3, PostId = 6, Ocjena = 5, PostType = "internship" },
            new Ocjene { Id = 19, StudentId = 4, PostId = 7, Ocjena = 4, PostType = "internship" },
            new Ocjene { Id = 20, StudentId = 5, PostId = 8, Ocjena = 5, PostType = "internship" },

            new Ocjene { Id = 21, StudentId = 2, PostId = 3, Ocjena = 5, PostType = "scholarship" },
            new Ocjene { Id = 22, StudentId = 3, PostId = 4, Ocjena = 4, PostType = "scholarship" },
            new Ocjene { Id = 23, StudentId = 4, PostId = 10, Ocjena = 5, PostType = "scholarship" },
            new Ocjene { Id = 24, StudentId = 5, PostId = 11, Ocjena = 3, PostType = "scholarship" },
            new Ocjene { Id = 25, StudentId = 6, PostId = 12, Ocjena = 5, PostType = "scholarship" },
            new Ocjene { Id = 26, StudentId = 7, PostId = 13, Ocjena = 4, PostType = "scholarship" },
            new Ocjene { Id = 27, StudentId = 8, PostId = 14, Ocjena = 5, PostType = "scholarship" },
            new Ocjene { Id = 28, StudentId = 9, PostId = 3, Ocjena = 3, PostType = "scholarship" },
            new Ocjene { Id = 29, StudentId = 2, PostId = 4, Ocjena = 5, PostType = "scholarship" },
            new Ocjene { Id = 30, StudentId = 4, PostId = 3, Ocjena = 5, PostType = "scholarship" },
            new Ocjene { Id = 31, StudentId = 4, PostId = 11, Ocjena = 5, PostType = "scholarship" },
            new Ocjene { Id = 32, StudentId = 5, PostId = 12, Ocjena = 3, PostType = "scholarship" },
            new Ocjene { Id = 33, StudentId = 6, PostId = 13, Ocjena = 5, PostType = "scholarship" },
            new Ocjene { Id = 34, StudentId = 7, PostId = 14, Ocjena = 4, PostType = "scholarship" },
            new Ocjene { Id = 35, StudentId = 8, PostId = 3, Ocjena = 5, PostType = "scholarship" },
            new Ocjene { Id = 36, StudentId = 9, PostId = 4, Ocjena = 3, PostType = "scholarship" },
            new Ocjene { Id = 37, StudentId = 7, PostId = 10, Ocjena = 5, PostType = "scholarship" },
            new Ocjene { Id = 38, StudentId = 3, PostId = 11, Ocjena = 4, PostType = "scholarship" },
            new Ocjene { Id = 39, StudentId = 4, PostId = 12, Ocjena = 5, PostType = "scholarship" },
            new Ocjene { Id = 40, StudentId = 5, PostId = 13, Ocjena = 3, PostType = "scholarship" },


            new Ocjene { Id = 41, StudentId = 2, PostId = 1, Ocjena = 5, PostType = "accommodation" },
            new Ocjene { Id = 42, StudentId = 3, PostId = 2, Ocjena = 4, PostType = "accommodation" },
            new Ocjene { Id = 43, StudentId = 4, PostId = 3, Ocjena = 3, PostType = "accommodation" },
            new Ocjene { Id = 44, StudentId = 5, PostId = 4, Ocjena = 5, PostType = "accommodation" },
            new Ocjene { Id = 45, StudentId = 6, PostId = 5, Ocjena = 4, PostType = "accommodation" },
            new Ocjene { Id = 46, StudentId = 7, PostId = 1, Ocjena = 5, PostType = "accommodation" },
            new Ocjene { Id = 47, StudentId = 8, PostId = 2, Ocjena = 5, PostType = "accommodation" },
            new Ocjene { Id = 48, StudentId = 9, PostId = 3, Ocjena = 4, PostType = "accommodation" },
            new Ocjene { Id = 49, StudentId = 6, PostId = 4, Ocjena = 3, PostType = "accommodation" },
            new Ocjene { Id = 50, StudentId = 3, PostId = 5, Ocjena = 5, PostType = "accommodation" },
            new Ocjene { Id = 51, StudentId = 4, PostId = 1, Ocjena = 4, PostType = "accommodation" },
            new Ocjene { Id = 52, StudentId = 5, PostId = 2, Ocjena = 3, PostType = "accommodation" },
            new Ocjene { Id = 53, StudentId = 6, PostId = 3, Ocjena = 5, PostType = "accommodation" },
            new Ocjene { Id = 54, StudentId = 7, PostId = 4, Ocjena = 4, PostType = "accommodation" },
            new Ocjene { Id = 55, StudentId = 8, PostId = 5, Ocjena = 5, PostType = "accommodation" },
            new Ocjene { Id = 56, StudentId = 9, PostId = 1, Ocjena = 5, PostType = "accommodation" },
            new Ocjene { Id = 57, StudentId = 2, PostId = 2, Ocjena = 5, PostType = "accommodation" },
            new Ocjene { Id = 58, StudentId = 3, PostId = 3, Ocjena = 4, PostType = "accommodation" },
            new Ocjene { Id = 59, StudentId = 4, PostId = 4, Ocjena = 3, PostType = "accommodation" },
            new Ocjene { Id = 60, StudentId = 5, PostId = 5, Ocjena = 5, PostType = "accommodation" }
            );


        modelBuilder.Entity<PrijavePraksa>().HasData(
            new PrijavePraksa
            {
                StudentId = 2,
                PraksaId = 1,
                PropratnoPismo = "Propratno pismo studenta 1 za praksu 1",
                Cv = "CV_studenta_1.pdf",
                Certifikati = "Certifikati_studenta_1.pdf",
                StatusId = 2
            },
            new PrijavePraksa
            {
                StudentId = 3,
                PraksaId = 2,
                PropratnoPismo = "Propratno pismo studenta 2 za praksu 2",
                Cv = "CV_studenta_2.pdf",
                Certifikati = "Certifikati_studenta_2.pdf",
                StatusId = 2
            }
            );

        modelBuilder.Entity<PrijaveStipendija>().HasData(
            new PrijaveStipendija
            {
                StudentId = 2,
                StipendijaId = 3,
                Dokumentacija = "Dokumentacija_studenta_1.pdf",
                Cv = "CV_studenta_1.pdf",
                ProsjekOcjena = 8.5m,
                StatusId = 2
            },
            new PrijaveStipendija
            {
                StudentId = 3,
                StipendijaId = 4,
                Dokumentacija = "Dokumentacija_studenta_2.pdf",
                Cv = "CV_studenta_2.pdf",
                ProsjekOcjena = 9.0m,
                StatusId = 2
            }
            );

        modelBuilder.Entity<Rezervacije>().HasData(
            new Rezervacije
            {
                Id = 1,
                SmjestajnaJedinicaId = 1,
                StudentId = 2,
                DatumPrijave = new DateTime(2024, 6, 15),
                DatumOdjave = new DateTime(2024, 6, 25),
                BrojOsoba = 2,
                Cijena = 200.00m,
                Napomena = "Napomena o rezervaciji",
                StatusId = 2
            },
            new Rezervacije
            {
                Id = 2,
                SmjestajnaJedinicaId = 2,
                StudentId = 3,
                DatumPrijave = new DateTime(2024, 7, 5),
                DatumOdjave = new DateTime(2024, 7, 12),
                BrojOsoba = 3,
                Cijena = 300.00m,
                Napomena = null,
                StatusId = 2
            }
            );

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
