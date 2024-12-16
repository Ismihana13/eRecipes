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
using Microsoft.Extensions.Logging;
using Azure.Core;
namespace eRecipes.Service
{
    public class KorisnikService : BaseCRUDService<Model.Korisnik, KorisnikSearchObject, Database.Korisnik, KorisnikInsertRequest, KorisnikUpdateRequest>, IKorisnikService
    {
        ILogger<KorisnikService> _logger;
        public KorisnikService(ERecipesContext context, IMapper mapper,ILogger<KorisnikService> logger) : base(context, mapper)
        {
            _logger = logger;
        }

        public override IQueryable<Database.Korisnik> AddFilter(KorisnikSearchObject searchObject, IQueryable<Database.Korisnik> query)
        {
            query = base.AddFilter(searchObject, query);
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
                query = query.Where(x => x.KorisnickoIme.StartsWith( searchObject.KorisnickoIme));
            }

            if (searchObject.isKorisnikUlogeIncluded == true)
            {
                query = query.Include(x => x.Uloga);
            }
            if (searchObject.Status.HasValue)
            {
                query = query.Where(x => x.Status == searchObject.Status);
            }


            return query;
        }


        public override void BeforeInsert(KorisnikInsertRequest request, Database.Korisnik entity)
        {
            _logger.LogInformation($"Adding user: {entity.KorisnickoIme}");
            if (request.Lozinka != request.LozinkaPotvrda)
            {
                throw new Exception("Lozinka i LozinkaPotvrda moraju biti iste");
            }

            entity.LozinkaSalt = GenerateSalt();
            entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, request.Lozinka);
            base.BeforeInsert(request, entity);
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

        public override void BeforeUpdate(KorisnikUpdateRequest request, Database.Korisnik entity)
        {
            base.BeforeUpdate(request, entity);
            if (request.Lozinka != null)
            {
                if (request.Lozinka != request.LozinkaPotvrda)
                {
                    throw new Exception("Lozinka i LozinkaPotvrda moraju biti iste");
                }

                entity.LozinkaSalt = GenerateSalt();
                entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, request.Lozinka);
            }

        }

        public Model.Korisnik Login(string username, string password)
        {
            var entity = Context.Korisniks.Include(x=>x.Uloga).FirstOrDefault(x => x.KorisnickoIme == username);
            if (entity == null) 
            {
                return null;
            }
            var hash = GenerateHash(entity.LozinkaSalt, password);
            if(hash != entity.LozinkaHash)
            {
                return null;
            }
            return this.Mapper.Map<Model.Korisnik>(entity);
        }
        //public override Model.Korisnik Insert(KorisnikInsertRequest request)
        //{
        //    var entity = base.Insert(request);
        //    foreach (var uloga in request.UlogeID)
        //    {
        //        Database.KorisnikUloga Uloga = new Database.KorisnikUloga();
        //        Uloga.UlogaId = uloga;
        //        Uloga.KorisnikId = entity.KorisnikId;
        //        Uloga.DatumIzmjene = DateTime.Now;
        //        Context.KorisnikUlogas.Add(Uloga);
        //    }
        //    Context.SaveChanges();
        //    return entity;
        //}
        //public Model.Korisnik AddUloga(int id, KorisnikUpdateRequest request)
        //{
        //    var user = Context.Korisniks.Include("KorisnikUlogas.Uloga").FirstOrDefault(x => x.KorisnikId == id);
        //    var uloga = Context.Ulogas.FirstOrDefault(x => x.Naziv.ToLower() == request.Uloga);
        //    Database.KorisnikUloga nova = new Database.KorisnikUloga()
        //    {
        //        DatumIzmjene = DateTime.Now,
        //        KorisnikId = id,
        //        UlogaId = uloga.UlogaId
        //    };
        //    Context.KorisnikUlogas.Add(nova);
        //    Context.SaveChanges();
        //    return Mapper.Map<Model.Korisnik>(user);
        //}
        //public Model.Korisnik DeleteUloga(int id, KorisnikUpdateRequest request)
        //{
        //    var user = Context.Korisniks.Include("KorisnikUlogas.Uloga").FirstOrDefault(x => x.KorisnikId == id);
        //    var uloga = Context.Ulogas.FirstOrDefault(x => x.Naziv.ToLower() == request.Uloga);
        //    var korisnikUloga = Context.KorisnikUlogas.FirstOrDefault(x => x.KorisnikId == user.KorisnikId && x.UlogaId == uloga.UlogaId);
        //    Context.KorisnikUlogas.Remove(korisnikUloga);
        //    Context.SaveChanges();
        //    return Mapper.Map<Model.Korisnik>(user);
        //}
        public Model.Korisnik DeleteKorisnik(int id)
        {
            var set = Context.Set<Database.Korisnik>();

            var entity = set.Find(id);

            entity.Status = false;

            Context.SaveChanges();

            return Mapper.Map<Model.Korisnik>(entity);
        }
    }

}
