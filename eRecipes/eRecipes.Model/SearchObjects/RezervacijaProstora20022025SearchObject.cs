using eRecipes.Service.Helper;
using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.SearchObjects
{
    public class RezervacijaProstora20022025SearchObject : BaseSearchObject
    {
        public int? KorisnikId { get; set; }
        public int? RadniProstorId { get; set; }
        public StatusRezervacije? PretragaStatusRezervacije { get; set; }
    }
}
