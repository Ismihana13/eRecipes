using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.SearchObjects
{
    public class ReceptSearchObject
    {
        public string? FTS { get; set; }
        public int? Page { get; set; }
        public int? PageSize { get; set; } 
    }
}
