import 'package:erecipes_desktop/layouts/master_screen.dart';
import 'package:erecipes_desktop/models/recept.dart';
import 'package:erecipes_desktop/models/search_result.dart';
import 'package:erecipes_desktop/providers/recipe_provider.dart';
import 'package:erecipes_desktop/providers/utils.dart';
import 'package:erecipes_desktop/screens/recipe_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {

  late RecipeProvider provider;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();

    provider=context.read<RecipeProvider>();
  }

  SearchResult<Recept>? result=null;
  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista recepata", 
        Container(
          child: Column(
            children: [
              _buildSearch(),
              _buildResultView()
            ],
            ),
        )
      );
  }

TextEditingController _ftsEditingController= TextEditingController();
//TextEditingController _sifraEditingController= TextEditingController();
  Widget _buildSearch(){
    return Padding(
      padding: const EdgeInsets.all(8.0), 
      child: Row(
      children: [
        Expanded(child: TextField(controller: _ftsEditingController, decoration: InputDecoration(labelText: "Naziv ili sifra"),)),
      //  SizedBox(width: 8,),
       // Expanded(child: TextField(controller: _sifraEditingController, decoration: InputDecoration(labelText: "Sifra"),)),

        ElevatedButton(onPressed: ()async{
           
           var filter= {
              'fts': _ftsEditingController.text,
             // 'sifra':_sifraEditingController
           };
          
           result= await provider.get(filter:filter);
          setState(() {
          
          });

        }, child: Text("Pretraga")),
        SizedBox(width: 8 ,),
         ElevatedButton(onPressed: ()async{
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> RecipeDetailsScreen()));
        }, child: Text("Dodaj ")) 
      ],
    ),
    ) ;
  }

  Widget _buildResultView(){
    return Expanded(
      child:Container(
         width: double.infinity,
      child: SingleChildScrollView(
        child: DataTable(
          columns: [
            DataColumn(label: Text("ID"), numeric: true),
             DataColumn(label: Text("Naziv")),
              DataColumn(label: Text("Slika")),
          ],
          rows: result?.result.map((e)=> 
          DataRow(
            onSelectChanged: (selected)=>{
              if(selected==true){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> RecipeDetailsScreen(recept: e,)))
              }
              
            },
            cells: [
              DataCell(Text(e.receptId.toString())),
              DataCell(Text(e.naziv?? "")),
              DataCell(e.slika!=null? Container(width: 100,height: 100,
              child: imageFromString(e.slika!),):Text("")),
          ])
          ).toList().cast<DataRow>()?? [],
        ),
        ),
      ),
    );
  }
}