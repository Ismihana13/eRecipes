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
    public interface IReceptSastojakService 
    {
        Task AddReceptSastojakAsync(int receptId, int sastojakId);
    }
}
