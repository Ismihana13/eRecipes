
import 'package:erecipes_mobile/providers/auth_provider.dart';
import 'package:erecipes_mobile/providers/kategorija_provider.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, primary: Colors.red),
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
      appBar: AppBar(title: Text("Login"),),
      body: Center(
        child: Center(
          child:Container (
            constraints:const BoxConstraints(maxHeight:400 ,maxWidth: 400),
            child: Card(
              child: Column(
               children: [
                  //Image.network("",height: 100,width: 100,),
                  Image.asset("assets/images/logo.png",height: 100,width: 100,),
                  const SizedBox(height: 10,),
                  TextField(controller: _usernameController, decoration: InputDecoration(labelText: "Username",prefixIcon: Icon(Icons.email) ),),
                  SizedBox(height: 10,),
                  TextField(controller: _passwordController, decoration: InputDecoration(labelText: "Password",prefixIcon: Icon(Icons.password) ),),
                  ElevatedButton(
                    onPressed: () async{
                      RecipeProvider provider= new RecipeProvider();
                     // provider.get();
                     print("credentials ${_usernameController.text}: ${_passwordController.text}");
                     AuthProvider.username=_usernameController.text;
                     AuthProvider.password=_passwordController.text;
                    try{
                          var data =await provider.get();
                          //print(" authentficated");
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> RecipeListScreen()));
                    }on Exception catch(e){
                      showDialog(context:context,builder:(context)=>AlertDialog(title: Text("Error"),actions: [TextButton(onPressed:()=> Navigator.pop(context), child: Text("OK"))], content: Text(e.toString()),));
                    }
                    
                  }, 
                  child: Text("Login"))
                ],),
            ),) ,),
        ),
    );
  }
}
class LayputExamples extends StatelessWidget {
  const LayputExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Container(
        height: 200,
        color: Colors.red,
        child: Center(child:Container(
          height: 100,
          width: 50,
          color: Colors.blue,
          child: Text("Sample text"),
      ),
      ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Item1"),
          Text("Item3")
        ],
      ),
      Container(
        height:150,
        color:Colors.red,
        child:Center(child: Text("Cointainer")),
      )
      ],
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
