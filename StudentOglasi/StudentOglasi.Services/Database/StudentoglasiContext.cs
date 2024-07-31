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

    public virtual DbSet<Like> Likes { get; set; }

    public virtual DbSet<NacinStudiranja> NacinStudiranjas { get; set; }

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
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=localhost;Initial Catalog=Studentoglasi;Trusted_Connection=True;TrustServerCertificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.UseCollation("SQL_Latin1_General_CP1_CI_AS");

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

            entity.Property(e => e.PostType).HasMaxLength(50);
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
            entity.HasKey(e => e.Id).HasName("PK_Ocjena");

            entity.ToTable("Ocjene");

            entity.HasIndex(e => e.FakultetId, "IX_Ocjena_FakultetID");

            entity.HasIndex(e => e.FirmaId, "IX_Ocjena_FirmaID");

            entity.HasIndex(e => e.StipenditorId, "IX_Ocjena_StipenditorID");

            entity.HasIndex(e => e.StudentId, "IX_Ocjena_StudentId");

            entity.HasIndex(e => e.UniverzitetId, "IX_Ocjena_UniverzitetID");

            entity.HasIndex(e => e.SmjestajId, "IX_Ocjene_SmjestajID");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.FakultetId).HasColumnName("FakultetID");
            entity.Property(e => e.FirmaId).HasColumnName("FirmaID");
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
                .HasConstraintName("FK__Ocjene__Smjestaj__236943A5");

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
            entity.HasKey(e => new { e.SmjestajnaJedinicaId, e.StudentId }).HasName("PK__Rezervac__A59BA9A7F156796A");

            entity.ToTable("Rezervacije");

            entity.HasIndex(e => e.StatusId, "IX_Rezervacije_StatusID");

            entity.HasIndex(e => e.StudentId, "IX_Rezervacije_StudentID");

            entity.Property(e => e.SmjestajnaJedinicaId).HasColumnName("SmjestajnaJedinicaID");
            entity.Property(e => e.StudentId).HasColumnName("StudentID");
            entity.Property(e => e.Cijena).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.DatumOdjave).HasColumnType("datetime");
            entity.Property(e => e.DatumPrijave).HasColumnType("datetime");
            entity.Property(e => e.StatusId).HasColumnName("StatusID");

            entity.HasOne(d => d.SmjestajnaJedinica).WithMany(p => p.Rezervacijes)
                .HasForeignKey(d => d.SmjestajnaJedinicaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Rezervaci__Smjes__1209AD79");

            entity.HasOne(d => d.Status).WithMany(p => p.Rezervacijes)
                .HasForeignKey(d => d.StatusId)
                .HasConstraintName("FK__Rezervaci__Statu__13F1F5EB");

            entity.HasOne(d => d.Student).WithMany(p => p.Rezervacijes)
                .HasForeignKey(d => d.StudentId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Rezervaci__Stude__12FDD1B2");
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

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
