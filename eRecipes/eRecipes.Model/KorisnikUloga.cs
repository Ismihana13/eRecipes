 using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model
{
    public class KorisnikUloga
    {
        public int KorisnikUlogaId { get; set; }

        public int KorisnikId { get; set; }

        public int UlogaId { get; set; }

        public DateTime DatumIzmjene { get; set; }

        public virtual Uloga Uloga { get; set; } = null!;
    }
}
