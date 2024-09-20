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
    public class VrstaJelaService : IVrstaJelaService
    {
        public ERecipesContext Context { get; set; }
        public IMapper Mapper { get; set; }

        public VrstaJelaService(ERecipesContext context, IMapper mapper)
        {
            Context = context;
            Mapper = mapper;
        }
        public virtual List<Model.VrstaJela> GetList(VrstaJelaSearchObject searchObject)
        {
            List<Model.VrstaJela> result = new List<Model.VrstaJela>();

            var query = Context.VrstaJelas.AsQueryable();


            if (!string.IsNullOrWhiteSpace(searchObject?.NazivGTE))
            {
                query = query.Where(x => x.Naziv.Contains(searchObject.NazivGTE));
            }
            if (searchObject?.Page.HasValue == true && searchObject?.PageSize.HasValue == true)
            {
                query = query.Skip(searchObject.Page.Value * searchObject.PageSize.Value).Take(searchObject.PageSize.Value);
            }


            var list = query.ToList();

            result = Mapper.Map(list, result);
            return result;
        }

       
    }
}
