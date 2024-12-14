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
    public class KorisnikUlogaService : BaseCRUDService<Model.KorisnikUloga, KorisnikUlogaSearchObject, Database.KorisnikUloga, KorisnikUlogaUpsertRequest, KorisnikUlogaUpsertRequest>, IKorisnikUlogaService
    {

        public KorisnikUlogaService(ERecipesContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override void BeforeInsert(KorisnikUlogaUpsertRequest request, KorisnikUloga entity)
        {
            base.BeforeInsert(request, entity);

            // Prvo pronađi korisnika koji već ima ulogu
            var korisnikUloga = Context.KorisnikUlogas
                .FirstOrDefault(ku => ku.KorisnikId == request.KorisnikId && ku.UlogaId == request.UlogaId);

            if (korisnikUloga != null)
            {
                // Ako korisnik već ima ovu ulogu, ažuriraj datum izmene
                korisnikUloga.DatumIzmjene = DateTime.Now;

                // Vraćamo korisnika koji je već imao tu ulogu i ne ubacujemo novu
                entity = korisnikUloga; // Ažuriramo entitet umesto da ubacujemo novi
            }
            else
            {
                // Ako korisnik nema ovu ulogu, kreiraj novu ulogu
                entity.DatumIzmjene = DateTime.Now;
            }
        }

    }
}
