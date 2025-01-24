import 'package:erecipes_desktop/modal/recipe_details_modal.dart';
import 'package:erecipes_desktop/models/recept.dart';
import 'package:erecipes_desktop/models/search_result.dart';
import 'package:erecipes_desktop/providers/recipe_provider.dart';
import 'package:erecipes_desktop/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {

  late RecipeProvider provider;
   SearchResult<Recept>? result;
   TextEditingController _ftsEditingController = TextEditingController();
   bool _isLoading = false; 
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();

    provider=context.read<RecipeProvider>();
    _fetchData();
  }
Future<void> _fetchData({String query = ''}) async {
    setState(() {
      _isLoading = true;  
    });

    try {
      var filter = {
       'FTS':query,
       'Status': true,
      };

      result = await provider.get(filter: filter);

      setState(() {
        _isLoading = false;  
      });
    } catch (e) {
      setState(() {
        _isLoading = false;  
      });
      print('Error fetching data: $e');
    }
  }
   void openRecipeDetailsModal(Recept recept) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RecipeDetailsModal(recept: recept);
      },
    ).then((_) {
    setState(() {
      _fetchData();  
    });
  });
}

 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        _buildSearch(),
        if (_isLoading)
          Center(child: CircularProgressIndicator()),  
        Expanded( 
          child: _buildResultView(),
        ),
      ],
    ),
  );
}

  Widget _buildSearch() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _ftsEditingController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0), 
                ),
                onChanged: (value) {
                  _fetchData(query: value);
                },
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

  Widget _buildResultView() {
  if (result == null || result!.result.isEmpty) {
    return Center(
      child: Text('No results found'),
    );
  }

  return Container(
    width: double.infinity,
    color: Colors.grey[200],
    child: SingleChildScrollView(
      child: DataTable(
        columnSpacing: 10,
        border: TableBorder.all(
          color: Colors.black,
          width: 1,
          borderRadius: BorderRadius.zero,
        ),
        columns: [
          DataColumn(
            label: Center(child: Text("Slika", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
          ),
          DataColumn(
            label: Center(child: Text("Naziv recepta", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)))),
          DataColumn(
            label: Center(child: Text("Korisničko ime", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)))),
          DataColumn(
            label: Center(child: Text("Kategorija", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)))),
          DataColumn(
            label: Center(child: Text("Vrsta jela", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)))),
          DataColumn(
            label: Center(child: Text("Obriši recept", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)))),
        ],
        rows: result!.result.map((e) {
          return DataRow(
            onSelectChanged: (selected){
              if(selected==true){
                openRecipeDetailsModal(e);
              }         
            },
            cells: [
              DataCell(Center(child: e.slika!=null? Container(width: 100,height: 100, child: imageFromString(e.slika!),):Text(""))),
              DataCell(Center(child: Text(e.naziv.toString(), style: TextStyle(fontWeight: FontWeight.bold)))),
              DataCell(Center(child: Text(e.korisnik?.korisnickoIme ?? "Nema korisničkog imena", style: TextStyle(fontWeight: FontWeight.bold)))),
              DataCell(Center(child: Text(e.kategorija?.naziv ?? "Nema kategorije", style: TextStyle(fontWeight: FontWeight.bold)))),
              DataCell(Center(child: Text(e.vrstaJela?.naziv ?? "Nema vrste jela", style: TextStyle(fontWeight: FontWeight.bold)))),
              DataCell(
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Potvrda'),
                            content: Text('Da li ste sigurni da želite obrisati recept?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, false); 
                                },
                                child: Text('Ne',style: TextStyle(color: const Color.fromARGB(255, 42, 87, 44)),),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, true); 
                                },
                                child: Text('Da',style: TextStyle(color: const Color.fromARGB(255, 42, 87, 44)),),
                              ),
                            ],
                          );
                        },
                      );
                      if (confirm == true) {
                        try {
                          await provider.deleteRecept(e.receptId);
                          await _fetchData(); 
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Recept je uspješno obrisan')),
                          );
                        } catch (error) {
                          print("Greška pri brisanju recepta: $error");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Došlo je do greške pri brisanju recepta')),
                          );
                        }
                      }
                    },
                    child: Text("Obriši recept"),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    ),
  );
}
}