using eRecipes.Model;
using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eRecipes.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ToDo4924Controller : BaseCURDController<ToDo4924, ToDo4924SearchObject, ToDo4924UpsertRequest, ToDo4924UpsertRequest>
    {
        public ToDo4924Controller(IToDo4924Service service) : base(service) { }

        
    }
}
