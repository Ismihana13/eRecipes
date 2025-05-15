import 'package:erecipes_mobile/models/sastojak.dart';
import 'package:erecipes_mobile/widgets/custom_title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:erecipes_mobile/providers/sastojak_provider.dart';

class NewIngredientModal extends StatefulWidget {
  final VoidCallback onIngredientAdded;

  const NewIngredientModal({super.key, required this.onIngredientAdded});

  @override
  State<NewIngredientModal> createState() => _NewIngredientModalState();
}

class _NewIngredientModalState extends State<NewIngredientModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nazivrecepta = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sastojakProvider =
        Provider.of<SastojakProvider>(context, listen: false);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Naziv sastojka ne može biti prazan';
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
                        if (_formKey.currentState!.validate()) {
                          final naziv = nazivrecepta.text;
                          try {
                            Sastojak newSastojak = Sastojak(naziv: naziv);
                            await sastojakProvider.insert(newSastojak);

                            widget.onIngredientAdded();
                            Navigator.pop(context);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Dodali ste novi sastojak u listu sastojaka."),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Greška prilikom dodavanja ili sastojak već postoji."),
                              ),
                            );
                          }
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
      ),
    );
  }
}
