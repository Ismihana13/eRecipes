
import 'package:erecipes_mobile/providers/auth_provider.dart';
import 'package:erecipes_mobile/providers/kategorija_provider.dart';
import 'package:erecipes_mobile/providers/like_provider.dart';
import 'package:erecipes_mobile/providers/logged_recipe_provider.dart';
import 'package:erecipes_mobile/providers/recipe_provider.dart';
import 'package:erecipes_mobile/providers/vrsta_jela_provider.dart';
import 'package:erecipes_mobile/screens/recipe_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<RecipeProvider>(create: (_)=> LoggedRecipeProvider()),
      ChangeNotifierProvider<KategorijaProvider>(create: (_)=> KategorijaProvider()),
       ChangeNotifierProvider<VrstaJelaProvider>(create: (_)=> VrstaJelaProvider()),
       ChangeNotifierProvider<LikeProvider>(create: (_) => LikeProvider()),
    ],
    child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, primary: Colors.deepPurple),
        useMaterial3: true,
      ),

      home: LoginPage(),
    );
  }
}
class LoginPage extends StatelessWidget {
   LoginPage({super.key});
TextEditingController _usernameController=new TextEditingController();
TextEditingController _passwordController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.fill)
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 30,
                    top: 0,
                    width: 120,
                    height: 160,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/images/light-1.png"))
                      ),
                    ),
                    ),
                     Positioned(
                    right: 30,
                    top: 0,
                    width: 120,
                    height: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/images/clock.png"))
                      ),
                    ),
                    ),
                    Container(
                      child: Center(
                        child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 45,fontWeight: FontWeight.bold),),
                      ),
                    )
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey!))),
                      child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Username",
                          hintStyle: TextStyle(color: Colors.grey[350])
                        ),
                      ),
                    ),
                      TextField(
                        controller: _passwordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey[350])
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(143,148,251,1),
                      Color.fromRGBO(143,148,251,6),
                    ]
                    )
                ),
                child: InkWell(
                  onTap: () async{
                    RecipeProvider provider= new RecipeProvider();
                    AuthProvider.username=_usernameController.text;
                    AuthProvider.password =_passwordController.text;
                    if(_usernameController.text==""){

                    }
                    try {
                      var data= await provider.get();
                       Navigator.of(context).push(MaterialPageRoute(builder:  (context) => RecipeListScreen()));
                    }on Exception catch (e) {
                      showDialog(context: context, builder: (context) => AlertDialog(title: Text("Error"), actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))], content: Text(e.toString()),));
                    }
                  },
                  child: Center(child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                ),
              ),
            )
          ],
        ),
      ),
           
            
    ); 
  }
}
