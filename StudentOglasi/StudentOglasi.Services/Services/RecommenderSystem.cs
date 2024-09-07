using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Microsoft.ML.Trainers;
using StudentOglasi.Model;
using StudentOglasi.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.Services
{
    public class RecommenderSystem
    {
        private static MLContext _mlContext;
        private static ITransformer _model;
        private static PredictionEngine<RecommendationInput, RecommendationOutput> _predictionEngine;
        private static StudentoglasiContext _context;
        private static readonly object isLocked = new object();

        public RecommenderSystem(StudentoglasiContext context)
        {
            _context = context;

            lock (isLocked)
            {
                if (_mlContext == null)
                {
                    _mlContext = new MLContext();

                    var trainingData = GetTrainingData().Result;
                    _model = TrainModel(trainingData);

                    _predictionEngine = _mlContext.Model.CreatePredictionEngine<RecommendationInput, RecommendationOutput>(_model);
                }
            }
        }

        private async Task<IDataView> GetTrainingData()
        {
            var ratings = await _context.Ocjenes
                .Select(o => new RecommendationInput
                {
                    StudentId = o.StudentId,
                    CombinedKey = $"{o.PostId}_{o.PostType}",
                    Ocjena = (float)o.Ocjena,
                }).ToListAsync();

            return _mlContext.Data.LoadFromEnumerable(ratings);
        }

        private ITransformer TrainModel(IDataView data)
        {
            var pipeline = _mlContext.Transforms.Conversion.MapValueToKey("UserIdEncoded", nameof(RecommendationInput.StudentId))
                .Append(_mlContext.Transforms.Conversion.MapValueToKey("PostIdEncoded", nameof(RecommendationInput.CombinedKey)))
                .Append(_mlContext.Recommendation().Trainers.MatrixFactorization(new MatrixFactorizationTrainer.Options
                {
                    MatrixColumnIndexColumnName = "UserIdEncoded",
                    MatrixRowIndexColumnName = "PostIdEncoded",
                    LabelColumnName = nameof(RecommendationInput.Ocjena),
                    NumberOfIterations = 20,
                    ApproximationRank = 100
                }));

            return pipeline.Fit(data);
        }

        public async Task<List<int>> GetRecommendedPostIds(int studentId, string postType)
        {
            var ocijenjeniPostovi = await _context.Ocjenes
                .Where(o => o.StudentId == studentId && o.PostType == postType)
                .Select(o => o.PostId)
                .ToListAsync();

            var postIdsToPredict = new List<int>();

            if (postType == "internship" || postType == "scholarship")
            {
                postIdsToPredict = await _context.Oglasis
                    .Where(o => ((postType == "internship" && o.Prakse != null) ||
                                 (postType == "scholarship" && o.Stipendije != null)) &&
                                !ocijenjeniPostovi.Contains(o.Id))
                    .Select(o => o.Id)
                    .ToListAsync();
            }
            else if (postType == "accommodation")
            {
                postIdsToPredict = await _context.Smjestajis
                    .Where(s => !ocijenjeniPostovi.Contains(s.Id))
                    .Select(s => s.Id)
                    .ToListAsync();
            }
            else
            {
                throw new ArgumentException("Invalid post type provided");
            }

            var recommendedPosts = new List<(int PostId, float Score)>();

            foreach (var postId in postIdsToPredict)
            {
                var combinedKey = $"{postId}_{postType}";
                var prediction = _predictionEngine.Predict(new RecommendationInput { StudentId = studentId, CombinedKey = combinedKey});

                if (prediction.Score > 3)
                {
                    recommendedPosts.Add((postId, prediction.Score));
                }
            }

            var topRecommendedPosts = recommendedPosts
                .OrderByDescending(x => x.Score)
                .Take(3)
                .Select(x => x.PostId)
                .ToList();

            return topRecommendedPosts;
        }
    }
}
