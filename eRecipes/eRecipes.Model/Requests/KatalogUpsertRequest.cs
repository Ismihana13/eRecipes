using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.Requests
{
    public class KatalogUpsertRequest
    {
        public string Naziv { get; set; }
        public DateTime DatumKreiranja { get; set; }
        public string? Opis { get; set; }
    }
}
