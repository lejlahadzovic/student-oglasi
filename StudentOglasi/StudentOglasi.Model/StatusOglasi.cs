namespace StudentOglasi.Model
{
    public partial class StatusOglasi
    {
        public int Id { get; set; }

        public string Naziv { get; set; } = null!;

        public string? Opis { get; set; }
    }
}