using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service
{
    public class ReceptService :BaseCRUDService<Model.Recept, ReceptSearchObject, Database.Recept, ReceptInsertRequest,ReceptUpdateRequest>, IReceptService
    {
   
        public ReceptService(ERecipesContext context, IMapper mapper):base (context, mapper) { }

        public override IQueryable<Database.Recept> AddFilter(ReceptSearchObject search, IQueryable<Database.Recept> query)
        {
            var filteredQuery= base.AddFilter(search,query);
            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery=filteredQuery.Where(x=>x.Naziv.Contains(search.FTS));
            }
            return filteredQuery;
        }

        public override void BeforeInsert(ReceptInsertRequest request, Recept entity)
        {
            base.BeforeInsert(request, entity);
        }

    }
}
