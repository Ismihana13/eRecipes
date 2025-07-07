using System;
using System.Collections.Generic;

namespace eRecipes.Service.Database
{
    public  class Izvjestaj
    {
      public int IzvjestajId { get; set; }
      public int ReceptId { get; set; }
      public int BrojLajkova { get; set; } = 0;
       public int BrojOmiljenih { get; set; } = 0;
      public DateTime DatumIzvjestaja { get; set; }
        public virtual Recept Recept { get; set; } = null!;
}
}
