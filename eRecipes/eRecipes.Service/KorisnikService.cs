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
using RabbitMQ.Client;
namespace eRecipes.Service
{
    public class KorisnikService : BaseCRUDService<Model.Korisnik, KorisnikSearchObject, Database.Korisnik, KorisnikInsertRequest, KorisnikUpdateRequest>, IKorisnikService
    {
        ILogger<KorisnikService> _logger;
        private readonly IEmailService _emailService;

        public KorisnikService(ERecipesContext context, IMapper mapper,ILogger<KorisnikService> logger, IEmailService emailService) : base(context, mapper)
        {
            _logger = logger;
            _emailService = emailService;
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
            entity.UlogaId = 2;
            entity.Status = true;
            base.BeforeInsert(request, entity);
            Notifier testRabbitaIMaila = new Notifier
            {
                Datum = DateTime.Now,
                Email = entity.Email!,
                Tekst = $"Poštovani {entity.Ime} {entity.Prezime},\n\n" +
                "Uspješno ste kreirali nalog na našoj aplikaciji eRecipes. " +
                "Hvala što ste odabrali našu platformu!\n\n" +
                "Stojimo vam na raspolaganju za sva dodatna pitanja.\n\n" +
                "Srdačan pozdrav,\n" +
                "eRecipes tim"
            };

            _emailService.SendingObject(testRabbitaIMaila);
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
            //Notifier testRabbitaIMaila = new Notifier
            //{

            //    Datum = DateTime.Now,
            //    Email = entity.Email!,
            //    Nesto = "Ovdje smo nesto upisali cisto da testiramo da li radi!"
            //};
            //_emailService.SendingObject(testRabbitaIMaila);
            return this.Mapper.Map<Model.Korisnik>(entity);
        }
        public Model.Korisnik UpdateMobile(int id, KorisnikMobileUpdateRequest request)
        {
            var user = Context.Korisniks.FirstOrDefault(x => x.KorisnikId == id);

            if (user == null)
            {
                throw new Exception("User not found");
            }

            user.Ime = request.Ime;
            user.Prezime = request.Prezime;
            user.Email = request.Email;
            user.Telefon = request.Telefon;

            Context.SaveChanges();

            return Mapper.Map<Model.Korisnik>(user);
        }
       
        public Model.Korisnik DeleteKorisnik(int id)
        {
            var set = Context.Set<Database.Korisnik>();

            var entity = set.Find(id);

            entity.Status = false;

            Context.SaveChanges();

            return Mapper.Map<Model.Korisnik>(entity);
        }

        public Model.Korisnik GetByUsername(string korisnickoIme)
        {
            var set = Context.Set<Database.Korisnik>();

            var entity = set.FirstOrDefault(k => k.KorisnickoIme == korisnickoIme);
            return Mapper.Map<Model.Korisnik>(entity);
        }
        public Model.Korisnik DeleteKorisnickiProfil(int id)
        {
            var korisnik = Context.Korisniks.Find(id);
            if (korisnik == null)
            {
                throw new Exception("Korisnik nije pronađen.");
            }

            Context.Korisniks.Remove(korisnik);
            Context.SaveChanges();

            return Mapper.Map<Model.Korisnik>(korisnik);
        }
        public Model.Korisnik UpdateUloga(int id, int novaUlogaId)
        {
            var korisnik = Context.Korisniks.Find(id);
            if (korisnik == null)
            {
                throw new Exception("Korisnik nije pronađen.");
            }

            korisnik.UlogaId = novaUlogaId;
            Context.SaveChanges();

            return Mapper.Map<Model.Korisnik>(korisnik);
        }

    }
}
