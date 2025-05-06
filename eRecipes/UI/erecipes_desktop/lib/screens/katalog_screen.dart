import 'package:flutter/material.dart';

class KatalogScreen extends StatelessWidget {
  const KatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // Ovdje pozovi dijalog/formu za dodavanje kataloga
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Dodaj novi katalog'),
                    content: const Text('Ovdje ide forma ili unos.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Zatvori'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Dodaj katalog'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ),
        const Expanded(
          child: Center(
            child: Text('Lista kataloga (ovdje dolazi sadržaj)'),
          ),
        ),
      ],
    );
  }
}
