using eRecipes.Service.Helper;
using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.SearchObjects
{
    public class ToDo4924SearchObject : BaseSearchObject
    {
        public int? KorisnikId { get; set; }
        public StatusAktivnosti? StatusAktivnosti { get; set; }
        public DateTime? DatumVazenja { get; set; }
    }
}
