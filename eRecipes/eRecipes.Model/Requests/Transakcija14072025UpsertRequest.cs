using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.Requests
{
    public class Transakcija14072025UpsertRequest
    {
        public int KorisnikId { get; set; }
        public float Iznos { get; set; }
        public DateTime DatumTransakcije { get; set; }
        public string Opis { get; set; }
        public int KategorijaTransakcije14072025Id { get; set; }
        public string Status { get; set; }
    }
}
