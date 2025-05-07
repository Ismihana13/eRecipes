import 'package:erecipes_desktop/models/katalog.dart';
import 'package:erecipes_desktop/models/search_result.dart';
import 'package:erecipes_desktop/providers/katalog_provider.dart';
import 'package:erecipes_desktop/providers/recipe_provider.dart';
import 'package:erecipes_desktop/providers/utils.dart';
import 'package:erecipes_desktop/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

class KatalogScreen extends StatefulWidget {
  const KatalogScreen({super.key});

  @override
  State<KatalogScreen> createState() => _KatalogScreenState();
}
class _KatalogScreenState extends State<KatalogScreen> {
  final TextEditingController _nazivController = TextEditingController();
  final TextEditingController _opisController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late KatalogProvider _katalogProvider;
  List<int?> selektovaniReceptiIds = [];
  SearchResult<Katalog>? result;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _katalogProvider = Provider.of<KatalogProvider>(context);
    _fetchData();
  }

  void _fetchData() async {
    var fetchedResult = await _katalogProvider.get();
    setState(() {
      result = fetchedResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton.icon(
              onPressed: _showDodajKatalogDialog,
              icon: const Icon(Icons.add),
              label: const Text('Dodaj katalog'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ),
        result == null
            ? const Expanded(child: Center(child: CircularProgressIndicator()))
            : Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 40, 
                      border: TableBorder.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      headingRowColor:
                          MaterialStateProperty.all(Colors.green[300]),
                      columns: const [
                        DataColumn(
                          label: SizedBox(
                            width: 200,
                            child: Center(
                              child: Text(
                                'Naziv',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 300,
                            child: Center(
                              child: Text(
                                'Opis',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 120,
                            child: Center(
                              child: Text(
                                'PDF',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      rows: result!.result.map((katalog) {
                        return DataRow(
                          color: MaterialStateProperty.all(
                            const Color.fromARGB(255, 221, 239, 199),
                          ),
                          cells: [
                            DataCell(SizedBox(
                              width: 200,
                              child: Text(
                                katalog.naziv ?? 'N/A',
                                style: const TextStyle(fontSize: 14),
                              ),
                            )),
                            DataCell(SizedBox(
                              width: 300,
                              child: Text(
                                katalog.opis ?? 'N/A',
                                style: const TextStyle(fontSize: 14),
                              ),
                            )),
                            DataCell(SizedBox(
                              width: 150,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                   //_preuzmiPdf(katalog.katalogId);
                                },
                                icon: const Icon(Icons.download),
                                label: const Text("Preuzmi"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            )),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Future<void> _preuzmiPdf(Katalog katalog) async {
 /* final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      build: (pw.Context context) => [
        pw.Text(
          katalog.naziv ?? 'Bez naslova',
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 16),
        pw.Text(
          katalog.opis ?? 'Bez opisa',
          style: pw.TextStyle(fontSize: 16),
        ),
        pw.SizedBox(height: 24),
        pw.Text(
          'Recepti:',
          style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 10),
        if (katalog.recepti != null && katalog.recepti.isNotEmpty)
          ...katalog.recepti.map((recept) => pw.Bullet(text: recept.naziv ?? 'Nepoznat recept')),
        if (katalog.recepti == null || katalog.recepti.isEmpty)
          pw.Text("Nema recepata u ovom katalogu."),
      ],
    ),
  );

  // Otvori dijalog za štampanje ili preuzimanje
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );*/
}

  void _showDodajKatalogDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Dodaj novi katalog'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 500,
                  child: TextFormField(
                    controller: _nazivController,
                    decoration: const InputDecoration(
                      labelText: 'Naziv kataloga',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Naziv je obavezan.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _opisController,
                  decoration: const InputDecoration(
                    labelText: 'Opis',
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Opis je obavezan.';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Zatvori'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pop(context);
                _prikaziListuRecepata(context);
              }
            },
            child: const Text('Dalje'),
          ),
        ],
      ),
    );
  }

  void _prikaziListuRecepata(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String greska = "Morate selektovati barem jedan recept.";

        return AlertDialog(
          title: const Text("Odaberi recepte"),
          content: SizedBox(
            width: double.maxFinite,
            child: FutureBuilder(
              future: Provider.of<RecipeProvider>(context, listen: false).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Greška: ${snapshot.error}");
                } else if (!snapshot.hasData || snapshot.data!.result.isEmpty) {
                  return const Text("Nema recepata.");
                }

                final recepti = snapshot.data!.result;

                return StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          greska,
                          style: const TextStyle(color: Colors.red),
                        ),
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: recepti.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final recept = recepti[index];
                              return CheckboxListTile(
                                value: selektovaniReceptiIds
                                    .contains(recept.receptId),
                                onChanged: (bool? selected) {
                                  setState(() {
                                    if (selected == true) {
                                      if (!selektovaniReceptiIds
                                          .contains(recept.receptId)) {
                                        selektovaniReceptiIds
                                            .add(recept.receptId);
                                      }
                                    } else {
                                      selektovaniReceptiIds
                                          .remove(recept.receptId);
                                    }
                                  });
                                },
                                title: Text(recept.naziv ?? ""),
                                secondary: recept.slika != null
                                    ? SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: imageFromString(recept.slika!),
                                      )
                                    : const SizedBox(width: 50, height: 50),
                              );
                            },
                          ),
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Zatvori"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (selektovaniReceptiIds.isEmpty) {
                  setState(() {
                    greska = "Morate selektovati barem jedan recept.";
                  });
                } else {
                  print("Odabrani recepti (ID-evi):");
                  selektovaniReceptiIds.forEach((id) {
                    print("Recept ID: $id");
                  });

                  var requestKatalog = {
                    'naziv': _nazivController.text,
                    'opis': _opisController.text,
                    'datumKreiranja': DateTime.now().toIso8601String(),
                    'receptIds': selektovaniReceptiIds,
                  };

                  var newCatalog =
                      await _katalogProvider.insert(requestKatalog);

                  await _katalogProvider.addReceptToKatalog(
                    newCatalog.katalogId,
                    selektovaniReceptiIds,
                  );
                  _nazivController.clear();
                  _opisController.clear();
                  setState(() {
                    selektovaniReceptiIds.clear();
                  });
                  Navigator.pop(context);
                  SuccessSnackBar.show(context, "Dodali ste novi katalog!");
                }
              },
              child: const Text("Spasi katalog"),
            )
          ],
        );
      },
    );
  }
}
