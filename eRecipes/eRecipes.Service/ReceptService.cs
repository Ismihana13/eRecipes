using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service.Database;
using eRecipes.Service.ReceptStateMachine;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using System.Security.Claims;

namespace eRecipes.Service
{
    public class ReceptService : BaseCRUDService<Model.Recept, ReceptSearchObject, Database.Recept, ReceptInsertRequest, ReceptUpdateRequest>, IReceptService
    {
        
        ILogger<ReceptService> _logger;
        public BaseReceptState BaseReceptState { get; set; }
       
        public ReceptService(ERecipesContext context, IMapper mapper, BaseReceptState baseReceptState, ILogger<ReceptService> logger) : base(context, mapper) {
            BaseReceptState = baseReceptState;
            _logger = logger;
           
           
        }

        public override IQueryable<Database.Recept> AddFilter(ReceptSearchObject search, IQueryable<Database.Recept> query)
        {
            var filteredQuery = base.AddFilter(search, query);
            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery.Where(x => x.Naziv.ToLower().StartsWith(search.FTS.ToLower()));
            }
            if (search.Status.HasValue)
            {
                filteredQuery = filteredQuery.Where(x => x.Status == search.Status);
            }
            filteredQuery = filteredQuery.Include(r => r.VrstaJela)
                                 .Include(r => r.Kategorija).Include(r=>r.Korisnik);
            return filteredQuery;
        }

        public override void BeforeInsert(ReceptInsertRequest request, Recept entity)
        {

        }


        public override Model.Recept Insert(ReceptInsertRequest request)
        {
            var state = BaseReceptState.CreateState("initial");
            return state.Insert(request);
        }
        public override Model.Recept Update(int id, ReceptUpdateRequest request)
        {
            var entity=GetById(id);
            var state = BaseReceptState.CreateState(entity.StateMachine);
            return state.Update(id, request);
        }
        

        public Model.Recept Acivate(int id)
        {
            var entity = GetById(id);
            var state = BaseReceptState.CreateState(entity.StateMachine);
            return state.Activate(id);
        }

        public Model.Recept Edit(int id)
        {
            var entity = GetById(id);
            var state = BaseReceptState.CreateState(entity.StateMachine);
            return state.Edit(id);
        }

        public Model.Recept Hide(int id)
        {
            var entity = GetById(id);
            var state = BaseReceptState.CreateState(entity.StateMachine);
            return state.Hide(id);
        }

        public List<string> AllowedActions(int id)
        {
            _logger.LogInformation($"Allowed actions called for: {id}");
            if(id<=0)
            {
                var state = BaseReceptState.CreateState("initial");
                return state.AllowedActions(null);
            }
            else
            {
                var entity = Context.Recepts.Find(id);
                var state = BaseReceptState.CreateState(entity.StateMachine);
                return state.AllowedActions(entity);
            }
        }
        public Model.Recept DeleteRecept(int id)
        {
            var set = Context.Set<Database.Recept>();

            var entity = set.Find(id);

            entity.Status = false;

            Context.SaveChanges();

            return Mapper.Map<Model.Recept>(entity);
        }

        public List<Model.ReceptSastojak> GetSastojciForRecept(int receptId)
        {
            var receptSastojci = Context.ReceptSastojaks
                                         .Where(rs => rs.ReceptId == receptId)
                                         .Include(rs => rs.Sastojak)  
                                         .ToList();
            return Mapper.Map<List<Model.ReceptSastojak>>(receptSastojci);
        }
    }
}
