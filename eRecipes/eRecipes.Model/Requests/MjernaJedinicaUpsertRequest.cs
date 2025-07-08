using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model.Requests
{
    public class MjernaJedinicaUpsertRequest
    {
        public string Naziv { get; set; } = null!;
        public string Oznaka { get; set; }= null!;
    }
}
