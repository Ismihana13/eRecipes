
import 'package:erecipes_mobile/models/omiljeni_recept.dart';
import 'package:erecipes_mobile/models/recept.dart';
import 'package:erecipes_mobile/providers/omiljeni_recept_provider.dart';
import 'package:erecipes_mobile/providers/recipe_provider.dart';
import 'package:erecipes_mobile/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeDetailsScreen extends StatefulWidget {
  static const String routeName = "/recipeDetails";
  Recept? recept;
  RecipeDetailsScreen({super.key,this.recept});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
   Map<String,dynamic> _initialValue={};
   var sastojciList;
    late RecipeProvider recipeProvider;
    OmiljeniReceptProvider? _omiljeniReceptProvider=null;
     bool isLoading=true;
  @override
   void didChangeDependencies(){
    super.didChangeDependencies();
   }

 @override
  void initState(){
    recipeProvider=context.read<RecipeProvider>();
    _omiljeniReceptProvider = context.read<OmiljeniReceptProvider>();
    super.initState();
    _initialValue={
      'naziv':widget.recept?.naziv,
      'opisRecepta':widget.recept?.opisRecepta,
      'slika':widget.recept?.slika,
      
    };
    recipeProvider.sastojci(widget.recept!.receptId).then((result){
      setState(() {
        sastojciList=result;
      });
    });
    
    initForm();
  }
  Future initForm() async{
    setState(() {
      isLoading=false;
    });
  }
   void _toggleFavorite(Recept recept) async {
      var noviOmiljeniRecept = OmiljeniRecept();
      noviOmiljeniRecept.receptId = recept.receptId;
    bool isFavorite = await _omiljeniReceptProvider?.isFavorite(recept.receptId!) ?? false;
    if (isFavorite) {
      await _omiljeniReceptProvider?.removeFavorite(recept.receptId!);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Uklonili ste recept iz omiljenih.')));
    } else {
      await _omiljeniReceptProvider?.insert(noviOmiljeniRecept);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Dodali ste recept u omiljene.')));
    }
    setState(() {}); 
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
      body: SingleChildScrollView(
        child: Container(
          child:  Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                      Row(
                        children: [
                          Text(
                            'Dobro došli!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 24,
                          ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildRecipeDetails()
        ],
        ),
        ),
      ),
      );
    
  }
Widget _buildRecipeDetails() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: double.infinity,
        height: 250,
        child: widget.recept?.slika == null
            ? Placeholder()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: imageFromStringDetails(widget.recept!.slika!),
              ),
      ),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          children: [
            Text(
              widget.recept?.naziv ?? 'Naziv recepta nije dostupan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            FutureBuilder<bool>(
              future: _omiljeniReceptProvider?.isFavorite(widget.recept!.receptId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasData && snapshot.data!) {
                  return IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red),
                    iconSize: 35, 
                    onPressed: () => _toggleFavorite(widget.recept!),
                  );
                } else {
                  return IconButton(
                    icon: Icon(Icons.favorite_border, color: Colors.red),
                    iconSize: 35, 
                    onPressed: () => _toggleFavorite(widget.recept!),
                  );
                }
              },
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          widget.recept?.opisRecepta ?? 'Opis recepta nije dostupan',
        ),
      ),
       const SizedBox(height: 20),  // Add space before ingredients section
      _buildSastojciList()
    ],
  );
}
Widget _buildSastojciList() {
  if (sastojciList == null) {
    return const Center(child: CircularProgressIndicator()); 
  }

    if (sastojciList.isEmpty) {
    return Center(
      child: Text(
        "Nema sastojaka.",
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey,
        ),
      ),
    );
  }

  return Card(
    elevation: 4,  // Optional shadow effect
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
   color:  Colors.white,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Color.fromARGB(199, 244, 242, 242), // Postavlja boju ivica na sivu
        width: 1.0, // Širina ivice
      ),
      borderRadius: BorderRadius.circular(8.0), // Dodaje zaobljene ivice
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sastojci:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 52, 52, 52),
            ),
          ),
          const SizedBox(width: 13,),
          ListView.builder(
            shrinkWrap: true,
            itemCount: sastojciList.length,
            itemBuilder: (context, index) {
              var sastojak = sastojciList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        sastojak.sastojak?.naziv ?? 'N/A', // Ingredient name
                        style: const TextStyle(
                         // fontSize: 18, // Change the size as needed
                          fontWeight: FontWeight.bold, // You can also modify the weight
                          color: Color.fromARGB(255, 19, 51, 34), // Change the color to match description
                        ),
                      ),
                    ),
                    Expanded(
                       child: Text(
                        '${formatQuantity(sastojak.kolicina ?? 0)} ${sastojak.mjernaJedinica ?? 'N/A'}',
                      // style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}


String formatQuantity(double quantity) {
  if (quantity == quantity.toInt()) {
    return quantity.toInt().toString(); 
  } else {
    return quantity.toStringAsFixed(1);
  }
}


}



