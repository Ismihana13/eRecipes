import 'package:erecipes_desktop/providers/auth_provider.dart';
import 'package:erecipes_desktop/providers/izvjestaj_provider.dart';
import 'package:erecipes_desktop/providers/kategorija_provider.dart';
import 'package:erecipes_desktop/providers/korisnik_provider.dart';
import 'package:erecipes_desktop/providers/logged_recipe_provider.dart';
import 'package:erecipes_desktop/providers/notifikacije_provider.dart';
import 'package:erecipes_desktop/providers/recipe_provider.dart';
import 'package:erecipes_desktop/providers/uloga_provider.dart';
import 'package:erecipes_desktop/providers/uplata_provider.dart';
import 'package:erecipes_desktop/providers/vrsta_jela_provider.dart';
import 'package:erecipes_desktop/screens/home_screen.dart';
import 'package:erecipes_desktop/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<RecipeProvider>(
          create: (_) => LoggedRecipeProvider()),
      ChangeNotifierProvider<KategorijaProvider>(
          create: (_) => KategorijaProvider()),
      ChangeNotifierProvider<VrstaJelaProvider>(
          create: (_) => VrstaJelaProvider()),
      ChangeNotifierProvider<KorisnikProvider>(
          create: (_) => KorisnikProvider()),
      ChangeNotifierProvider<UlogaProvider>(create: (_) => UlogaProvider()),
      ChangeNotifierProvider<IzvjestajProvider>(
          create: (_) => IzvjestajProvider()),
      ChangeNotifierProvider<NotifikacijeProvider>(
          create: (_) => NotifikacijeProvider()),
      ChangeNotifierProvider<UplataProvider>(
          create: (_) => UplataProvider()),
    ],
    child: const MyApp(),
  ));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: LoginScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == HomeScreen.routeName) {
          return MaterialPageRoute(builder: ((context) => const HomeScreen()));
        } else if (settings.name == LoginScreen.routeName) {
          return MaterialPageRoute(builder: ((context) => LoginScreen()));
        }
        return null;
      },
    );
  }
}

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  late KorisnikProvider _korisnikProvider;
  final _formKey = GlobalKey<FormState>();
  static const String routeName = "/login";

  void handleLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        AuthProvider.username = _usernameController.text;
        AuthProvider.password = _passwordController.text;
        AuthProvider.korisnik = await _korisnikProvider.Authenticate();
        if (AuthProvider.korisnik!.ulogaId == 2 ||
            AuthProvider.korisnik!.korisnikId == 3) {
          ErrorSnackBar.show(
              context, 'Login failed. Please check your credentials.');
          return;
        }
        SuccessSnackBar.show(context, "Login successful!");
        Navigator.of(context).pushNamedAndRemoveUntil(
          HomeScreen.routeName,
          (route) => false,
        );
      } catch (e) {
        ErrorSnackBar.show(
            context, 'Login failed. Please check your credentials.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _korisnikProvider = Provider.of<KorisnikProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'eRecipes',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        backgroundColor: const Color.fromRGBO(1, 100, 34, 1),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(193, 236, 250, 234)
                          .withOpacity(0.9),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(1, 100, 34, 1),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "The username field cannot be empty";
                            } else if (value.length < 3) {
                              return "Username cannot contain fewer than 3 characters";
                            }
                            return null;
                          },
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: "Username",
                            prefixIcon: Icon(Icons.person,
                                color: Color.fromRGBO(1, 100, 34, 1)),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(1, 100, 34, 1)),
                            ),
                          ),
                          cursorColor: const Color.fromRGBO(1, 100, 34, 1),
                          maxLines: 1,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "The password field cannot be empty";
                            } else if (value.length < 4) {
                              return "Password cannot contain fewer than 4 characters";
                            }
                            return null;
                          },
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock,
                                color: Color.fromRGBO(1, 100, 34, 1)),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(1, 100, 34, 1)),
                            ),
                          ),
                          cursorColor: const Color.fromRGBO(1, 100, 34, 1),
                          maxLines: 1,
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () => handleLogin(context),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 48),
                            backgroundColor:
                                const Color.fromRGBO(1, 100, 34, 1),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
