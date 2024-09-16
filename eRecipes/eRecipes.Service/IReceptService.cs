using eRecipes.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRecipes.Service
{
    public interface IReceptService
    {
        List<Recept> GetList();
    }
}
