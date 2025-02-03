import 'package:erecipes_desktop/models/kategorija.dart';
import 'package:erecipes_desktop/models/search_result.dart';
import 'package:erecipes_desktop/providers/kategorija_provider.dart';
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

  bool _isLoading = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    provider = context.read<KategorijaProvider>();
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

      result = await provider.get(filter: filter);
      Map<int, int> brojRecepataMap = {};
      for (var kategorija in result!.result) {
        brojRecepataMap[kategorija.kategorijaId!] = await provider
            .fetchBrojRecepataZaKategoriju(kategorija.kategorijaId!);
      }
      result!.result.forEach((kategorija) {
        kategorija.brojRecepata =
            brojRecepataMap[kategorija.kategorijaId!] ?? 0;
      });
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
      return Center(
        child: const Text('No results found'),
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
                      onPressed: () async {
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
                            await provider.deleteKategorija(e.kategorijaId);
                            await _fetchData();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Kategorija je uspješno obrisana')),
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
                      child: const Text("Obriši kategoriju"),
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
