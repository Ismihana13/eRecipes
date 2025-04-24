using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using RabbitMQ.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service
{
    public class UplataService : BaseCRUDService<Model.Uplata, UplataSearchObject, Database.Uplata, UplataUpsertRequest, UplataUpsertRequest>, IUplataService
    {
        public UplataService(ERecipesContext context, IMapper mapper) : base(context, mapper)
        {
            
        }
        public override IQueryable<Uplata> AddFilter(UplataSearchObject search, IQueryable<Uplata> query)
        {
            query = query.Include(u => u.Korisnik);
            return base.AddFilter(search, query);
        }
      
    }
}
