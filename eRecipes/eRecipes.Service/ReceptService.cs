using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service.Database;
using eRecipes.Service.ReceptStateMachine;
using MapsterMapper;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service
{
    public class ReceptService : BaseCRUDService<Model.Recept, ReceptSearchObject, Database.Recept, ReceptInsertRequest, ReceptUpdateRequest>, IReceptService
    {
        public BaseReceptState BaseReceptState { get; set; }

        public ReceptService(ERecipesContext context, IMapper mapper, BaseReceptState baseReceptState) : base(context, mapper) {
            BaseReceptState = baseReceptState;
        }

        public override IQueryable<Database.Recept> AddFilter(ReceptSearchObject search, IQueryable<Database.Recept> query)
        {
            var filteredQuery = base.AddFilter(search, query);
            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery.Where(x => x.Naziv.Contains(search.FTS));
            }
            return filteredQuery;
        }

        public override void BeforeInsert(ReceptInsertRequest request, Recept entity)
        {
            base.BeforeInsert(request, entity);
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
    }
}
