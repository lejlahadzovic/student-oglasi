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
