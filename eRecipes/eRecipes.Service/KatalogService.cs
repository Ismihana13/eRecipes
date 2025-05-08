using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using Microsoft.ML;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service
{
    public class KatalogService : BaseCRUDService<Model.Katalog, KatalogSearchObject, Database.Katalog, KatalogUpsertRequest, KatalogUpsertRequest>, IKatalogService
    {
        public KatalogService(ERecipesContext context, IMapper mapper) : base(context, mapper)
        {
        }
        
        public async Task<string> AddReceptToKatalog( int katalogId, List<int> receptIds)
        {
            var katalog= await Context.Katalogs.Include(k=> k.KatalogRecepts)
                                                .FirstOrDefaultAsync(k=>k.KatalogId==katalogId);

            if (katalog == null) {
                return "Katalog nije pronađen.";
            }

            var recepti = await Context.Recepts.Where(r => receptIds.Contains(r.ReceptId)).ToListAsync();
            if (recepti.Count != receptIds.Count)
            {
                return "Neki od recepata nisu pronađeni.";
            }
            var existingReceptIds = katalog.KatalogRecepts.Select(kr => kr.ReceptId).ToList();

            foreach (var receptId in receptIds)
            {
                if (!existingReceptIds.Contains(receptId))
                {
                    var katalogRecept = new KatalogRecept
                    {
                        KatalogId = katalogId,
                        ReceptId = receptId
                    };

                    Context.KatalogRecepts.Add(katalogRecept);
                }
            }
            await Context.SaveChangesAsync();

            return "Recepti su uspješno dodani u katalog.";
        }

        public async Task<eRecipes.Model.Katalog> GetByIdIncludeRecipes(int id)
        {
            var entity = await Context.Katalogs
                .Include(k => k.KatalogRecepts)
                    .ThenInclude(kr => kr.Recept)
                .FirstOrDefaultAsync(k => k.KatalogId == id);

            if (entity == null)
                return null;

            var model = new eRecipes.Model.Katalog
            {
                KatalogId = entity.KatalogId,
                Naziv = entity.Naziv,
                DatumKreiranja = entity.DatumKreiranja,
                Opis = entity.Opis,
                KatalogRecepts = entity.KatalogRecepts.Select(kr => new eRecipes.Model.KatalogRecept
                {
                    KatalogReceptId = kr.KatalogReceptId,
                    KatalogId = kr.KatalogId,
                    ReceptId = kr.ReceptId,
                    Recept = kr.Recept != null ? new eRecipes.Model.Recept
                    {
                        ReceptId = kr.Recept.ReceptId,
                        Naziv = kr.Recept.Naziv,
                        Slika = kr.Recept.Slika,
                        OpisRecepta = kr.Recept.OpisRecepta,
                        OpisPripreme=kr.Recept.OpisPripreme,
                        VrijemePripreme = kr.Recept.VrijemePripreme,
                        DatumObjave = kr.Recept.DatumObjave,
                        Premium = kr.Recept.Premium,
                        VrstaJelaId = kr.Recept.VrstaJelaId,
                        KategorijaId = kr.Recept.KategorijaId,
                        Status = kr.Recept.Status
                    } : null
                }).ToList()
            };

            return model;
        }
    }
}
