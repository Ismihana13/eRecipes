using eRecipes.Model;
using eRecipes.Model.Requests;
using eRecipes.Model.SearchObjects;
using eRecipes.Service.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Linq.Dynamic;
using System.Linq.Dynamic.Core;
namespace eRecipes.Service
{
    public class KorisnikService : IKorisnikService
    {
        public ERecipesContext Context { get; set; }
        public IMapper Mapper { get; set; }
        public KorisnikService(ERecipesContext context, IMapper mapper)
        {
            Context = context;
            Mapper = mapper;
        }
        public virtual Model.PagedResult<Model.Korisnik> GetList(KorisnikSearchObject searchObject)
        {
            List<Model.Korisnik> result = new List<Model.Korisnik>();

            var query = Context.Korisniks.AsQueryable();

            if (!string.IsNullOrWhiteSpace(searchObject?.ImeGTE))
            {
                query = query.Where(x => x.Ime.StartsWith(searchObject.ImeGTE));
            }
            if (!string.IsNullOrWhiteSpace(searchObject?.PrezimeGTE))
            {
                query = query.Where(x => x.Prezime.StartsWith(searchObject.PrezimeGTE));
            }
            if (!string.IsNullOrWhiteSpace(searchObject?.Email))
            {
                query = query.Where(x => x.Email == searchObject.Email);
            }
            if (!string.IsNullOrWhiteSpace(searchObject?.KorisnickoIme))
            {
                query = query.Where(x => x.KorisnickoIme == searchObject.KorisnickoIme);
            }
            if (searchObject.isKorisnikUlogeIncluded == true)
            {
                query = query.Include(x => x.KorisnikUlogas).ThenInclude(xu => xu.Uloga);
            }
            int count =query.Count();
            if (!string.IsNullOrWhiteSpace(searchObject.OrderBy))
            {
                //    query=query.OrderBy(searchObject.OrderBy);
            }
                if (searchObject?.Page.HasValue==true && searchObject?.PageSize.HasValue == true)
            {
                query=query.Skip(searchObject.Page.Value * searchObject.PageSize.Value).Take(searchObject.PageSize.Value);
            }
            //if(!string.IsNullOrWhiteSpace(searchObject.OrderBy))
            //{
            //    switch (searchObject.OrderBy)
            //    {
            //        case "KorisnickoIme ASC":
            //            query = query.OrderBy(x => x.KorisnickoIme);
            //                break;
            //        case "KorisnickoIme DESC":
            //            query = query.OrderByDescending(x => x.KorisnickoIme);
            //            break;
            //        case "Ime ASC":
            //            query = query.OrderBy(x => x.Ime);
            //            break;
            //        case "Ime DESC":
            //            query = query.OrderByDescending(x => x.Ime );
            //            break;
            //    }     
            //}

            var list = query.ToList();
            //list.ForEach(k => result.Add(new Model.Korisnik()
            //{
            //    KorisnikId=k.KorisnikId,
            //    Ime=k.Ime,
            //    Prezime=k.Prezime,
            //    DatumRodjenja=k.DatumRodjenja,
            //    Email=k.Email,
            //    Telefon=k.Telefon,
            //    KorisnickoIme=k.KorisnickoIme,
            //    Status=k.Status,
            //}));
            var resultLista = Mapper.Map(list, result);
            Model.PagedResult<Model.Korisnik> response = new Model.PagedResult<Model.Korisnik>(); 
            response.ResultList=resultLista;
            response.Count = count;

            return response;
        }

        public Model.Korisnik Insert(KorisnikInsertRequest request)
        {
            if (request.Lozinka != request.LozinkaPotvrda)
            {
                throw new Exception("Lozinka i LozinkaPotvrda moraju biti iste");
            }
            Database.Korisnik entity = new Database.Korisnik();
            Mapper.Map(request, entity);

            entity.LozinkaSalt = GenerateSalt();
            entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, request.Lozinka);


            Context.Add(entity);
            Context.SaveChanges();

            return Mapper.Map<Model.Korisnik>(entity);


        }
        public static string GenerateSalt()
        {
            var byteArray = RNGCryptoServiceProvider.GetBytes(16);

            return Convert.ToBase64String(byteArray);
        }

        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }

        public Model.Korisnik Update(int id, KorisnikUpdateRequest request)
        {
            var entity = Context.Korisniks.Find(id);

            Mapper.Map(request, entity);

            if (request.Lozinka != null)
            {
                if (request.Lozinka != request.LozinkaPotvrda)
                {
                    throw new Exception("Lozinka i LozinkaPotvrda moraju biti iste");
                }
                entity.LozinkaSalt = GenerateSalt();
                entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, request.Lozinka);
            }

            Context.SaveChanges();
            return Mapper.Map<Model.Korisnik>(entity);
        }
    }
}
