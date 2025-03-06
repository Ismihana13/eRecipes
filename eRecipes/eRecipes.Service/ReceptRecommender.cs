using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.ML;
using Microsoft.ML.Data;
using eRecipes.Service.Database;
using Microsoft.ML.Trainers;

public class ReceptRecommender
{
    private static MLContext mlContext = new MLContext();
    private static object isLocked = new object();
    private static ITransformer model = null;
    private readonly ERecipesContext _context;

    public ReceptRecommender(ERecipesContext context)
    {
        _context = context;
    }

    public List<Recept> Recommend(int korisnikId)
    {
        lock (isLocked)
        {
            var interakcije = _context.Lajkovis
                .Select(x => new UserItemEntry
                {
                    UserId = (uint)x.KorisnikId,
                    ItemId = (uint)x.ReceptId,
                    Rating = 1
                })
                .Union(_context.OmiljeniRecepts
                    .Select(x => new UserItemEntry
                    {
                        UserId = (uint)x.KorisnikId,
                        ItemId = (uint)x.ReceptId,
                        Rating = 3 
                    }))
                .ToList();

            if (interakcije.Count == 0)
            {
                return new List<Recept>();
            }

            var trainData = mlContext.Data.LoadFromEnumerable(interakcije);

            var options = new MatrixFactorizationTrainer.Options
            {
                MatrixColumnIndexColumnName = nameof(UserItemEntry.UserId),
                MatrixRowIndexColumnName = nameof(UserItemEntry.ItemId),
                LabelColumnName = "Rating",
                LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass,
                Alpha = 0.01,
                Lambda = 0.025,
                NumberOfIterations = 100,
                C = 0.00001
            };

            var estimator = mlContext.Recommendation().Trainers.MatrixFactorization(options);
            model = estimator.Fit(trainData);
        }

        var sviRecepti = _context.Recepts
            .Where(r => !_context.Lajkovis.Any(l => l.KorisnikId == korisnikId && l.ReceptId == r.ReceptId) &&
                        !_context.OmiljeniRecepts.Any(o => o.KorisnikId == korisnikId && o.ReceptId == r.ReceptId))
            .ToList();

        var predictionResult = new List<Tuple<Recept, float>>();

        foreach (var recept in sviRecepti)
        {
            var predictionEngine = mlContext.Model.CreatePredictionEngine<UserItemEntry, UserBasedPrediction>(model);
            var prediction = predictionEngine.Predict(new UserItemEntry
            {
                UserId = (uint)korisnikId,
                ItemId = (uint)recept.ReceptId
            });

            predictionResult.Add(new Tuple<Recept, float>(recept, prediction.Score));
        }

        return predictionResult.OrderByDescending(x => x.Item2).Select(y => y.Item1).Take(4).ToList();
    }

    public class UserItemEntry
    {
        [KeyType(count: 1000)] 
        public uint UserId { get; set; }

        [KeyType(count: 1000)]
        public uint ItemId { get; set; }

        public float Rating { get; set; }
    }

    public class UserBasedPrediction
    {
        public float Score { get; set; }
    }
}
