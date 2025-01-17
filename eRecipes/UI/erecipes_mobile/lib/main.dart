import 'package:erecipes_mobile/providers/auth_provider.dart';
import 'package:erecipes_mobile/providers/kategorija_provider.dart';
import 'package:erecipes_mobile/providers/korisnik_provider.dart';
import 'package:erecipes_mobile/providers/omiljeni_recept_provider.dart';
import 'package:erecipes_mobile/providers/recipe_provider.dart';
import 'package:erecipes_mobile/providers/vrsta_jela_provider.dart';
import 'package:erecipes_mobile/screens/omiljeni_recepti_screen.dart';
import 'package:erecipes_mobile/screens/recipe_details_screen.dart';
import 'package:erecipes_mobile/screens/recipe_list_screen.dart';
import 'package:erecipes_mobile/screens/singup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  //Stripe.publishableKey = stripePublishableKey;
  runApp(const MainApp());
  WidgetsFlutterBinding.ensureInitialized();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => KorisnikProvider()),
        ChangeNotifierProvider(create: (_) => RecipeProvider()),
        ChangeNotifierProvider(create: (_) => KategorijaProvider()),
        ChangeNotifierProvider(create: (_) => VrstaJelaProvider()),
        ChangeNotifierProvider(create: (_) => OmiljeniReceptProvider()),
        // ChangeNotifierProvider(create: (_) => VrstaJelaProvider()),
      ],
      child: MaterialApp(
        initialRoute: LoginScreen.routeName,
        routes: {
          // HomeScreen.routeName: (context) => HomeScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          SingupScreen.routeName: (context) => SingupScreen(),
          RecipeListScreen.routeName: (context) => RecipeListScreen(),
          OmiljeniReceptiScreen.routeName: (context) =>
              const OmiljeniReceptiScreen(),
          RecipeDetailsScreen.routeName: (context) => RecipeDetailsScreen(),
          // ProfileScreen.routeName: (context) => ProfileScreen(),
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  static const String routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = new TextEditingController();

  TextEditingController _passwordController = new TextEditingController();

  late KorisnikProvider _korisnikProvider;

  final _formKey = GlobalKey<FormState>();

  void handleLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        AuthProvider.username = _usernameController.text;
        AuthProvider.password = _passwordController.text;
        AuthProvider.korisnik = await _korisnikProvider.Authenticate();
        print("Username: ${AuthProvider.username}");
        print("Password: ${AuthProvider.password}");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful!'),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.pushNamed(context, RecipeListScreen.routeName);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed. Please check your credentials.'),
            duration: Duration(seconds: 3),
          ),
        );
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
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: Color.fromRGBO(1, 100, 34, 1),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(color: Color.fromARGB(236, 255, 255, 255)),
          ),
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                child: Image.asset(
                  'assets/images/background.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(height: 200),
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(1, 100, 34, 1),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _usernameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "The username field cannot be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Username",
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: const Icon(Icons.person),
                          filled: true,
                          fillColor: const Color(0xFFEFEFEF),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "The password field cannot be empty";
                          } else if (value.length < 6) {
                            return "Password must be at least 6 characters long";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: const Icon(Icons.lock_outline),
                          filled: true,
                          fillColor: const Color(0xFFEFEFEF),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () => handleLogin(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 42, 99, 56),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don’t have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(SingupScreen.routeName);
                              print("Navigacija na registraciju");
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Color(0xFF2C4D34),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
