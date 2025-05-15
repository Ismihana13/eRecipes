import 'package:erecipes_desktop/models/recept_sastojak.dart';
import 'package:flutter/material.dart';

class SastojciListCard extends StatelessWidget {
  final List<ReceptSastojak> sastojciList;

  const SastojciListCard({super.key, required this.sastojciList});

  @override
  Widget build(BuildContext context) {
    if (sastojciList.isEmpty) {
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
              itemCount: sastojciList.length,
              itemBuilder: (context, index) {
                var sastojak = sastojciList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          sastojak.sastojak?.naziv ?? 'N/A',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 19, 51, 34),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${sastojak.kolicina?.toStringAsFixed(1) ?? '0'} '
                          '${sastojak.mjernaJedinica?.naziv ?? ''}',
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
