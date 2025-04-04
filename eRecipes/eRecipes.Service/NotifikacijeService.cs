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
    public class NotifikacijeService : INotifikacijeService
    {
        public ERecipesContext Context { get; set; }
        public IMapper Mapper { get; set; }
        public NotifikacijeService(ERecipesContext context, IMapper mapper) 
        {
            Context = context;
            Mapper = mapper;
        }

        public Model.Notifikacije Insert(NotifikacijeInsertRequest request)
        {
            var entity = Mapper.Map<Database.Notifikacije>(request);
            entity.DatumSlanja=DateTime.Now;
            entity.Procitano = false;
            Context.Notifikacijes.Add(entity);
            Context.SaveChanges();
            return Mapper.Map<Model.Notifikacije>(entity);
        }

        public List<Model.Notifikacije> Get(NotifikacijeSearchObject search)
        {
            var query = Context.Notifikacijes
                               .OrderByDescending(o => o.DatumSlanja) 
                               .AsQueryable();
            if (search.Procitano != null)
            {
                query = query.Where(o => o.Procitano == search.Procitano);
            }

            var list = query.ToList();

            return Mapper.Map<List<Model.Notifikacije>>(list);
        }

        public Model.Notifikacije Delete(int id)
        {
            var entity = Context.Notifikacijes.Find(id);
            if (entity == null)
                return null;

            Context.Notifikacijes.Remove(entity);
            Context.SaveChanges();
            return Mapper.Map<Model.Notifikacije>(entity);
        }

        public Model.Notifikacije UpdateProcitano(int id, bool procitano)
        {
            var entity = Context.Notifikacijes.Find(id);
            if (entity == null)
                return null;

            entity.Procitano = procitano;
            Context.SaveChanges();

            return Mapper.Map<Model.Notifikacije>(entity);
        }
    }
}
