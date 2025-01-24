using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service
{
    public class ReceptSastojakService : IReceptSastojakService
    {
        public ERecipesContext Context { get; set; }
        public ReceptSastojakService(ERecipesContext context, IMapper mapper) 
        {
            Context = context;
        }

        public async Task AddReceptSastojakAsync(int receptId, int sastojakId)
        {
            var receptSastojak = new ReceptSastojak
            {
                ReceptId = receptId,
                SastojakId = sastojakId
            };

            // Dodavanje objekta u kontekst
            await Context.ReceptSastojaks.AddAsync(receptSastojak);

            // Spremanje promena u bazu podataka
            await Context.SaveChangesAsync();
        }
    }
}
