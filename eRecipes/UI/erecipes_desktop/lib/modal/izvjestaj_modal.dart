import 'package:erecipes_desktop/models/recept.dart';
import 'package:erecipes_desktop/models/search_result.dart';
import 'package:erecipes_desktop/providers/izvjestaj_provider.dart';
import 'package:erecipes_desktop/providers/recipe_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IzvjestajModal extends StatefulWidget {
  final VoidCallback onCancelPressed;
  final VoidCallback onReportCreated;

  const IzvjestajModal({
    required this.onCancelPressed,
    required this.onReportCreated,
    Key? key,
  }) : super(key: key);

  @override
  _IzvjestajModalState createState() => _IzvjestajModalState();
}

class _IzvjestajModalState extends State<IzvjestajModal> {
  SearchResult<Recept>? recepti;
  late RecipeProvider _recipeProvider;
  Recept? selectedRecept;
  late IzvjestajProvider _izvjestajProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _recipeProvider = context.read<RecipeProvider>();
    _izvjestajProvider = context.read<IzvjestajProvider>();
    fetchRecipe();
  }

  Future<void> fetchRecipe({String query = ''}) async {
    try {
      var filter = {};
      var result = await _recipeProvider.get(filter: filter);
      setState(() {
        recepti = result;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: const Color.fromRGBO(247, 249, 253, 1),
          width: MediaQuery.of(context).size.width * 0.4,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Kreiraj izvještaj za određeni recept",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 38, 80, 39))),
              const SizedBox(height: 20),
              DropdownButtonFormField<Recept>(
                decoration: const InputDecoration(
                  labelText: "Odaberi recept",
                  labelStyle: TextStyle(color: Color.fromARGB(255, 28, 50, 29)),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                value: selectedRecept,
                items: (recepti?.result ?? []).map((recept) {
                  return DropdownMenuItem(
                    value: recept,
                    child: Text(recept.naziv ?? ""),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRecept = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: widget.onCancelPressed,
                    child: const Text(
                      "Otkaži",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedRecept != null) {
                        _izvjestajProvider
                            .insertIzvjestaj(selectedRecept!.receptId)
                            .then((_) {
                          widget.onReportCreated();
                          Navigator.pop(context);
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Molimo odaberite recept")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Kreiraj izvještaj"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
