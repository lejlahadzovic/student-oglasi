using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace StudentOglasi.Services.Migrations
{
    /// <inheritdoc />
    public partial class AddSeedData : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
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
                columns: new[] { "ID", "Naslov", "Opis", "RokPrijave", "Slika", "VrijemeObjave" },
                values: new object[,]
                {
                    { 1, "Računovodstvo u praksi", "Ova praksa omogućava sticanje praktičnog iskustva u vođenju knjiga, pripremi financijskih izvještaja, obračunu plata i poreza, te primjeni računovodstvenih standarda.", new DateTime(2024, 6, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), "internship1.png", new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 2, "Praksa u marketingu za studente završnih godina", "Pridružite se našem dinamičnom marketing timu i steknite dragoceno iskustvo! Nudimo plaćenu praksu za studente završnih godina ekonomskih i menadžment fakulteta. Tokom prakse, radit ćete na stvarnim projektima, učiti od iskusnih profesionalaca i razvijati svoje veštine. Prijave su otvorene do kraja meseca. Ne propustite priliku!", new DateTime(2024, 7, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), "internship2.png", new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 3, "Erasmus+ stipendije za zimski semestar na Univerzitetu u Ljubljani", "Ured za međunarodnu saradnju Univerziteta u Zenici objavljuje Konkurs za prijavu studenata za razmjenu u zimskom semestru 2024/25. godine u okviru Erasmus+ programa za Univerzitet u Ljubljani, Slovenija.", new DateTime(2024, 8, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "scholarship1.jpg", new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 4, "Stipendiranje učenika i studenata za 2023/2024. godinu", "Sa zadovoljstvom objavljujemo konkurs za stipendiranje talentovanih učenika i studenata za školsku 2023/2024. godinu. Ova stipendija je namenjena učenicima srednjih škola i studentima svih nivoa studija koji pokazuju izvrsne akademske rezultate, posvećenost i želju za daljim obrazovanjem.", new DateTime(2024, 8, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "scholarship1.jpg", new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 5, "Praksa u IT sektoru - Software Development", "Pridružite se našem IT timu i učestvujte u razvoju softverskih rješenja! Ova praksa nudi priliku za rad na stvarnim projektima, upoznavanje sa najsavremenijim tehnologijama i proširivanje vaših vještina u programiranju.", new DateTime(2024, 7, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), "internship3.png", new DateTime(2024, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 6, "Praksa u oblasti ljudskih resursa", "Ova praksa vam omogućava sticanje praktičnog iskustva u regrutaciji, upravljanju talentima i organizaciji zaposlenih. Idealna prilika za studente koji žele karijeru u HR sektoru.", new DateTime(2024, 7, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), "internship4.png", new DateTime(2024, 6, 10, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 7, "Praksa u finansijama", "Praksa u našem financijskom timu nudi priliku za rad na analizi financijskih podataka, planiranju budžeta i pripremi izvještaja. Idealan početak za one koji žele karijeru u financijama.", new DateTime(2024, 7, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), "internship5.png", new DateTime(2024, 6, 15, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 8, "Praksa u dizajnu", "Ako volite kreativni rad, ova praksa vam nudi priliku da radite sa našim dizajnerskim timom na stvaranju vizuelnih rješenja za digitalne i štampane medije.", new DateTime(2024, 8, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), "internship1.png", new DateTime(2024, 6, 20, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 9, "Praksa u turizmu i hotelijerstvu", "Steknite iskustvo u radu sa gostima i organizaciji turističkih aranžmana. Ova praksa je savršena za studente turizma i ugostiteljstva.", new DateTime(2024, 8, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), "internship2.png", new DateTime(2024, 6, 25, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 10, "Stipendije za master studije u inostranstvu", "Ova stipendija pokriva troškove školarine i života za master studije u inostranstvu. Idealna prilika za studente koji žele nastaviti obrazovanje na prestižnim univerzitetima.", new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), "scholarship2.jpg", new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 11, "Stipendije za studente tehničkih nauka", "Stipendije namijenjene studentima tehničkih fakulteta koji pokazuju izuzetne rezultate u studiranju i želju za usavršavanjem u oblasti tehničkih nauka.", new DateTime(2024, 8, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), "scholarship3.jpg", new DateTime(2024, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 12, "Stipendije za socijalno ugrožene studente", "Ova stipendija namijenjena je studentima iz socijalno ugroženih porodica, sa ciljem da im se pruži podrška u nastavku obrazovanja.", new DateTime(2024, 9, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "scholarship4.jpg", new DateTime(2024, 6, 10, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 13, "Stipendije za istraživačke projekte", "Stipendije za studente koji rade na inovativnim istraživačkim projektima u oblasti prirodnih nauka. Prilika za finansijsku podršku i dalji razvoj istraživačkog rada.", new DateTime(2024, 9, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), "scholarship5.jpg", new DateTime(2024, 6, 15, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 14, "Erasmus+ stipendije za studente na razmjeni", "Prilika za studente koji žele studirati jedan semestar u inostranstvu kroz Erasmus+ program. Stipendija pokriva troškove puta, smještaja i školarine.", new DateTime(2024, 9, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), "scholarship1.jpg", new DateTime(2024, 6, 20, 0, 0, 0, 0, DateTimeKind.Unspecified) }
                });

            migrationBuilder.InsertData(
                table: "Smjerovi",
                columns: new[] { "ID", "Naziv", "Opis" },
                values: new object[,]
                {
                    { 1, "Softverski inženjering", null },
                    { 2, "Razvoj softvera", null },
                    { 3, "Mašinstvo", null },
                    { 4, "Računarstvo i informatika", null },
                    { 5, "Klinicka medicina", "Studij koji se fokusira na kliničke aspekte medicine." }
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
                table: "Korisnici",
                columns: new[] { "ID", "BrojTelefona", "Email", "Ime", "KorisnickoIme", "LozinkaHash", "LozinkaSalt", "Prezime", "Slika", "UlogaID" },
                values: new object[,]
                {
                    { 1, null, "kemal.hajdarpasic@edu.fit.ba", "Kemal", "admin", "JfJzsL3ngGWki+Dn67C+8WLy73I=", "7TUJfmgkkDvcY3PB/M4fhg==", "Hajdarpasic", null, 1 },
                    { 2, null, "lejla.hadzovic@edu.fit.ba", "Lejla", "lejla", "ug0GgEnT5hKaHsfTn1l1kiGvZAg=", "qh31pfpS2ox1h96QPhmR/Q==", "Hadzovic", null, 2 },
                    { 3, null, "kemal.hajdarpasic@edu.fit.ba", "Kemal", "kemal", "ug0GgEnT5hKaHsfTn1l1kiGvZAg=", "qh31pfpS2ox1h96QPhmR/Q==", "Hajdarpasic", null, 2 },
                    { 4, null, "amir@example.com", "Amir", "amir", "ug0GgEnT5hKaHsfTn1l1kiGvZAg=", "qh31pfpS2ox1h96QPhmR/Q==", "Bajric", null, 2 },
                    { 5, null, "jasmina@example.com", "Jasmina", "jasmina", "ug0GgEnT5hKaHsfTn1l1kiGvZAg=", "qh31pfpS2ox1h96QPhmR/Q==", "Nalic", null, 2 },
                    { 6, null, "nina@example.com", "Nina", "nina", "ug0GgEnT5hKaHsfTn1l1kiGvZAg=", "qh31pfpS2ox1h96QPhmR/Q==", "Milic", null, 2 },
                    { 7, null, "sm@example.com", "Selma", "selma", "ug0GgEnT5hKaHsfTn1l1kiGvZAg=", "qh31pfpS2ox1h96QPhmR/Q==", "Mujagic", null, 2 },
                    { 8, null, "nh@example.com", "Nedim", "nedim", "ug0GgEnT5hKaHsfTn1l1kiGvZAg=", "qh31pfpS2ox1h96QPhmR/Q==", "Hodzic", null, 2 },
                    { 9, null, "jh@example.com", "Jasmina", "jasmina", "ug0GgEnT5hKaHsfTn1l1kiGvZAg=", "qh31pfpS2ox1h96QPhmR/Q==", "Hadziabdic", null, 2 }
                });

            migrationBuilder.InsertData(
                table: "Objave",
                columns: new[] { "ID", "KategorijaID", "Naslov", "Sadrzaj", "Slika", "VrijemeObjave" },
                values: new object[,]
                {
                    { 1, 2, "Novi kurs programiranja", "Prijavite se za novi kurs programiranja koji počinje uskoro.", "student.jpg", new DateTime(2024, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 2, 3, "Poziv za volontiranje", "Pridružite se našem timu volontera i steknite dragocjeno iskustvo.", "students.png", new DateTime(2024, 6, 6, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 3, 4, "Takmičenje u inovacijama", "Učestvujte u takmičenju u inovacijama i osvojite vrijedne nagrade.", "studentlife.png", new DateTime(2024, 6, 7, 0, 0, 0, 0, DateTimeKind.Unspecified) }
                });

            migrationBuilder.InsertData(
                table: "Organizacije",
                columns: new[] { "ID", "Adresa", "Email", "GradID", "Link", "Naziv", "Telefon" },
                values: new object[,]
                {
                    { 1, "Maršala Tita 5, Sarajevo", "contact@ithubsarajevo.com", 7, "www.ithubsarajevo.com", "IT Hub Sarajevo", "033-987-654" },
                    { 2, "Stjepana Radića 10, Mostar", "support@msmostar.com", 6, "www.msmostar.com", "Marketing Solutions Mostar", "036-456-789" },
                    { 3, "Maršala Tita 15, Sarajevo", "info@finconsult.ba", 7, "www.finconsult.ba", "FinConsult Sarajevo", "033-123-456" },
                    { 4, "Kralja Tomislava 22, Mostar", "contact@dmmostar.com", 6, "www.dmmostar.com", "DigitalMarketing", "036-234-567" },
                    { 5, "Šetalište Slana Banja 7, Tuzla", "support@techhubtuzla.com", 8, "www.techhubtuzla.com", "TechHub Tuzla", "035-567-890" },
                    { 6, "Titova 21, Zenica", "info@hrsolutionszenica.com", 9, "www.hrsolutionszenica.com", "HR Solutions Zenica", "032-345-678" },
                    { 7, "Zmaja od Bosne 45, Sarajevo", "contact@financexperts.ba", 7, "www.financexperts.ba", "Finance Experts", "033-987-654" },
                    { 8, "Kralja Petra I Karađorđevića 10, Banja Luka", "info@creativedesignbl.com", 1, "www.creativedesignbl.com", "Creative Design Studio", "051-456-789" },
                    { 9, "Zeleni Val 3, Bihać", "contact@tourismsolutionsbihac.com", 2, "www.tourismsolutionsbihac.com", "Tourism Solutions", "037-123-456" }
                });

            migrationBuilder.InsertData(
                table: "Smjestaji",
                columns: new[] { "ID", "Adresa", "DodatneUsluge", "fitness_centar", "GradID", "Naziv", "Opis", "parking", "restoran", "TipSmjestajaID", "usluge_prijevoza", "wi_fi" },
                values: new object[,]
                {
                    { 1, "Adresa 1", null, true, 7, "Hotel Sarajevo", "Moderan hotel u srcu Sarajeva, nudi savremene sobe, restoran i wellness centar. Idealno za poslovne i turističke posjete.", true, true, 1, true, true },
                    { 2, "Adresa 3", null, false, 6, "Apartman Mostar", "Opis apartmana u Mostaru", false, false, 2, false, true },
                    { 3, "Adresa 4", null, false, 2, "Apartman Green", "Komforan apartman sa velikom terasom.", false, false, 2, false, true },
                    { 4, "Adresa 5", "Bazen, sauna", true, 5, "Villa Luxury", "Ekskluzivna vila sa bazenom i luksuznim sadržajima.", true, false, 1, true, true },
                    { 5, "Adresa 5", "Spa, bazen, sauna", true, 9, "Hotel Lux", "Ekskluzivni hotel sa luksuznim sadržajima i uslugama.", true, true, 1, true, true }
                });

            migrationBuilder.InsertData(
                table: "Stipenditori",
                columns: new[] { "ID", "Adresa", "Email", "GradID", "Link", "Naziv", "TipUstanove" },
                values: new object[,]
                {
                    { 1, "Sarajevo, Bosna i Hercegovina", "erasmus@ec.europa.eu", 7, "www.erasmusplus.com", "Erasmus+ Program", "Program" },
                    { 2, "Banja Luka, Bosna i Hercegovina", "info@fondacijaobrazovanja.ba", 1, "www.fondacijaobrazovanja.ba", "Fondacija za obrazovanje", "Fondacija" },
                    { 3, "Tuzla, Bosna i Hercegovina", "kontakt@istrazivackeprojekt.com", 8, "www.istrazivackeprojekt.com", "Stipendije za istraživačke projekte Tuzla", "Organizacija" }
                });

            migrationBuilder.InsertData(
                table: "Univerziteti",
                columns: new[] { "ID", "Email", "GradID", "Link", "Logo", "Naziv", "Skracenica", "Slika", "Telefon" },
                values: new object[,]
                {
                    { 1, "info@unsa.ba", 7, "www.unsa.ba", null, "Univerzitet u Sarajevu", "UNSA", null, "033-123-456" },
                    { 2, "info@unmo.ba", 6, "www.unmo.ba", null, "Univerzitet \"Džemal Bijedić\"", "UNMO", null, "036-123-456" },
                    { 3, "info@untz.ba", 8, "www.untz.ba", null, "Univerzitet u Tuzli", "UNTZ", null, "035-123-456" }
                });

            migrationBuilder.InsertData(
                table: "Fakulteti",
                columns: new[] { "ID", "Adresa", "Email", "Link", "Logo", "Naziv", "Opis", "Skracenica", "Slika", "Telefon", "UniverzitetID" },
                values: new object[,]
                {
                    { 1, "Adresa 1", "etf@unsa.com", "https://www.etf.unsa.ba/", null, "Elektrotehnički fakultet", null, "ETF", null, "123-456", 1 },
                    { 2, "Adresa 2", "mf@unsa.com", "https://www.mf.unsa.ba/", null, "Medicinski fakultet", null, "MF", null, "123-457", 1 },
                    { 3, "Adresa 3", "fit@unmo.com", "https://www.fit.ba/", null, "Fakultet informacijskih tehnologija", null, "FIT", null, "123-458", 2 }
                });

            migrationBuilder.InsertData(
                table: "Prakse",
                columns: new[] { "ID", "Benefiti", "KrajPrakse", "Kvalifikacije", "OrganizacijaID", "Placena", "PocetakPrakse", "StatusID" },
                values: new object[,]
                {
                    { 1, "Besplatan ručak", new DateTime(2024, 9, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Poznavanje rada na računaru", 1, true, new DateTime(2024, 7, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 2 },
                    { 2, "Besplatan prevoz", new DateTime(2024, 10, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Poznavanje programiranja", 2, false, new DateTime(2024, 8, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 2 },
                    { 5, "Mentorska podrška", new DateTime(2024, 10, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Iskustvo u programiranju", 3, true, new DateTime(2024, 8, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 2 },
                    { 6, "Praktično iskustvo u HR-u", new DateTime(2024, 11, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Osnove regrutacije i upravljanja talentima", 4, false, new DateTime(2024, 9, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 2 },
                    { 7, "Mentorska podrška", new DateTime(2024, 10, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), "Osnovno znanje financijske analize", 5, true, new DateTime(2024, 8, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 2 },
                    { 8, "Rad u kreativnom timu", new DateTime(2024, 11, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Osnovno znanje dizajna", 8, false, new DateTime(2024, 9, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 2 },
                    { 9, "Iskustvo u radu sa gostima", new DateTime(2024, 11, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), "Poznavanje turizma i ugostiteljstva", 9, true, new DateTime(2024, 9, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 2 }
                });

            migrationBuilder.InsertData(
                table: "Slike",
                columns: new[] { "SlikaID", "Naziv", "SmjestajID", "SmjestajnaJedinicaID" },
                values: new object[,]
                {
                    { 1, "hotel1.jpg", 1, null },
                    { 4, "hotel2.jpg", 2, null },
                    { 5, "hotel3.jpg", 3, null },
                    { 13, "hotel2.jpg", 1, null },
                    { 14, "hotel3.jpg", 3, null },
                    { 15, "hotel2.jpg", 4, null }
                });

            migrationBuilder.InsertData(
                table: "SmjestajnaJedinica",
                columns: new[] { "ID", "Cijena", "DodatneUsluge", "Kapacitet", "KlimaUredjaj", "Kuhinja", "Naziv", "Opis", "SmjestajID", "Terasa", "Tv" },
                values: new object[,]
                {
                    { 1, 50.00m, null, 2, true, true, "Standardna Soba", "Standardna soba sa osnovnim sadržajima.", 1, false, true },
                    { 2, 80.00m, "Uključen doručak", 3, true, true, "Deluxe Soba", "Deluxe soba sa dodatnim uslugama.", 1, true, true },
                    { 3, 120.00m, "Uključeni doručak i večera", 4, true, true, "Porodični Apartman", "Prostrani apartman pogodan za porodice.", 2, true, true },
                    { 4, 70.00m, null, 2, true, true, "Apartman", "Kompaktan apartman idealan za kraći boravak.", 3, false, true },
                    { 5, 200.00m, "Uključen doručak i večera", 4, true, true, "Luksuzni apartman", "Luksuzan apartman sa prostranom terasom i pogledom na grad.", 4, true, true },
                    { 6, 300.00m, "Privatni bazen, sauna", 6, true, true, "Penthouse", "Penthouse sa privatnim bazenom i ekskluzivnim sadržajima.", 4, true, true },
                    { 7, 40.00m, null, 2, false, false, "Ekonomična soba", "Jednostavna soba za kraće boravke po pristupačnoj cijeni.", 5, false, true },
                    { 8, 250.00m, "Uključeni svi obroci", 3, true, true, "Executive suite", "Ekskluzivan suite sa vrhunskim sadržajima.", 5, true, true }
                });

            migrationBuilder.InsertData(
                table: "Stipendije",
                columns: new[] { "ID", "BrojStipendisata", "Iznos", "Izvor", "Kriterij", "NivoObrazovanja", "PotrebnaDokumentacija", "StatusID", "StipenditorID", "Uslovi" },
                values: new object[,]
                {
                    { 3, 5, 1200.0, "Erasmus+ Program", "Akademski uspjeh i preporuke", "Studije", "Motivaciono pismo, akademski transkript", 2, 1, "Uslov za prijavu na Erasmus+ program" },
                    { 4, 10, 1500.0, "Fondacija za obrazovanje", "Izvrsnost u akademskom radu", "Srednje škole i univerzitet", "Akademski transkript, preporuka profesora", 2, 2, "Visoki akademski rezultati" },
                    { 10, 7, 2000.0, "Stipendije za master studije", "Odličan akademski uspjeh", "Master studije", "Prijava za stipendiju, akademski transkript", 2, 3, "Studije u inostranstvu" },
                    { 11, 8, 1800.0, "Stipendije za tehničke nauke", "Visoki akademski rezultati u tehničkim naukama", "Studije", "Akademski transkript, preporuka profesora", 2, 1, "Izuzetni rezultati u tehničkim naukama" },
                    { 12, 10, 1200.0, "Stipendije za socijalno ugrožene", "Dokaz o socijalnom statusu", "Studije", "Dokumentacija o socijalnom statusu, akademski transkript", 2, 2, "Socijalno ugroženi studenti" },
                    { 13, 5, 1500.0, "Stipendije za istraživačke projekte", "Inovativni istraživački rad", "Studije", "Opis istraživačkog projekta, akademski transkript", 2, 3, "Rad na istraživačkom projektu" },
                    { 14, 5, 1500.0, "Erasmus+ program", "Odličan akademski uspjeh", "Studije", "Motivaciono pismo, akademski transkript", 2, 1, "Studije u inostranstvu kroz Erasmus+" }
                });

            migrationBuilder.InsertData(
                table: "Slike",
                columns: new[] { "SlikaID", "Naziv", "SmjestajID", "SmjestajnaJedinicaID" },
                values: new object[,]
                {
                    { 2, "apartment_a1.jpg", null, 1 },
                    { 3, "apartment_a2.jpg", null, 1 },
                    { 6, "ap1.jpg", null, 4 },
                    { 7, "ap2.jpg", null, 5 },
                    { 8, "ap4.jpg", null, 6 },
                    { 9, "ap6.jpg", null, 6 },
                    { 10, "ap1.jpg", null, 1 },
                    { 11, "ap2.jpg", null, 4 },
                    { 12, "ap9.jpg", null, 3 }
                });

            migrationBuilder.InsertData(
                table: "SmjeroviFakulteti",
                columns: new[] { "ID", "FakultetID", "SmjerID" },
                values: new object[,]
                {
                    { 1, 3, 1 },
                    { 2, 3, 2 },
                    { 3, 1, 1 },
                    { 4, 1, 4 },
                    { 5, 2, 5 }
                });

            migrationBuilder.InsertData(
                table: "Studenti",
                columns: new[] { "ID", "BrojIndeksa", "FakultetID", "GodinaStudija", "NacinStudiranjaID", "ProsjecnaOcjena", "SmjerID", "Status" },
                values: new object[,]
                {
                    { 2, "IB200002", 3, 4, 1, 10.00m, 1, true },
                    { 3, "IB200003", 3, 4, 1, 10.00m, 1, true },
                    { 4, "IB210004", 2, 3, 1, 9.50m, 5, true },
                    { 5, "IB210005", 1, 3, 2, 9.75m, 1, true },
                    { 6, "IB220006", 3, 2, 1, 8.90m, 2, true },
                    { 7, "IB220007", 1, 2, 2, 8.50m, 4, true },
                    { 8, "IB230008", 3, 1, 1, 8.00m, 1, true },
                    { 9, "IB230009", 2, 1, 2, 7.80m, 5, true }
                });

            migrationBuilder.InsertData(
                table: "Ocjene",
                columns: new[] { "ID", "Ocjena", "PostId", "PostType", "StudentId" },
                values: new object[,]
                {
                    { 1, 5m, 1, "internship", 2 },
                    { 2, 5m, 2, "internship", 2 },
                    { 3, 4m, 1, "internship", 3 },
                    { 4, 3m, 2, "internship", 3 },
                    { 5, 5m, 5, "internship", 4 },
                    { 6, 4m, 6, "internship", 4 },
                    { 7, 3m, 7, "internship", 5 },
                    { 8, 5m, 8, "internship", 5 },
                    { 9, 4m, 9, "internship", 6 },
                    { 10, 3m, 1, "internship", 6 },
                    { 11, 5m, 2, "internship", 7 },
                    { 12, 4m, 5, "internship", 7 },
                    { 13, 3m, 6, "internship", 8 },
                    { 14, 5m, 7, "internship", 8 },
                    { 15, 4m, 8, "internship", 9 },
                    { 16, 5m, 9, "internship", 9 },
                    { 17, 3m, 5, "internship", 2 },
                    { 18, 5m, 6, "internship", 3 },
                    { 19, 4m, 7, "internship", 4 },
                    { 20, 5m, 8, "internship", 5 },
                    { 21, 5m, 3, "scholarship", 2 },
                    { 22, 4m, 4, "scholarship", 3 },
                    { 23, 5m, 10, "scholarship", 4 },
                    { 24, 3m, 11, "scholarship", 5 },
                    { 25, 5m, 12, "scholarship", 6 },
                    { 26, 4m, 13, "scholarship", 7 },
                    { 27, 5m, 14, "scholarship", 8 },
                    { 28, 3m, 3, "scholarship", 9 },
                    { 29, 5m, 4, "scholarship", 2 },
                    { 30, 5m, 3, "scholarship", 4 },
                    { 31, 5m, 11, "scholarship", 4 },
                    { 32, 3m, 12, "scholarship", 5 },
                    { 33, 5m, 13, "scholarship", 6 },
                    { 34, 4m, 14, "scholarship", 7 },
                    { 35, 5m, 3, "scholarship", 8 },
                    { 36, 3m, 4, "scholarship", 9 },
                    { 37, 5m, 10, "scholarship", 7 },
                    { 38, 4m, 11, "scholarship", 3 },
                    { 39, 5m, 12, "scholarship", 4 },
                    { 40, 3m, 13, "scholarship", 5 },
                    { 41, 5m, 1, "accommodation", 2 },
                    { 42, 4m, 2, "accommodation", 3 },
                    { 43, 3m, 3, "accommodation", 4 },
                    { 44, 5m, 4, "accommodation", 5 },
                    { 45, 4m, 5, "accommodation", 6 },
                    { 46, 5m, 1, "accommodation", 7 },
                    { 47, 5m, 2, "accommodation", 8 },
                    { 48, 4m, 3, "accommodation", 9 },
                    { 49, 3m, 4, "accommodation", 6 },
                    { 50, 5m, 5, "accommodation", 3 },
                    { 51, 4m, 1, "accommodation", 4 },
                    { 52, 3m, 2, "accommodation", 5 },
                    { 53, 5m, 3, "accommodation", 6 },
                    { 54, 4m, 4, "accommodation", 7 },
                    { 55, 5m, 5, "accommodation", 8 },
                    { 56, 5m, 1, "accommodation", 9 },
                    { 57, 5m, 2, "accommodation", 2 },
                    { 58, 4m, 3, "accommodation", 3 },
                    { 59, 3m, 4, "accommodation", 4 },
                    { 60, 5m, 5, "accommodation", 5 }
                });

            migrationBuilder.InsertData(
                table: "PrijavePraksa",
                columns: new[] { "PraksaId", "StudentId", "Certifikati", "CV", "PropratnoPismo", "StatusID" },
                values: new object[,]
                {
                    { 1, 2, "Certifikati_studenta_1.pdf", "CV_studenta_1.pdf", "Propratno pismo studenta 1 za praksu 1", 2 },
                    { 2, 3, "Certifikati_studenta_2.pdf", "CV_studenta_2.pdf", "Propratno pismo studenta 2 za praksu 2", 2 }
                });

            migrationBuilder.InsertData(
                table: "PrijaveStipendija",
                columns: new[] { "StipendijaID", "StudentId", "CV", "Dokumentacija", "ProsjekOcjena", "StatusID" },
                values: new object[,]
                {
                    { 3, 2, "CV_studenta_1.pdf", "Dokumentacija_studenta_1.pdf", 8.5m, 2 },
                    { 4, 3, "CV_studenta_2.pdf", "Dokumentacija_studenta_2.pdf", 9.0m, 2 }
                });

            migrationBuilder.InsertData(
                table: "Rezervacije",
                columns: new[] { "Id", "BrojOsoba", "Cijena", "DatumOdjave", "DatumPrijave", "Napomena", "SmjestajnaJedinicaId", "StatusId", "StudentId" },
                values: new object[,]
                {
                    { 1, 2, 200.00m, new DateTime(2024, 6, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), "Napomena o rezervaciji", 1, 2, 2 },
                    { 2, 3, 300.00m, new DateTime(2024, 7, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 7, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), null, 2, 2, 3 }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Grad",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Grad",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Kategorija",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "NacinStudiranja",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Objave",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Objave",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Objave",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 20);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 21);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 22);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 23);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 24);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 25);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 26);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 27);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 28);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 29);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 30);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 31);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 32);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 33);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 34);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 35);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 36);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 37);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 38);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 39);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 40);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 41);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 42);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 43);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 44);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 45);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 46);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 47);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 48);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 49);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 50);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 51);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 52);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 53);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 54);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 55);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 56);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 57);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 58);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 59);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "ID",
                keyValue: 60);

            migrationBuilder.DeleteData(
                table: "Organizacije",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Organizacije",
                keyColumn: "ID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Prakse",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Prakse",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Prakse",
                keyColumn: "ID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Prakse",
                keyColumn: "ID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Prakse",
                keyColumn: "ID",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "PrijavePraksa",
                keyColumns: new[] { "PraksaId", "StudentId" },
                keyValues: new object[] { 1, 2 });

            migrationBuilder.DeleteData(
                table: "PrijavePraksa",
                keyColumns: new[] { "PraksaId", "StudentId" },
                keyValues: new object[] { 2, 3 });

            migrationBuilder.DeleteData(
                table: "PrijaveStipendija",
                keyColumns: new[] { "StipendijaID", "StudentId" },
                keyValues: new object[] { 3, 2 });

            migrationBuilder.DeleteData(
                table: "PrijaveStipendija",
                keyColumns: new[] { "StipendijaID", "StudentId" },
                keyValues: new object[] { 4, 3 });

            migrationBuilder.DeleteData(
                table: "Rezervacije",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Rezervacije",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Slike",
                keyColumn: "SlikaID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Slike",
                keyColumn: "SlikaID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Slike",
                keyColumn: "SlikaID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Slike",
                keyColumn: "SlikaID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Slike",
                keyColumn: "SlikaID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Slike",
                keyColumn: "SlikaID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Slike",
                keyColumn: "SlikaID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Slike",
                keyColumn: "SlikaID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Slike",
                keyColumn: "SlikaID",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Slike",
                keyColumn: "SlikaID",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Slike",
                keyColumn: "SlikaID",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Slike",
                keyColumn: "SlikaID",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Slike",
                keyColumn: "SlikaID",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Slike",
                keyColumn: "SlikaID",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Slike",
                keyColumn: "SlikaID",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Smjerovi",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "SmjeroviFakulteti",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "SmjeroviFakulteti",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "SmjeroviFakulteti",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "SmjeroviFakulteti",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "SmjeroviFakulteti",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "SmjestajnaJedinica",
                keyColumn: "ID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "SmjestajnaJedinica",
                keyColumn: "ID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "StatusOglasi",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "StatusOglasi",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "StatusOglasi",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "StatusPrijave",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "StatusPrijave",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "StatusPrijave",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Stipendije",
                keyColumn: "ID",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Stipendije",
                keyColumn: "ID",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Stipendije",
                keyColumn: "ID",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Stipendije",
                keyColumn: "ID",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Stipendije",
                keyColumn: "ID",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Univerziteti",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Kategorija",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Kategorija",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Kategorija",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Organizacije",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Organizacije",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Organizacije",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Organizacije",
                keyColumn: "ID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Organizacije",
                keyColumn: "ID",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Prakse",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Prakse",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Smjestaji",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "SmjestajnaJedinica",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "SmjestajnaJedinica",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "SmjestajnaJedinica",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "SmjestajnaJedinica",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "SmjestajnaJedinica",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "SmjestajnaJedinica",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "StatusPrijave",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Stipendije",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Stipendije",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Stipenditori",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Studenti",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Studenti",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Studenti",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Studenti",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Studenti",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Studenti",
                keyColumn: "ID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Studenti",
                keyColumn: "ID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Studenti",
                keyColumn: "ID",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Uloge",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Fakulteti",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Fakulteti",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Fakulteti",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Grad",
                keyColumn: "ID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Grad",
                keyColumn: "ID",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "NacinStudiranja",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "NacinStudiranja",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Oglasi",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Organizacije",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Organizacije",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Smjerovi",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Smjerovi",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Smjerovi",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Smjerovi",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Smjestaji",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Smjestaji",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Smjestaji",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Smjestaji",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "StatusOglasi",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Stipenditori",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Stipenditori",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Grad",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Grad",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Grad",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "TipSmjestaja",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "TipSmjestaja",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Uloge",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Univerziteti",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Univerziteti",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Grad",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Grad",
                keyColumn: "ID",
                keyValue: 7);
        }
    }
}
