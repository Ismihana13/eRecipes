import 'package:erecipes_mobile/layouts/master_screen.dart';
import 'package:erecipes_mobile/models/recept.dart';
import 'package:erecipes_mobile/models/search_result.dart';
import 'package:erecipes_mobile/providers/like_provider.dart';
import 'package:erecipes_mobile/providers/recipe_provider.dart';
import 'package:erecipes_mobile/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  RecipeProvider? _recipeProvider=null;
  SearchResult<Recept>? data=null;
  TextEditingController _searchController= TextEditingController();
  LikeProvider? _likeProvider=null;

  @override
  void initState(){
    super.initState();
    _recipeProvider=context.read<RecipeProvider>();
    _likeProvider = context.read<LikeProvider>();
    loadData();
  }
 void loadData() async {
    var tmpData= await _recipeProvider?.get();
    setState(() {
      data=tmpData;
    });
  }
  SearchResult<Recept>? result=null;
  @override
  Widget build(BuildContext context) {
    return MasterScreen("Recepti", 
    SingleChildScrollView(
      child: Container(
        child:  Column(
          children: [
            _buildRecipeSearch(),
            Container(
              height: 500,
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 4/3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 30,
                ),
                scrollDirection: Axis.vertical,
                children: _buildRecipeCardList(),
              ),
            )
          ],
        ),
      ),
    ));
  }

   Widget _buildRecipeSearch() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: (value) async{
                var tmpData= await _recipeProvider?.get(filter: {'fts':_searchController.text});
                setState(() {
                  data=tmpData;
                });
              },
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search",
              prefix: Icon(Icons.search)
            ),
                    ),
          )),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
            child: IconButton(
              icon: Icon(Icons.filter_list), 
              onPressed: ()async { 
                var tmpData= await _recipeProvider?.get(filter: {'fts':_searchController.text});
                setState(() {
                  data=tmpData;
                });
               },
            ),
          )
      ],
    );
  }
  
  List<Widget> _buildRecipeCardList() {
    if(data?.result?.length==0){
      return [Text("Loading..")];
    }
    List<Widget> list= data!.result.map((e) => Container(
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            child: e.slika==null ? Placeholder() : imageFromString(e.slika!),
          ),
          Text(e.naziv ?? ""),
          Text(e.opisRecepta ?? ""),
          IconButton(onPressed: () {
  print("Pozivam addToCart");
  _likeProvider?.addToCart(e);
}
, icon:Icon(Icons.shopping_cart))
        ],
      ),
    )).cast<Widget>().toList();
    return list;
  }
}
  