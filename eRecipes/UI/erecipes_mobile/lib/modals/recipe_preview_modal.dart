import 'dart:convert';
import 'package:erecipes_mobile/models/recept.dart';
import 'package:erecipes_mobile/models/sastojak.dart';
import 'package:erecipes_mobile/providers/recipe_provider.dart';
import 'package:erecipes_mobile/screens/recipe_list_screen.dart';
import 'package:erecipes_mobile/widgets/custom_title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipePreviewModal extends StatelessWidget {
  final Recept recept;
  final List<Sastojak> sastojci;
  const RecipePreviewModal({
    super.key,
    required this.recept,
    required this.sastojci,
  });

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CustomTitleText(title: 'Pregled recepta'),
              ),
              recept.slika != null
                  ? Image.memory(
                      const Base64Decoder().convert(recept.slika!),
                      fit: BoxFit.cover,
                    )
                  : const Text('Nema slike'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      recept.naziv ?? 'Nepoznato ime recepta',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${recept.vrijemePripreme ?? 'N/A'} min',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 5),
                      const Icon(Icons.access_time,
                          size: 24, color: Colors.grey),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(recept.opisRecepta ?? 'Nema opisa'),
              const SizedBox(height: 10),
              _buildSastojciList(),
              const SizedBox(height: 10),
              const Text(
                'Način pripreme:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(recept.opisPripreme ?? 'Nema opisa pripreme'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Zatvori")),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        var newRecipe = await recipeProvider.insert(recept);
    
                        final result = await Provider.of<RecipeProvider>(
                                context,
                                listen: false)
                            .addSastojkeToRecept(newRecipe.receptId!,
                                sastojci);
                        if (result == "Sastojci su uspješno dodani!") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Recept uspješno objavljen!",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Color.fromARGB(255, 53, 92, 54),
                              duration: Duration(seconds: 3),
                            ),
                          );
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RecipeListScreen()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text("Došlo je do greške: $result")),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Došlo je do greške: $e")),
                        );
                      }
                    },
                    child: const Text("Objavi recept"),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSastojciList() {
    if (sastojci.isEmpty) {
      return const Center(
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
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color.fromARGB(199, 244, 242, 242),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Potrebni sastojci:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 52, 52, 52),
              ),
            ),
            const SizedBox(
              width: 13,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: sastojci.length,
              itemBuilder: (context, index) {
                var sastojak = sastojci[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          sastojak.naziv ?? 'N/A',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 19, 51, 34),
                          ),
                        ),
                      ),
                        Expanded(
                        child: Text(
                          '${sastojak.kolicina ?? '0'} '
                          '${sastojak.nazivMjerneJedinice ?? 'N/A'}',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 90, 90, 90),
                          ),
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
}
