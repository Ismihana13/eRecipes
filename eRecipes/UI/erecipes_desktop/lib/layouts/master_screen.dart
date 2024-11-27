import 'package:erecipes_desktop/screens/recipe_list_screen.dart';
import 'package:erecipes_desktop/screens/user_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MasterScreen extends StatefulWidget {
   MasterScreen(this.title,this.child,{super.key});
  String title;
  Widget child;

  @override
  State<MasterScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MasterScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Back"),
              onTap: () => {
                Navigator.pop(context),
                Navigator.pop(context)
              },
            ),
            ListTile(
              title: Text("Korisnici"),
              onTap: () => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> UserListScreen()))
              },
            ),
            ListTile(
              title: Text("Recepti"),
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> RecipeListScreen()))
              },
            )
          ],
        ),
      ),
      body: widget.child,
    );
  }
}