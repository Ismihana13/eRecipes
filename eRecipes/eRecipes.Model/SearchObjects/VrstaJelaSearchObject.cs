using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.SearchObjects
{
    public class VrstaJelaSearchObject : BaseSearchObject
    {
        public string? NazivGTE { get; set; }
        public bool? Status { get; set; }
        public bool? StatusRecepta { get; set; }
    }
}
