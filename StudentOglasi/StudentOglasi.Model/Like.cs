namespace StudentOglasi.Model
{
    public partial class Like
    {
        public int KorisnikId { get; set; }
        public int ItemId { get; set; }
        public string? ItemType { get; set; }
    }
}