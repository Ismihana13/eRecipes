using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.Requests
{
    public class ToDo4924UpsertRequest
    {
        public int KorisnikId { get; set; }
        public string Naziv { get; set; }
        public string Opis { get; set; }
        public DateTime DatumIzvrsenja { get; set; }
        public string Status { get; set; }
    }
}
