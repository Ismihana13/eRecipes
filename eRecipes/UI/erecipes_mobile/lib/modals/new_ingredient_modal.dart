import 'package:erecipes_mobile/models/sastojak.dart';
import 'package:erecipes_mobile/widgets/custom_title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:erecipes_mobile/providers/sastojak_provider.dart';

class NewIngredientModal extends StatelessWidget {
  const NewIngredientModal({super.key});

  @override
  Widget build(BuildContext context) {
    final sastojakProvider = Provider.of<SastojakProvider>(context, listen: false);
    final TextEditingController nazivrecepta = TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CustomTitleText(title: 'Dodajte novi sastojak'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: nazivrecepta,
                decoration: const InputDecoration(
                  labelText: 'Naziv sastojka',
                  hintText: 'Unesite naziv sastojka',
                  border: OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Polje ne može biti prazno';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: const Text('Zatvori'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final naziv = nazivrecepta.text;
                      if (naziv.isNotEmpty) {
                        try {
                          Sastojak newSastojak = Sastojak(naziv: naziv);

                          // Poziv na backend za unos sastojka
                          sastojakProvider.addSastojak(newSastojak);
                         
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Dodali ste novi sastojak u listu sastojaka."),
                            ),
                          );
                        } catch (e) {
                          // Uhvatiti grešku ako sastojak već postoji
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Greška prilikom dodavanja ili postoji taj sastojak."),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Naziv sastojka ne može biti prazan."),
                          ),
                        );
                      }
                    },
                    child: const Text('Dodaj sastojak'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
