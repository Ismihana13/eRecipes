import 'package:erecipes_desktop/modal/add_category.dart';
import 'package:erecipes_desktop/modal/add_type_of_dish.dart';
import 'package:erecipes_desktop/models/kategorija.dart';
import 'package:erecipes_desktop/models/search_result.dart';
import 'package:erecipes_desktop/models/vrsta_jela.dart';
import 'package:erecipes_desktop/providers/kategorija_provider.dart';
import 'package:erecipes_desktop/providers/vrsta_jela_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  late KategorijaProvider provider;
  SearchResult<Kategorija>? result;
  TextEditingController _ftsEditingController = TextEditingController();
  TextEditingController _nameEditingController = TextEditingController();
  late VrstaJelaProvider _vrstaJelaProvider;
  SearchResult<VrstaJela>? resultVrstaJela;

  bool _isLoading = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    provider = context.read<KategorijaProvider>();
    _vrstaJelaProvider = context.read<VrstaJelaProvider>();
    _fetchData();
  }

  Future<void> _fetchData({String query = ''}) async {
    setState(() {
      _isLoading = true;
    });

    try {
      var filter = {
        'NazivGTE': query,
        'Status': true,
      };
      var filterVrstaJela = {
        'Status': true,
      };

      result = await provider.get(filter: filter);
      resultVrstaJela = await _vrstaJelaProvider.get(filter: filterVrstaJela);

      Map<int, int> brojRecepataMap = {};
      for (var kategorija in result!.result) {
        brojRecepataMap[kategorija.kategorijaId!] = await provider
            .fetchBrojRecepataZaKategoriju(kategorija.kategorijaId!);
      }

      result!.result.forEach((kategorija) {
        kategorija.brojRecepata =
            brojRecepataMap[kategorija.kategorijaId!] ?? 0;
      });

      Map<int, int> brojRecepataVrstaJelaMap = {};
      for (var vrstaJela in resultVrstaJela!.result) {
        brojRecepataVrstaJelaMap[vrstaJela.vrstaJelaId!] =
            await _vrstaJelaProvider
                .fetchBrojRecepataZaVrstuJela(vrstaJela.vrstaJelaId!);
      }

      resultVrstaJela!.result.forEach((vrstaJela) {
        vrstaJela.brojRecepata =
            brojRecepataVrstaJelaMap[vrstaJela.vrstaJelaId!] ?? 0;
      });
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildSearch(),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
          Expanded(
            child: _buildResultViewCategory(),
          ),
          _buildSearchDish(),
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
                    labelText: 'Search by name category',
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      _fetchData();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AddCategoryScreen();
                        },
                      ).then((categoryName) {
                        if (categoryName != null && categoryName.isNotEmpty) {
                          setState(() {
                            _fetchData();
                          });
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      "Dodaj kategoriju",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchDish() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: TextField(
                  controller: _nameEditingController,
                  decoration: const InputDecoration(
                    labelText: 'Search by name type of dish',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                  ),
                  onChanged: (value) async {
                    var filter = {
                      'NazivGTE': value,
                      'Status': true,
                    };
                    resultVrstaJela =
                        await _vrstaJelaProvider.get(filter: filter);
                    setState(() {});
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      _fetchData();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AddTypeDishScreen();
                        },
                      ).then((categoryName) {
                        if (categoryName != null && categoryName.isNotEmpty) {
                          setState(() {
                            _fetchData();
                          });
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      "Dodaj vrstu jela",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultViewCategory() {
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
                    child: Text("Kategorija",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)))),
            DataColumn(
                label: Center(
                    child: Text("Broj recepata",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)))),
            DataColumn(
                label: Center(
                    child: Text("Obriši kategoriju",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)))),
          ],
          rows: result!.result.map((e) {
            return DataRow(
              cells: [
                DataCell(Center(
                    child: Text(e.naziv ?? "Nema kategorije",
                        style: const TextStyle(fontWeight: FontWeight.bold)))),
                DataCell(Center(
                    child: Text(e.brojRecepata?.toString() ?? "0",
                        style: const TextStyle(fontWeight: FontWeight.bold)))),
                DataCell(
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: e.brojRecepata != 0
                          ? null
                          : () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Potvrda'),
                                    content: const Text(
                                        'Da li ste sigurni da želite obrisati kategoriju?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                        child: const Text(
                                          'Ne',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 42, 87, 44)),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, true);
                                        },
                                        child: const Text(
                                          'Da',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 42, 87, 44)),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (confirm == true) {
                                try {
                                  await provider
                                      .deleteKategorija(e.kategorijaId);
                                  await _fetchData();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Kategorija je uspješno obrisana')),
                                  );
                                } catch (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Došlo je do greške pri brisanju kategorije')),
                                  );
                                }
                              }
                            },
                      child: Text(e.brojRecepata != 0
                          ? "Kategorija se ne smije brisati, jer ima recepte."
                          : "Obriši kategoriju"),
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

  Widget _buildResultView() {
    if (resultVrstaJela == null || resultVrstaJela!.result.isEmpty) {
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
                    child: Text("Vrsta jela",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)))),
            DataColumn(
                label: Center(
                    child: Text("Broj recepata",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)))),
            DataColumn(
                label: Center(
                    child: Text("Obriši vrstu jela",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)))),
          ],
          rows: resultVrstaJela!.result.map((e) {
            return DataRow(
              cells: [
                DataCell(Center(
                    child: Text(e.naziv ?? "Nema vrste jela",
                        style: const TextStyle(fontWeight: FontWeight.bold)))),
                DataCell(Center(
                    child: Text(e.brojRecepata?.toString() ?? "0",
                        style: const TextStyle(fontWeight: FontWeight.bold)))),
                DataCell(
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: e.brojRecepata != 0
                          ? null
                          : () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Potvrda'),
                                    content: const Text(
                                        'Da li ste sigurni da želite obrisati vrstu jela?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                        child: const Text(
                                          'Ne',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 42, 87, 44)),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, true);
                                        },
                                        child: const Text(
                                          'Da',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 42, 87, 44)),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (confirm == true) {
                                try {
                                  await _vrstaJelaProvider
                                      .deleteVrstaJela(e.vrstaJelaId);
                                  await _fetchData();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Vrsta jela je uspješno obrisana')),
                                  );
                                } catch (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Došlo je do greške pri brisanju vrste jela')),
                                  );
                                }
                              }
                            },
                      child: Text(e.brojRecepata != 0
                          ? "Vrsta jela se ne smije brisati, jer ima recepte."
                          : "Obriši vrstu jela"),
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
