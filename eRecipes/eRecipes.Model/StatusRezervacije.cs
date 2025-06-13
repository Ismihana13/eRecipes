using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service.Helper
{
    public enum StatusRezervacije
    {
        Potvrdjena,
        Na_cekanju,
        Otkazana
    }

    public enum VrijednostRaspolozenja
    {
        Sretan,
        Tuzan,
        Pod_stresom,
        Uzbudjen,
        Umoran
    }
    public enum StatusAktivnosti
    {
        U_toku,
        Realizovana,
        Istekla
    }
}
