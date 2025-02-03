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
  void didChangeDependencies() {
    super.didChangeDependencies();

    provider = context.read<RecipeProvider>();
    _fetchData();
  }

  Future<void> _fetchData({String query = ''}) async {
    setState(() {
      _isLoading = true;
    });

    try {
      var filter = {
        'FTS': query,
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
          if (_isLoading) const Center(child: CircularProgressIndicator()),
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
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
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
      return const Center(
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
          columns: const [
            DataColumn(
              label: Center(
                  child: Text("Slika",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ),
            DataColumn(
                label: Center(
                    child: Text("Naziv recepta",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)))),
            DataColumn(
                label: Center(
                    child: Text("Korisničko ime",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)))),
            DataColumn(
                label: Center(
                    child: Text("Kategorija",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)))),
            DataColumn(
                label: Center(
                    child: Text("Vrsta jela",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)))),
            DataColumn(
                label: Center(
                    child: Text("Obriši recept",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)))),
          ],
          rows: result!.result.map((e) {
            return DataRow(
              onSelectChanged: (selected) {
                if (selected == true) {
                  openRecipeDetailsModal(e);
                }
              },
              cells: [
                DataCell(Center(
                    child: e.slika != null
                        ? SizedBox(
                            width: 100,
                            height: 100,
                            child: imageFromString(e.slika!),
                          )
                        : const Text(""))),
                DataCell(Center(
                    child: Text(e.naziv.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)))),
                DataCell(Center(
                    child: Text(
                        e.korisnik?.korisnickoIme ?? "Nema korisničkog imena",
                        style: const TextStyle(fontWeight: FontWeight.bold)))),
                DataCell(Center(
                    child: Text(e.kategorija?.naziv ?? "Nema kategorije",
                        style: const TextStyle(fontWeight: FontWeight.bold)))),
                DataCell(Center(
                    child: Text(e.vrstaJela?.naziv ?? "Nema vrste jela",
                        style: const TextStyle(fontWeight: FontWeight.bold)))),
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
                              title: const Text('Potvrda'),
                              content: const Text(
                                  'Da li ste sigurni da želite obrisati recept?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: const Text(
                                    'Ne',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 42, 87, 44)),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text(
                                    'Da',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 42, 87, 44)),
                                  ),
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
                              const SnackBar(
                                  content: Text('Recept je uspješno obrisan')),
                            );
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Došlo je do greške pri brisanju recepta')),
                            );
                          }
                        }
                      },
                      child: const Text("Obriši recept"),
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
