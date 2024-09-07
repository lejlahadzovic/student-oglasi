namespace StudentOglasi.Model
{
    public partial class RecommendationInput
    {
        public int StudentId { get; set; }
        public string CombinedKey { get; set; } = null!;
        public float Ocjena { get; set; }
    }
}