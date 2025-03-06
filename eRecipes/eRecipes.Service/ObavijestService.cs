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
    public class ObavijestService : IObavijestService
    {
        public ERecipesContext Context { get; set; }
        public IMapper Mapper { get; set; }
        public ObavijestService(ERecipesContext context, IMapper mapper) 
        {
            Context = context;
            Mapper = mapper;
        }

        public Model.Obavijest Insert(ObavijestInsertRequest request)
        {
            var entity = Mapper.Map<Database.Obavijest>(request);
            entity.DatumSlanja=DateTime.Now;
            entity.Procitano = false;
            Context.Obavijests.Add(entity);
            Context.SaveChanges();
            return Mapper.Map<Model.Obavijest>(entity);
        }

        public List<Model.Obavijest> Get(ObavijestSearchObject search)
        {
            var query = Context.Obavijests
                               .OrderByDescending(o => o.DatumSlanja) 
                               .AsQueryable();
            if (search.Procitano != null)
            {
                query = query.Where(o => o.Procitano == search.Procitano);
            }

            var list = query.ToList();

            return Mapper.Map<List<Model.Obavijest>>(list);
        }

        public Model.Obavijest Delete(int id)
        {
            var entity = Context.Obavijests.Find(id);
            if (entity == null)
                return null;

            Context.Obavijests.Remove(entity);
            Context.SaveChanges();
            return Mapper.Map<Model.Obavijest>(entity);
        }

        public Model.Obavijest UpdateProcitano(int id, bool procitano)
        {
            var entity = Context.Obavijests.Find(id);
            if (entity == null)
                return null;

            entity.Procitano = procitano;
            Context.SaveChanges();

            return Mapper.Map<Model.Obavijest>(entity);
        }
    }
}
