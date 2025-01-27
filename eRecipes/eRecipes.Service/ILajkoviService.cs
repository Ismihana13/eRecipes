using eRecipes.Model;
using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service
{
    public interface ILajkoviService : ICRUDService<Lajkovi, LajkoviSearchObject, LajkoviUpsertRequest, LajkoviUpsertRequest>
    {
        Task<int> GetLikesCountForRecipe(int receptId);
        Task RemoveLiked(int receptId);
        Task<bool> IsLiked(int receptId);
    }
}
