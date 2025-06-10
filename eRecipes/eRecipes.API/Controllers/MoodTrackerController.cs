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
    public class MoodTrackerController : BaseCURDController<MoodTracker30012025, MoodTrackerSearchObject, MoodTrackerUpsertRequest, MoodTrackerUpsertRequest>
    {
        public MoodTrackerController(IMoodTrackerService service) : base(service) { }

       
    }
}
