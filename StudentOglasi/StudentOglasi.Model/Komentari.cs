namespace StudentOglasi.Model
{
    public partial class Komentari
    {
        public int Id { get; set; }
        public int PostId { get; set; }
        public string PostType { get; set; } = null!;
        public int? ParentKomentarId { get; set; }
        public DateTime? VrijemeObjave { get; set; }
        public string Text { get; set; } = null!;
        public List<Komentari>? Odgovori { get; set; } = new List<Komentari>();
        public string Ime { get; set; } = null!;
        public string Prezime { get; set; } = null!;
    }
}