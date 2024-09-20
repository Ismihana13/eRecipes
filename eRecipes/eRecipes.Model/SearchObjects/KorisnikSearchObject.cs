using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.SearchObjects
{
    public class KorisnikSearchObject
    {
        public string? ImeGTE { get; set; }
        public string? PrezimeGTE { get; set; }
        public string? Email { get; set; }
        public string? KorisnickoIme { get; set; } 
        public bool? isKorisnikUlogeIncluded { get; set; }
        public int? Page {  get; set; }  
        public int? PageSize {  get; set; }
        public string? OrderBy { get; set; }
    }
}
