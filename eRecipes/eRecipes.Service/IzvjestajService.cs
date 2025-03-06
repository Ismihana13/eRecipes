using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service
{
    public class IzvjestajService : IIzvjestajService
    {
        private readonly ERecipesContext _context;
        private readonly IMapper _mapper;
        public IzvjestajService(ERecipesContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<List<Model.Izvjestaj>> GetIzvjestajList(IzvjestajSearchObject? search = null)
        {
            var query = _context.Izvjestajs.Include(i => i.Recept).AsQueryable();
            if (search?.Naziv != null)
            {
                query = query.Where(i => i.Recept.Naziv.Contains(search.Naziv));
            }
            var result = await query.ToListAsync();

            return _mapper.Map<List<Model.Izvjestaj>>(result);
        }

        public async Task<Model.Izvjestaj> Insert(IzvjestajInsert insert)
        {
            var entity = new Database.Izvjestaj
            {
                ReceptId = insert.ReceptId,
                DatumIzvjestaja = DateTime.Now,
                BrojOmiljenih = await _context.OmiljeniRecepts
             .Where(o => o.ReceptId == insert.ReceptId)
             .Select(o => o.KorisnikId)
             .Distinct()
             .CountAsync(),  

                BrojLajkova = await _context.Lajkovis
             .Where(l => l.ReceptId == insert.ReceptId)
             .CountAsync()  
            };
            _context.Izvjestajs.Add(entity);
            await _context.SaveChangesAsync();

            return _mapper.Map<Model.Izvjestaj>(entity);
        }
    }
}
