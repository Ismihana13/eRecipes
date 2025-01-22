import 'dart:convert';
import 'package:erecipes_mobile/models/recept.dart';
import 'package:erecipes_mobile/providers/recipe_provider.dart';
import 'package:erecipes_mobile/screens/recipe_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipePreviewModal extends StatelessWidget {
  final Recept recept;
  const RecipePreviewModal({super.key, required this.recept});

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
                  child: Text(
                'Pregled recepta',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xCC0D3E09)),
              )),
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
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                      const Icon(Icons.access_time, size: 24, color: Colors.grey),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(recept.opisRecepta ?? 'Nema opisa'),
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
                      onPressed: () => Navigator.of(context).pop(), child: const Text("Zatvori")),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await recipeProvider.insert(recept);
                        Navigator.of(context).pop();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const RecipeListScreen()), 
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Recept je uspješno objavljen!')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Greška pri objavljivanju recepta')),
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
}
