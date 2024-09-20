using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.SearchObjects
{
    public class VrstaJelaSearchObject
    {
        public string? NazivGTE {  get; set; }
        public int? Page { get; set; }
        public int? PageSize { get; set; }
    }
}
