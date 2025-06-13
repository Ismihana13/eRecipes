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
    public class ToDo4924Service : BaseCRUDService<Model.ToDo4924, ToDo4924SearchObject, Database.ToDo4924, ToDo4924UpsertRequest, ToDo4924UpsertRequest>, IToDo4924Service
    {
        public ToDo4924Service(ERecipesContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<ToDo4924> AddFilter(ToDo4924SearchObject search, IQueryable<ToDo4924> query)
        {
            var filteredQuery= base.AddFilter(search, query);
            if (search?.KorisnikId != null)
            {
                filteredQuery=filteredQuery.Where(x=>x.KorisnikId==search.KorisnikId);
            }
            if (search?.StatusAktivnosti != null)
            {
                filteredQuery=filteredQuery.Where(x=>x.Status.Equals(search.StatusAktivnosti.ToString()));
            }
            if (search?.DatumVazenja != null)
            {
                filteredQuery = filteredQuery.Where(x => x.DatumIzvrsenja.Date < search.DatumVazenja.Value.Date);
            }
            filteredQuery = filteredQuery.Include(x => x.Korisnik);

            return filteredQuery;
        }
    }
}
