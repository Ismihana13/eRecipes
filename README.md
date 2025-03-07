# 🍰 eRecipes  

## 🔐 Prijava  

### 🖥️ Desktop aplikacija (Admin)  
- **Korisničko ime:** `admin`  
- **Lozinka:** `test`  

### 📱 Mobilna aplikacija  
#### Regularni korisnik  
- **Korisničko ime:** `korisnik`  
- **Lozinka:** `test`  

#### Premium korisnik  
- **Korisničko ime:** `premium`  
- **Lozinka:** `test`  

---

## 💳 Testni podaci za plaćanje  

**Stripe - Testna kreditna kartica:**  
- **Broj kartice:** `4242 4242 4242 4242`  
- **CVC:** `222`  
- **Datum isteka:** Bilo koji budući datum  

🔗 **Dodatne testne kartice:**  
[Stripe Test Kreditne Kartice](https://docs.page/flutter-stripe/flutter_stripe/sheet#5-test-the-integration)  

---

## 📩 Napomena  

Za testiranje registracije korisnika potreban je validan email kako bi korisnik primio poruku dobrodošlice.  

## 🚀 Pokretanje aplikacije  

### 1️⃣ Kloniranje repozitorija  
Klonirajte repozitorij: 
 https://github.com/Ismihana13/eRecipes.git

### 2️⃣ **Pokretanje API-ja i baze podataka (Dockerized)**

Nakon što klonirate repozitorij, otvorite terminal ili konzolu unutar kloniranog direktorija i pokrenite API i bazu podataka pomoću Docker komandi:

```bash
docker-compose build
docker-compose up
```

### 3️⃣ **Pokretanje desktop aplikacije (Visual Studio Code)**

1. Otvorite **eRecipes** folder u Visual Studio Code-u.
2. Otvorite **UI** folder.
3. Odaberite **erecipes_desktop** folder.
4. Instalirajte sve zavisnosti pomoću komande:

    ```bash
    flutter pub get
    ```

5. Pokrenite desktop aplikaciju sa sljedećom komandom:

    ```bash
    flutter run -d windows
    ```

### 4️⃣ **Pokretanje mobilne aplikacije (Visual Studio Code)**

1. Otvorite **eRecipes** folder u Visual Studio Code-u.
2. Otvorite **UI** folder.
3. Odaberite **erecipes_mobile** folder.
4. Instalirajte sve zavisnosti pomoću komande:

    ```bash
    flutter pub get
    ```

5. Pokrenite mobilni emulator.
6. Pokrenite mobilnu aplikaciju bez debuggiranja koristeći **CTRL + F5**.
