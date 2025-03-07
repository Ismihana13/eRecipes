using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service
{
    public class SastojakService : BaseCRUDService<Model.Sastojak, SastojakSearchObject, Database.Sastojak, SastojakUpsertRequest, SastojakUpsertRequest>, ISastojakService
    {
        public SastojakService(ERecipesContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override void BeforeInsert(SastojakUpsertRequest request, Sastojak entity)
        {
            var existingSastojak= Context.Sastojaks.FirstOrDefault(x=>x.Naziv.ToLower()==request.Naziv.ToLower());
            if (existingSastojak != null)
            {
                throw new Exception($"Sastojak s nazivom '{request.Naziv}' već postoji u bazi.");
            }
            base.BeforeInsert(request, entity);
        }
    }
}
