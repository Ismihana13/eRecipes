import 'package:erecipes_desktop/providers/auth_provider.dart';
import 'package:erecipes_desktop/providers/kategorija_provider.dart';
import 'package:erecipes_desktop/providers/korisnik_provider.dart';
import 'package:erecipes_desktop/providers/logged_recipe_provider.dart';
import 'package:erecipes_desktop/providers/recipe_provider.dart';
import 'package:erecipes_desktop/providers/vrsta_jela_provider.dart';
import 'package:erecipes_desktop/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<RecipeProvider>(create: (_)=> LoggedRecipeProvider()),
      ChangeNotifierProvider<KategorijaProvider>(create: (_)=> KategorijaProvider()),
       ChangeNotifierProvider<VrstaJelaProvider>(create: (_)=> VrstaJelaProvider()),
       ChangeNotifierProvider<KorisnikProvider>(create: (_)=> KorisnikProvider()),
    ],
    child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: LoginScreen(),
        onGenerateRoute: (settings) {
          if (settings.name == HomeScreen.routeName) {
            return MaterialPageRoute(builder: ((context) => HomeScreen()));
          } else if (settings.name == LoginScreen.routeName) {
            return MaterialPageRoute(builder: ((context) => LoginScreen()));
          }
        },
    );
  }
}
class LoginScreen extends StatelessWidget {

LoginScreen({super.key});
TextEditingController _usernameController=new TextEditingController();
TextEditingController _passwordController=new TextEditingController();
late KorisnikProvider _korisnikProvider;
  final _formKey = GlobalKey<FormState>();
  static const String routeName = "/login";

 void handleLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        AuthProvider.username = _usernameController.text;
        AuthProvider.password = _passwordController.text;
        AuthProvider.korisnik = await _korisnikProvider.Authenticate();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful!'),
            duration: Duration(seconds: 3),
          ),
        );

        Navigator.of(context).pushNamedAndRemoveUntil(
         HomeScreen.routeName,
          (route) => false,
        );
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
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
        ),
        backgroundColor: Color.fromRGBO(1, 100, 34, 1),
      ),
      body: Stack(
        children:[ 
           Positioned.fill(
          child: Image.asset(
            'assets/images/background.jpg', 
            fit: BoxFit.cover, 
          ),
        ),Positioned.fill(
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
                    color: Color.fromARGB(193, 236, 250, 234).withOpacity(0.9),
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
                        decoration: InputDecoration(
                          labelText: "Username",
                          prefixIcon: const Icon(Icons.person, color: Color.fromRGBO(1, 100, 34, 1)), 
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(1, 100, 34, 1)),
                          ),
                        ),
                        cursorColor: Color.fromRGBO(1, 100, 34, 1),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 20),
                      // Password polje sa ikonom
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
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.lock, color: Color.fromRGBO(1, 100, 34, 1)), 
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(1, 100, 34, 1)),
                          ),
                        ),
                        cursorColor: Color.fromRGBO(1, 100, 34, 1),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () => handleLogin(context),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 48),
                          backgroundColor: Color.fromRGBO(1, 100, 34, 1),
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


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
