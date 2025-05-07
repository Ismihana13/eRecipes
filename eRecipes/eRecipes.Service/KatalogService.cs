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
    }
}
