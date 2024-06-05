using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace StudentOglasi.Services.Migrations
{
    /// <inheritdoc />
    public partial class InitialSetup : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Grad",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Grad", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Kategorija",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Kategorija", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "NacinStudiranja",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false),
                    Naziv = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__NacinStu__3214EC27E3E6A60C", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Oglasi",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naslov = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    RokPrijave = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    VrijemeObjave = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Slika = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Oglas", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Smjerovi",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Smjerovi__3214EC273399A25C", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "StatusOglasi",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__StatusOg__3214EC27976EBE5C", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "StatusPrijave",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__StatusPr__3214EC27C7C93E3C", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "TipSmjestaja",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    Opis = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__TipSmjes__3214EC27E9E84D99", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Uloge",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false),
                    Naziv = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Uloge__3214EC27140192D2", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Organizacije",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Telefon = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Email = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Adresa = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Link = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    GradID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Firma", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Firma_Grad_GradID",
                        column: x => x.GradID,
                        principalTable: "Grad",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Stipenditori",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Adresa = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Email = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Link = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    TipUstanove = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    GradID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Stipenditor", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Stipenditor_Grad_GradID",
                        column: x => x.GradID,
                        principalTable: "Grad",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Univerziteti",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Skracenica = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: true),
                    Email = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Telefon = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Logo = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    Slika = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    Link = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    GradID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Univerzitet", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Univerzitet_Grad_GradID",
                        column: x => x.GradID,
                        principalTable: "Grad",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Objave",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naslov = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Sadrzaj = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    VrijemeObjave = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Slika = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    KategorijaID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Objava", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Objava_Kategorija_KategorijaID",
                        column: x => x.KategorijaID,
                        principalTable: "Kategorija",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Smjestaji",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: false),
                    Adresa = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    GradID = table.Column<int>(type: "int", nullable: false),
                    DodatneUsluge = table.Column<string>(type: "nvarchar(3000)", maxLength: 3000, nullable: true),
                    TipSmjestajaID = table.Column<int>(type: "int", nullable: true),
                    wi_fi = table.Column<bool>(type: "bit", nullable: true, defaultValue: false),
                    parking = table.Column<bool>(type: "bit", nullable: true, defaultValue: false),
                    fitness_centar = table.Column<bool>(type: "bit", nullable: true, defaultValue: false),
                    restoran = table.Column<bool>(type: "bit", nullable: true, defaultValue: false),
                    usluge_prijevoza = table.Column<bool>(type: "bit", nullable: true, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Smjestaj__3214EC27DA80F33F", x => x.ID);
                    table.ForeignKey(
                        name: "FK__Smjestaji__GradI__2180FB33",
                        column: x => x.GradID,
                        principalTable: "Grad",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__Smjestaji__TipSm__40F9A68C",
                        column: x => x.TipSmjestajaID,
                        principalTable: "TipSmjestaja",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Korisnici",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    KorisnickoIme = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Email = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    BrojTelefona = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    Slika = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    LozinkaHash = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    LozinkaSalt = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    UlogaID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Korisnik", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Korisnici_Uloge",
                        column: x => x.UlogaID,
                        principalTable: "Uloge",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Prakse",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false),
                    PocetakPrakse = table.Column<DateTime>(type: "datetime2", nullable: false),
                    KrajPrakse = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Kvalifikacije = table.Column<string>(type: "nvarchar(3000)", maxLength: 3000, nullable: false),
                    Benefiti = table.Column<string>(type: "nvarchar(3000)", maxLength: 3000, nullable: false),
                    Placena = table.Column<bool>(type: "bit", nullable: false),
                    StatusID = table.Column<int>(type: "int", nullable: false),
                    OrganizacijaID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Praksa", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Praksa_Oglas_ID",
                        column: x => x.ID,
                        principalTable: "Oglasi",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Prakse_Organizacija",
                        column: x => x.OrganizacijaID,
                        principalTable: "Organizacije",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_Prakse_StatusOglasi",
                        column: x => x.StatusID,
                        principalTable: "StatusOglasi",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Stipendije",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false),
                    Uslovi = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Iznos = table.Column<double>(type: "float", nullable: false),
                    Kriterij = table.Column<string>(type: "nvarchar(2000)", maxLength: 2000, nullable: false),
                    PotrebnaDokumentacija = table.Column<string>(type: "nvarchar(3000)", maxLength: 3000, nullable: false),
                    Izvor = table.Column<string>(type: "nvarchar(3000)", maxLength: 3000, nullable: false),
                    NivoObrazovanja = table.Column<string>(type: "nvarchar(3000)", maxLength: 3000, nullable: false),
                    BrojStipendisata = table.Column<int>(type: "int", nullable: false),
                    StatusID = table.Column<int>(type: "int", nullable: false),
                    StipenditorID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Stipendija", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Stipendija_Oglas_ID",
                        column: x => x.ID,
                        principalTable: "Oglasi",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Stipendije_StatusOglasi",
                        column: x => x.StatusID,
                        principalTable: "StatusOglasi",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_Stipendije_Stipenditor",
                        column: x => x.StipenditorID,
                        principalTable: "Stipenditori",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Fakulteti",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Skracenica = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: true),
                    Adresa = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Email = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Telefon = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Logo = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    Slika = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    Link = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    UniverzitetID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Fakultet", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Fakultet_Univerzitet_UniverzitetID",
                        column: x => x.UniverzitetID,
                        principalTable: "Univerziteti",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "SmjestajnaJedinica",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    Cijena = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    Kapacitet = table.Column<int>(type: "int", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    DodatneUsluge = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Kuhinja = table.Column<bool>(type: "bit", nullable: true),
                    Tv = table.Column<bool>(type: "bit", nullable: true),
                    KlimaUredjaj = table.Column<bool>(type: "bit", nullable: true),
                    Terasa = table.Column<bool>(type: "bit", nullable: true),
                    SmjestajID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Smjestaj__3214EC276AF062E5", x => x.ID);
                    table.ForeignKey(
                        name: "FK__Smjestajn__Smjes__4F47C5E3",
                        column: x => x.SmjestajID,
                        principalTable: "Smjestaji",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Komentari",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ObjavaID = table.Column<int>(type: "int", nullable: true),
                    OglasID = table.Column<int>(type: "int", nullable: true),
                    KomentarID = table.Column<int>(type: "int", nullable: true),
                    KorisnikID = table.Column<int>(type: "int", nullable: false),
                    VrijemeObjave = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Text = table.Column<string>(type: "nvarchar(3000)", maxLength: 3000, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Komentar", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Komentar_Komentar_KomentarID",
                        column: x => x.KomentarID,
                        principalTable: "Komentari",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_Komentar_Korisnik_KorisnikID",
                        column: x => x.KorisnikID,
                        principalTable: "Korisnici",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Komentar_Objava_ObjavaID",
                        column: x => x.ObjavaID,
                        principalTable: "Objave",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_Komentar_Oglas_OglasID",
                        column: x => x.OglasID,
                        principalTable: "Oglasi",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "SmjeroviFakulteti",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false),
                    SmjerID = table.Column<int>(type: "int", nullable: false),
                    FakultetID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Smjerovi__3214EC275C1E8183", x => x.ID);
                    table.ForeignKey(
                        name: "FK__SmjeroviF__Fakul__6CD828CA",
                        column: x => x.FakultetID,
                        principalTable: "Fakulteti",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__SmjeroviF__Smjer__6BE40491",
                        column: x => x.SmjerID,
                        principalTable: "Smjerovi",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Studenti",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false),
                    BrojIndeksa = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    GodinaStudija = table.Column<int>(type: "int", nullable: false),
                    ProsjecnaOcjena = table.Column<decimal>(type: "decimal(4,2)", nullable: true),
                    Status = table.Column<bool>(type: "bit", nullable: false),
                    FakultetID = table.Column<int>(type: "int", nullable: false),
                    SmjerID = table.Column<int>(type: "int", nullable: false),
                    NacinStudiranjaID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Student", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Student_Fakultet_FakultetID",
                        column: x => x.FakultetID,
                        principalTable: "Fakulteti",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Student_Korisnik_ID",
                        column: x => x.ID,
                        principalTable: "Korisnici",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Studenti_NacinStudiranja",
                        column: x => x.NacinStudiranjaID,
                        principalTable: "NacinStudiranja",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_Studenti_Smjerovi",
                        column: x => x.SmjerID,
                        principalTable: "Smjerovi",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Slike",
                columns: table => new
                {
                    SlikaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    SmjestajID = table.Column<int>(type: "int", nullable: true),
                    SmjestajnaJedinicaID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Slike__FFAE2D46D39CF4CB", x => x.SlikaID);
                    table.ForeignKey(
                        name: "FK_Slike_Smjestaji",
                        column: x => x.SmjestajID,
                        principalTable: "Smjestaji",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_Slike_SmjestajnaJedinica",
                        column: x => x.SmjestajnaJedinicaID,
                        principalTable: "SmjestajnaJedinica",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Ocjene",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    StudentId = table.Column<int>(type: "int", nullable: false),
                    Vrijednost = table.Column<int>(type: "int", nullable: false),
                    Komentar = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    FakultetID = table.Column<int>(type: "int", nullable: true),
                    FirmaID = table.Column<int>(type: "int", nullable: true),
                    StipenditorID = table.Column<int>(type: "int", nullable: true),
                    UniverzitetID = table.Column<int>(type: "int", nullable: true),
                    SmjestajID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Ocjena", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Ocjena_Fakultet_FakultetID",
                        column: x => x.FakultetID,
                        principalTable: "Fakulteti",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_Ocjena_Firma_FirmaID",
                        column: x => x.FirmaID,
                        principalTable: "Organizacije",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_Ocjena_Stipenditor_StipenditorID",
                        column: x => x.StipenditorID,
                        principalTable: "Stipenditori",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_Ocjena_Student_StudentId",
                        column: x => x.StudentId,
                        principalTable: "Studenti",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Ocjena_Univerzitet_UniverzitetID",
                        column: x => x.UniverzitetID,
                        principalTable: "Univerziteti",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__Ocjene__Smjestaj__236943A5",
                        column: x => x.SmjestajID,
                        principalTable: "Smjestaji",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "PrijavePraksa",
                columns: table => new
                {
                    StudentId = table.Column<int>(type: "int", nullable: false),
                    PraksaId = table.Column<int>(type: "int", nullable: false),
                    PropratnoPismo = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    CV = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Certifikati = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    StatusID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PrijavaPraksa", x => new { x.StudentId, x.PraksaId });
                    table.ForeignKey(
                        name: "FK_PrijavaPraksa_Praksa_PraksaId",
                        column: x => x.PraksaId,
                        principalTable: "Prakse",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_PrijavaPraksa_Student_StudentId",
                        column: x => x.StudentId,
                        principalTable: "Studenti",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_PrijavePraksa_StatusPrijave",
                        column: x => x.StatusID,
                        principalTable: "StatusPrijave",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "PrijaveStipendija",
                columns: table => new
                {
                    StudentId = table.Column<int>(type: "int", nullable: false),
                    StipendijaID = table.Column<int>(type: "int", nullable: false),
                    Dokumentacija = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    CV = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    ProsjekOcjena = table.Column<decimal>(type: "decimal(4,2)", nullable: false),
                    StatusID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PrijavaStipendija", x => new { x.StudentId, x.StipendijaID });
                    table.ForeignKey(
                        name: "FK_PrijavaStipendija_Stipendija_StipendijaID",
                        column: x => x.StipendijaID,
                        principalTable: "Stipendije",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_PrijavaStipendija_Student_StudentId",
                        column: x => x.StudentId,
                        principalTable: "Studenti",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_PrijaveStipendija_StatusPrijave",
                        column: x => x.StatusID,
                        principalTable: "StatusPrijave",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Rezervacije",
                columns: table => new
                {
                    SmjestajnaJedinicaID = table.Column<int>(type: "int", nullable: false),
                    StudentID = table.Column<int>(type: "int", nullable: false),
                    DatumPrijave = table.Column<DateTime>(type: "datetime", nullable: false),
                    DatumOdjave = table.Column<DateTime>(type: "datetime", nullable: false),
                    BrojOsoba = table.Column<int>(type: "int", nullable: true),
                    Cijena = table.Column<decimal>(type: "decimal(10,2)", nullable: false),
                    Napomena = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    StatusID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Rezervac__A59BA9A7F156796A", x => new { x.SmjestajnaJedinicaID, x.StudentID });
                    table.ForeignKey(
                        name: "FK__Rezervaci__Smjes__1209AD79",
                        column: x => x.SmjestajnaJedinicaID,
                        principalTable: "SmjestajnaJedinica",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__Rezervaci__Statu__13F1F5EB",
                        column: x => x.StatusID,
                        principalTable: "StatusPrijave",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__Rezervaci__Stude__12FDD1B2",
                        column: x => x.StudentID,
                        principalTable: "Studenti",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Fakultet_UniverzitetID",
                table: "Fakulteti",
                column: "UniverzitetID");

            migrationBuilder.CreateIndex(
                name: "IX_Komentar_KomentarID",
                table: "Komentari",
                column: "KomentarID");

            migrationBuilder.CreateIndex(
                name: "IX_Komentar_KorisnikID",
                table: "Komentari",
                column: "KorisnikID");

            migrationBuilder.CreateIndex(
                name: "IX_Komentar_ObjavaID",
                table: "Komentari",
                column: "ObjavaID");

            migrationBuilder.CreateIndex(
                name: "IX_Komentar_OglasID",
                table: "Komentari",
                column: "OglasID");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnici_UlogaID",
                table: "Korisnici",
                column: "UlogaID");

            migrationBuilder.CreateIndex(
                name: "IX_Objava_KategorijaID",
                table: "Objave",
                column: "KategorijaID");

            migrationBuilder.CreateIndex(
                name: "IX_Ocjena_FakultetID",
                table: "Ocjene",
                column: "FakultetID");

            migrationBuilder.CreateIndex(
                name: "IX_Ocjena_FirmaID",
                table: "Ocjene",
                column: "FirmaID");

            migrationBuilder.CreateIndex(
                name: "IX_Ocjena_StipenditorID",
                table: "Ocjene",
                column: "StipenditorID");

            migrationBuilder.CreateIndex(
                name: "IX_Ocjena_StudentId",
                table: "Ocjene",
                column: "StudentId");

            migrationBuilder.CreateIndex(
                name: "IX_Ocjena_UniverzitetID",
                table: "Ocjene",
                column: "UniverzitetID");

            migrationBuilder.CreateIndex(
                name: "IX_Ocjene_SmjestajID",
                table: "Ocjene",
                column: "SmjestajID");

            migrationBuilder.CreateIndex(
                name: "IX_Firma_GradID",
                table: "Organizacije",
                column: "GradID");

            migrationBuilder.CreateIndex(
                name: "IX_Prakse_OrganizacijaID",
                table: "Prakse",
                column: "OrganizacijaID");

            migrationBuilder.CreateIndex(
                name: "IX_Prakse_StatusID",
                table: "Prakse",
                column: "StatusID");

            migrationBuilder.CreateIndex(
                name: "IX_PrijavaPraksa_PraksaId",
                table: "PrijavePraksa",
                column: "PraksaId");

            migrationBuilder.CreateIndex(
                name: "IX_PrijavePraksa_StatusID",
                table: "PrijavePraksa",
                column: "StatusID");

            migrationBuilder.CreateIndex(
                name: "IX_PrijavaStipendija_StipendijaID",
                table: "PrijaveStipendija",
                column: "StipendijaID");

            migrationBuilder.CreateIndex(
                name: "IX_PrijaveStipendija_StatusID",
                table: "PrijaveStipendija",
                column: "StatusID");

            migrationBuilder.CreateIndex(
                name: "IX_Rezervacije_StatusID",
                table: "Rezervacije",
                column: "StatusID");

            migrationBuilder.CreateIndex(
                name: "IX_Rezervacije_StudentID",
                table: "Rezervacije",
                column: "StudentID");

            migrationBuilder.CreateIndex(
                name: "IX_Slike_SmjestajID",
                table: "Slike",
                column: "SmjestajID");

            migrationBuilder.CreateIndex(
                name: "IX_Slike_SmjestajnaJedinicaID",
                table: "Slike",
                column: "SmjestajnaJedinicaID");

            migrationBuilder.CreateIndex(
                name: "IX_SmjeroviFakulteti_FakultetID",
                table: "SmjeroviFakulteti",
                column: "FakultetID");

            migrationBuilder.CreateIndex(
                name: "IX_SmjeroviFakulteti_SmjerID",
                table: "SmjeroviFakulteti",
                column: "SmjerID");

            migrationBuilder.CreateIndex(
                name: "IX_Smjestaji_GradID",
                table: "Smjestaji",
                column: "GradID");

            migrationBuilder.CreateIndex(
                name: "IX_Smjestaji_TipSmjestajaID",
                table: "Smjestaji",
                column: "TipSmjestajaID");

            migrationBuilder.CreateIndex(
                name: "IX_SmjestajnaJedinica_SmjestajID",
                table: "SmjestajnaJedinica",
                column: "SmjestajID");

            migrationBuilder.CreateIndex(
                name: "IX_Stipendije_StatusID",
                table: "Stipendije",
                column: "StatusID");

            migrationBuilder.CreateIndex(
                name: "IX_Stipendije_StipenditorID",
                table: "Stipendije",
                column: "StipenditorID");

            migrationBuilder.CreateIndex(
                name: "IX_Stipenditor_GradID",
                table: "Stipenditori",
                column: "GradID");

            migrationBuilder.CreateIndex(
                name: "IX_Student_FakultetID",
                table: "Studenti",
                column: "FakultetID");

            migrationBuilder.CreateIndex(
                name: "IX_Studenti_NacinStudiranjaID",
                table: "Studenti",
                column: "NacinStudiranjaID");

            migrationBuilder.CreateIndex(
                name: "IX_Studenti_SmjerID",
                table: "Studenti",
                column: "SmjerID");

            migrationBuilder.CreateIndex(
                name: "IX_Univerzitet_GradID",
                table: "Univerziteti",
                column: "GradID");

            migrationBuilder.InsertData(
                table: "Grad",
                columns: new[] { "ID", "Naziv" },
                values: new object[,]
                {
                    { 1, "Banja Luka" },
                    { 2, "Bihać" },
                    { 3, "Goražde" },
                    { 4, "Jablanica" },
                    { 5, "Konjic" },
                    { 6, "Mostar" },
                    { 7, "Sarajevo" },
                    { 8, "Tuzla" },
                    { 9, "Zenica" }
                });

            migrationBuilder.InsertData(
                table: "Kategorija",
                columns: new[] { "ID", "Naziv", "Opis" },
                values: new object[,]
                {
                    { 1, "Edukacija", null },
                    { 2, "Ponude i popusti", null },
                    { 3, "Aktivnosti i događaji", null },
                    { 4, "Tehnologija", null }
                });

            migrationBuilder.InsertData(
                table: "NacinStudiranja",
                columns: new[] { "ID", "Naziv", "Opis" },
                values: new object[,]
                {
                    { 1, "Redovno", null },
                    { 2, "Vanredno", null },
                    { 3, "DL", "Distance learning" }
                });

            migrationBuilder.InsertData(
               table: "Oglasi",
               columns: new[] { "ID", "Naslov", "RokPrijave", "Opis", "VrijemeObjave", "Slika" },
               values: new object[,]
               {
                    { 1, "Računovodstvo u praksi", new DateTime(2024, 6, 30), "Ova praksa omogućava sticanje praktičnog iskustva u vođenju knjiga, pripremi financijskih izvještaja, " +
                    "obračunu plata i poreza, te primjeni računovodstvenih standarda.", new DateTime(2024, 6, 1), "internship1.png" },
                    { 2, "Praksa u marketingu za studente završnih godina", new DateTime(2024, 7, 15), "Pridružite se našem dinamičnom marketing timu i steknite dragoceno iskustvo! " +
                    "Nudimo plaćenu praksu za studente završnih godina ekonomskih i menadžment fakulteta. Tokom prakse, radit ćete na stvarnim projektima, učiti od iskusnih profesionalaca i razvijati " +
                    "svoje veštine. Prijave su otvorene do kraja meseca. Ne propustite priliku!", new DateTime(2024, 6, 1), "internship2.png" },
                    { 3, "Erasmus+ stipendije za zimski semestar na Univerzitetu u Ljubljani", new DateTime(2024, 8, 1), "Ured za međunarodnu saradnju Univerziteta u Zenici objavljuje Konkurs za prijavu studenata za razmjenu u zimskom semestru 2024/25. " +
                    "godine u okviru Erasmus+programa za Univerzitet u Ljubljani, Slovenija.", new DateTime(2024, 6, 1), "scholarship1.jpg" },
                    { 4, "Stipendiranje učenika i studenata za 2023/2024. godinu", new DateTime(2024, 8, 1), "Sa zadovoljstvom objavljujemo konkurs za stipendiranje talentovanih učenika i studenata za školsku 2023/2024. godinu. Ova stipendija je " +
                    "namenjena učenicima srednjih škola i studentima svih nivoa studija koji pokazuju izvrsne akademske rezultate, posvećenost i želju za daljim obrazovanjem.", new DateTime(2024, 6, 1), "scholarship1.jpg" }
               });

            migrationBuilder.InsertData(
               table: "Smjerovi",
               columns: new[] { "ID", "Naziv", "Opis" },
               values: new object[,]
               {
                    { 1, "Softverski inženjering", null },
                    { 2, "Razvoj softvera", null },
                    { 3, "Mašinstvo", null },
                    { 4, "Računarstvo i informatika", null }
               });

            migrationBuilder.InsertData(
                table: "StatusOglasi",
                columns: new[] { "ID", "Naziv", "Opis" },
                values: new object[,]
                {
                    { 1, "Initial", null },
                    { 2, "Draft", null },
                    { 3, "Aktivan", null },
                    { 4, "Update", null }
                });

            migrationBuilder.InsertData(
                table: "StatusPrijave",
                columns: new[] { "ID", "Naziv", "Opis" },
                values: new object[,]
                {
                    { 1, "Initial", null },
                    { 2, "Na cekanju", null },
                    { 3, "Odobrena", null },
                    { 4, "Otkazana", null }
                });

            migrationBuilder.InsertData(
                table: "TipSmjestaja",
                columns: new[] { "ID", "Naziv", "Opis" },
                values: new object[,]
                {
                    { 1, "Hotel", null },
                    { 2, "Apartman", null }
                });

            migrationBuilder.InsertData(
                table: "Uloge",
                columns: new[] { "ID", "Naziv", "Opis" },
                values: new object[,]
                {
                    { 1, "Administrator", null },
                    { 2, "Student", null }
                });

            migrationBuilder.InsertData(
                table: "Organizacije",
                columns: new[] { "ID", "Naziv", "Telefon", "Email", "Adresa", "Link", "GradID" },
                values: new object[,]
                {
                    { 1, "Organizacija A", "123-456-789", "kontakt@organizacija-a.com", "Adresa 1", "www.organizacija-a.com", 1 },
                    { 2, "Organizacija B", "987-654-321", "kontakt@organizacija-b.com", "Adresa 2", "www.organizacija-b.com", 2 },
                    { 3, "Organizacija C", "456-789-123", "kontakt@organizacija-c.com", "Adresa 3", "www.organizacija-c.com", 3 }
                });

            migrationBuilder.InsertData(
                table: "Stipenditori",
                columns: new[] { "ID", "Naziv", "Adresa", "Email", "Link", "TipUstanove", "GradID" },
                values: new object[,]
                {
                    { 1, "Stipenditor A", "Adresa 1", "kontakt@stipenditor-a.com", "www.stipenditor-a.com", "Univerzitet", 1 },
                    { 2, "Stipenditor B", "Adresa 2", "kontakt@stipenditor-b.com", "www.stipenditor-b.com", "Fondacija", 2 },
                    { 3, "Stipenditor C", "Adresa 3", "kontakt@stipenditor-c.com", "www.stipenditor-c.com", "Firma", 3 }
                });

            migrationBuilder.InsertData(
                table: "Univerziteti",
                columns: new[] { "ID", "Naziv", "Skracenica", "Email", "Telefon", "Logo", "Slika", "Link", "GradID" },
                values: new object[,]
                {
                    { 1, "Univerzitet u Sarajevu", "UNSA", "info@unsa.ba", "033-123-456", null, null, "www.unsa.ba", 7 },
                    { 2, "Univerzitet \"Džemal Bijedić\"", "UNMO", "info@unmo.ba", "036-123-456", null, null, "www.unmo.ba", 6 },
                    { 3, "Univerzitet u Tuzli", "UNTZ", "info@untz.ba", "035-123-456", null, null, "www.untz.ba", 8 }
                });

            migrationBuilder.InsertData(
                table: "Objave",
                columns: new[] { "ID", "Naslov", "Sadrzaj", "VrijemeObjave", "Slika", "KategorijaID" },
                values: new object[,]
                {
                    { 1, "Novi kurs programiranja", "Prijavite se za novi kurs programiranja koji počinje uskoro.", new DateTime(2024, 6, 5), "student.jpg", 2 },
                    { 2, "Poziv za volontiranje", "Pridružite se našem timu volontera i steknite dragocjeno iskustvo.", new DateTime(2024, 6, 6), "student.jpg", 3 },
                    { 3, "Takmičenje u inovacijama", "Učestvujte u takmičenju u inovacijama i osvojite vrijedne nagrade.", new DateTime(2024, 6, 7), "student.jpg", 4 }
                });

            migrationBuilder.InsertData(
                table: "Smjestaji",
                columns: new[] { "ID", "Naziv", "Adresa", "Opis", "GradID", "DodatneUsluge", "TipSmjestajaID", "wi_fi", "parking", "fitness_centar", "restoran", "usluge_prijevoza" },
                values: new object[,]
                {
                    { 1, "Hotel Sarajevo", "Adresa 1", "Opis hotela u Sarajevu", 7, null, 1, true, true, true, true, true },
                    { 2, "Apartman Mostar", "Adresa 3", "Opis apartmana u Mostaru", 6, null, 2, true, false, false, false, false }
                });

            migrationBuilder.InsertData(
                table: "Korisnici",
                columns: new[] { "ID", "Ime", "Prezime", "KorisnickoIme", "Email", "BrojTelefona", "Slika", "LozinkaHash", "LozinkaSalt", "UlogaID" },
                values: new object[,]
                {
                    { 1, "Kemal", "Hajdarpasic", "admin", "kh@example.com", null, null, "JfJzsL3ngGWki+Dn67C+8WLy73I=", "7TUJfmgkkDvcY3PB/M4fhg==", 1 },
                    { 2, "Lejla", "Hadzovic", "lejla", "lh@example.com", null, null, "JfJzsL3ngGWki+Dn67C+8WLy73I=", "7TUJfmgkkDvcY3PB/M4fhg==", 2 },
                    { 3, "Kemal", "Hajdarpasic", "kemal", "kh@example.com", null, null, "JfJzsL3ngGWki+Dn67C+8WLy73I=", "7TUJfmgkkDvcY3PB/M4fhg==", 2 },
                });

            migrationBuilder.InsertData(
                table: "Prakse",
                columns: new[] { "ID", "PocetakPrakse", "KrajPrakse", "Kvalifikacije", "Benefiti", "Placena", "StatusID", "OrganizacijaID" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 7, 1), new DateTime(2024, 9, 1), "Poznavanje rada na računaru", "Besplatan ručak", true, 2, 1 },
                    { 2, new DateTime(2024, 8, 1), new DateTime(2024, 10, 1), "Poznavanje programiranja", "Besplatan prevoz", false, 2, 2 }
                });

            migrationBuilder.InsertData(
                table: "Stipendije",
                columns: new[] { "ID", "Uslovi", "Iznos", "Kriterij", "PotrebnaDokumentacija", "Izvor", "NivoObrazovanja", "BrojStipendisata", "StatusID", "StipenditorID" },
                values: new object[,]
                {
                    { 3, "Uslov 1", 1000.00, "Kriterij 1", "Dokumentacija 1", "Izvor 1", "Nivo obrazovanja 1", 10, 2, 1 },
                    { 4, "Uslov 2", 1500.00, "Kriterij 2", "Dokumentacija 2", "Izvor 2", "Nivo obrazovanja 2", 5, 2, 2 }
                });

            migrationBuilder.InsertData(
                table: "Fakulteti",
                columns: new[] { "ID", "Naziv", "Skracenica", "Adresa", "Email", "Telefon", "Opis", "Logo", "Slika", "Link", "UniverzitetID" },
                values: new object[,]
                {
                    { 1, "Elektrotehnički fakultet", "ETF", "Adresa 1", "etf@unsa.com", "123-456", null, null, null, "https://www.etf.unsa.ba/", 1 },
                    { 2, "Medicinski fakultet", "MF", "Adresa 2", "mf@unsa.com", "123-457", null, null, null, "https://www.mf.unsa.ba/", 1 },
                    { 3, "Fakultet informacijskih tehnologija", "FIT", "Adresa 3", "fit@unmo.com", "123-458", null, null, null, "https://www.fit.ba/", 2 }
                });

            migrationBuilder.InsertData(
                table: "SmjestajnaJedinica",
                columns: new[] { "ID", "Naziv", "Cijena", "Kapacitet", "Opis", "DodatneUsluge", "Kuhinja", "Tv", "KlimaUredjaj", "Terasa", "SmjestajID" },
                values: new object[,]
                {
                    { 1, "Standardna Soba", 50.00m, 2, "Standardna soba sa osnovnim sadržajima.", null, true, true, true, false, 1 },
                    { 2, "Deluxe Soba", 80.00m, 3, "Deluxe soba sa dodatnim uslugama.", "Uključen doručak", true, true, true, true, 1 },
                    { 3, "Porodični Apartman", 120.00m, 4, "Prostrani apartman pogodan za porodice.", "Uključeni doručak i večera", true, true, true, true, 2 }
                });

            migrationBuilder.InsertData(
                table: "Komentari",
                columns: new[] { "ID", "ObjavaID", "OglasID", "KomentarID", "KorisnikID", "VrijemeObjave", "Text" },
                values: new object[,]
                {
                    { 1, null, 1, null, 1, new DateTime(2024, 6, 1, 12, 0, 0), "Ovo je komentar na oglas." },
                    { 2, 1, null, null, 2, new DateTime(2024, 6, 2, 14, 30, 0), "Ovo je komentar na objavu." },
                    { 3, null, null, 1, 3, new DateTime(2024, 6, 3, 9, 45, 0), "Ovo je odgovor na komentar." }
                });

            migrationBuilder.InsertData(
                table: "SmjeroviFakulteti",
                columns: new[] { "ID", "SmjerID", "FakultetID" },
                values: new object[,]
                {
                    { 1, 1, 3 },
                    { 2, 2, 3 },
                    { 3, 1, 1 },
                    { 4, 4, 1 }
                });

            migrationBuilder.InsertData(
                table: "Studenti",
                columns: new[] { "ID", "BrojIndeksa", "GodinaStudija", "ProsjecnaOcjena", "Status", "FakultetID", "SmjerID", "NacinStudiranjaID" },
                values: new object[,]
                {
                    { 2, "IB2020002", 4, 10.00m, true, 3, 1, 1 },
                    { 3, "IB2020003", 4, 10.00m, true, 3, 1, 1 }
                });
            migrationBuilder.InsertData(
                table: "Slike",
                columns: new[] { "Naziv", "SmjestajID", "SmjestajnaJedinicaID" },
                values: new object[,]
                {
                    { "hotel1.jpg", 1, null },
                    { "apartment_a1.jpg", null, 1 },
                    { "apartment_a2.jpg", null, 1 }
                });

            migrationBuilder.InsertData(
                table: "Ocjene",
                columns: new[] { "StudentId", "Vrijednost", "Komentar", "FakultetID", "FirmaID", "StipenditorID", "UniverzitetID", "SmjestajID" },
                values: new object[,]
                {
                    { 2, 5, "Odličan fakultet!", 1, null, null, null, null },
                    { 2, 5, "Smještaj je izvrstan!", null, null, null, null, 1 }
                });

            migrationBuilder.InsertData(
                table: "PrijavePraksa",
                columns: new[] { "StudentId", "PraksaId", "PropratnoPismo", "CV", "Certifikati", "StatusID" },
                values: new object[,]
                {
                    { 2, 1, "Propratno pismo studenta 1 za praksu 1", "CV_studenta_1.pdf", "Certifikati_studenta_1.pdf", 2 },
                    { 3, 2, "Propratno pismo studenta 2 za praksu 2", "CV_studenta_2.pdf", "Certifikati_studenta_2.pdf", 2 }
                });

            migrationBuilder.InsertData(
                table: "PrijaveStipendija",
                columns: new[] { "StudentId", "StipendijaID", "Dokumentacija", "CV", "ProsjekOcjena", "StatusID" },
                values: new object[,]
                {
                    { 2, 3, "Dokumentacija_studenta_1.pdf", "CV_studenta_1.pdf", 8.5m, 2 },
                    { 3, 4, "Dokumentacija_studenta_2.pdf", "CV_studenta_2.pdf", 9.0m, 2 },
                });

            migrationBuilder.InsertData(
                table: "Rezervacije",
                columns: new[] { "SmjestajnaJedinicaID", "StudentID", "DatumPrijave", "DatumOdjave", "BrojOsoba", "Cijena", "Napomena", "StatusID" },
                values: new object[,]
                {
                    { 1, 2, new DateTime(2024, 6, 15), new DateTime(2024, 6, 25), 2, 200.00m, "Napomena o rezervaciji", 2 },
                    { 2, 3, new DateTime(2024, 7, 5), new DateTime(2024, 7, 12), 3, 300.00m, null, 2 },
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Komentari");

            migrationBuilder.DropTable(
                name: "Ocjene");

            migrationBuilder.DropTable(
                name: "PrijavePraksa");

            migrationBuilder.DropTable(
                name: "PrijaveStipendija");

            migrationBuilder.DropTable(
                name: "Rezervacije");

            migrationBuilder.DropTable(
                name: "Slike");

            migrationBuilder.DropTable(
                name: "SmjeroviFakulteti");

            migrationBuilder.DropTable(
                name: "Objave");

            migrationBuilder.DropTable(
                name: "Prakse");

            migrationBuilder.DropTable(
                name: "Stipendije");

            migrationBuilder.DropTable(
                name: "StatusPrijave");

            migrationBuilder.DropTable(
                name: "Studenti");

            migrationBuilder.DropTable(
                name: "SmjestajnaJedinica");

            migrationBuilder.DropTable(
                name: "Kategorija");

            migrationBuilder.DropTable(
                name: "Organizacije");

            migrationBuilder.DropTable(
                name: "Oglasi");

            migrationBuilder.DropTable(
                name: "StatusOglasi");

            migrationBuilder.DropTable(
                name: "Stipenditori");

            migrationBuilder.DropTable(
                name: "Fakulteti");

            migrationBuilder.DropTable(
                name: "Korisnici");

            migrationBuilder.DropTable(
                name: "NacinStudiranja");

            migrationBuilder.DropTable(
                name: "Smjerovi");

            migrationBuilder.DropTable(
                name: "Smjestaji");

            migrationBuilder.DropTable(
                name: "Univerziteti");

            migrationBuilder.DropTable(
                name: "Uloge");

            migrationBuilder.DropTable(
                name: "TipSmjestaja");

            migrationBuilder.DropTable(
                name: "Grad");
        }
    }
}
