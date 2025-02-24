using System;
using System.Collections.Generic;
using System.Text;

namespace eRecipes.Model
{
    public class Notifier
    {
        public Notifier()
        {
        }
        public string Email { get; set; } = null!;
        public DateTime Datum { get; set; }
        public string Nesto { get; set; } = null!;
    }
}

