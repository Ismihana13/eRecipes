import 'package:erecipes_mobile/models/sastojak.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

class MultiSelectSastojak extends StatefulWidget {
  final String label;
  final List<Sastojak>? items;
  final List<Sastojak>? selectedSastojci;
  final Function(List<Sastojak>) onChanged;
  final String? errorMessage;

  const MultiSelectSastojak({
    Key? key,
    required this.label,
    required this.items,
    required this.selectedSastojci,
    required this.onChanged,
    this.errorMessage,
  }) : super(key: key);

  @override
  _MultiSelectSastojakState createState() => _MultiSelectSastojakState();
}

class _MultiSelectSastojakState extends State<MultiSelectSastojak> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        const SizedBox(height: 8),
        DropDownMultiSelect<String>(
          onChanged: (List<String> selectedValues) {
            setState(() {
              if (selectedValues.isEmpty) {
                widget.onChanged([]);
              } else {
                widget.onChanged(widget.items!
                    .where((sastojak) => selectedValues
                        .contains(sastojak.naziv ?? "Nepoznat sastojak"))
                    .toList()
                  ..sort((a, b) {
                    int indexA = selectedValues.indexOf(a.naziv ?? "");
                    int indexB = selectedValues.indexOf(b.naziv ?? "");
                    return indexA.compareTo(indexB);
                  }));
              }
            });
          },
          options: widget.items
                  ?.map((sastojak) => sastojak.naziv ?? "Nepoznat sastojak")
                  .toList() ??
              [],
          selectedValues: widget.selectedSastojci!
              .map((sastojak) => sastojak.naziv ?? "Nepoznat sastojak")
              .toList(),
          selectedValuesStyle: const TextStyle(fontSize: 0.0),
          hint: const Text("Odaberite potrebne sastojke"),
        ),
        if (widget.errorMessage != null)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                widget.errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            ),
          ),
      ],
    );
  }
}
