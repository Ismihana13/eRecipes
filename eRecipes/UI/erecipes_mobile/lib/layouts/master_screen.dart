/*import 'package:erecipes_mobile/providers/like_provider.dart';
import 'package:erecipes_mobile/screens/omiljeni_recepti_screen.dart';
import 'package:erecipes_mobile/screens/recipe_list_screen.dart';
import 'package:erecipes_mobile/screens/user_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MasterScreen extends StatefulWidget {
   MasterScreen(this.title,this.child,{super.key});
  String title;
  Widget child;

  @override
  State<MasterScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MasterScreen> {
  LikeProvider? _likeProvider;

  @override
  Widget build(BuildContext context) {
    _likeProvider = context.watch<LikeProvider>();


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
             title: Text("in like ${_likeProvider?.like?.items?.length ?? 0}"),

              onTap: () => {
               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> OmiljeniReceptiScreen()))
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
}*/