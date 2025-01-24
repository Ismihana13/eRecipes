using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.SearchObjects
{
    public class OmiljeniReceptSearchObject : BaseSearchObject
    {
        public string? FTS { get; set; }
        public int? KategorijaId { get; set; }
        public int? VrstaJelaId { get; set; }
    }
}
