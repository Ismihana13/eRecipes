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
    public class MjernaJedinicaController : BaseCURDController<MjernaJedinica, MjernaJedinicaSearchObject, MjernaJedinicaUpsertRequest, MjernaJedinicaUpsertRequest>
    {
        public MjernaJedinicaController(IMjernaJedinicaService service) : base(service) { }
    }
}
