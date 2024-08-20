namespace StudentOglasi.Model
{
    public partial class Ocjene
    {

        public int PostId { get; set; }

        public string PostType { get; set; } = null!;

        public int StudentId { get; set; }

        public decimal Ocjena { get; set; }
    }
}