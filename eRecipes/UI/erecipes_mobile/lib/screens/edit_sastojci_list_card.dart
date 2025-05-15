import 'package:erecipes_mobile/models/mjerna_jedinica.dart';
import 'package:erecipes_mobile/models/recept_sastojak.dart';
import 'package:erecipes_mobile/models/search_result.dart';
import 'package:erecipes_mobile/providers/mjerna_jedinica_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditSastojciListCard extends StatefulWidget {
  final List<ReceptSastojak> sastojciList;
  final VoidCallback? onSastojciChanged;
  final bool?  open;

  const EditSastojciListCard({
    super.key,
    required this.sastojciList,
    this.onSastojciChanged,
    required this.open,
  });

  @override
  State<EditSastojciListCard> createState() => _EditSastojciListCardState();
}

class _EditSastojciListCardState extends State<EditSastojciListCard> {
  late List<TextEditingController> kolicinaControllers;
  late MjernaJedinicaProvider _mjernaJedinicaProvider;
  SearchResult<MjernaJedinica>? mjernaJedinicaResult;

  @override
  void initState() {
    super.initState();

    _mjernaJedinicaProvider = context.read<MjernaJedinicaProvider>();
    _loadMjerneJedinice();
    kolicinaControllers = widget.sastojciList
        .map((sastojak) =>
            TextEditingController(text: sastojak.kolicina?.toString() ?? '0.0'))
        .toList();
    if (mjernaJedinicaResult != null &&
        mjernaJedinicaResult!.result.isNotEmpty) {}
  }

  void _loadMjerneJedinice() async {
    mjernaJedinicaResult = await _mjernaJedinicaProvider.get();
    if (mjernaJedinicaResult != null &&
        mjernaJedinicaResult!.result.isNotEmpty) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    for (var controller in kolicinaControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (mjernaJedinicaResult == null || mjernaJedinicaResult!.result.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (widget.sastojciList.isEmpty) {
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
              itemCount: widget.sastojciList.length,
              itemBuilder: (context, index) {
                var sastojak = widget.sastojciList[index];
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
                        child: TextField(
                          controller: kolicinaControllers[index],
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: const InputDecoration(
                            hintText: 'Unesite količinu',
                            labelText: 'Količina',
                          ),
                          onChanged: (value) {
                            setState(() {
                              sastojak.kolicina = double.tryParse(value) ?? 0.0;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: DropdownButtonFormField<String>(
                          value: sastojak.mjernaJedinicaId?.toString(),
                          decoration: const InputDecoration(labelText: 'Mjera'),
                          items: mjernaJedinicaResult?.result.map((jedinica) {
                            return DropdownMenuItem<String>(
                              value: jedinica.mjernaJedinicaId.toString(),
                              child: Text(jedinica.naziv ?? ""),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              sastojak.mjernaJedinicaId = int.tryParse(value!);
                              final jedinica =
                                  mjernaJedinicaResult?.result.firstWhere(
                                (element) =>
                                    element.mjernaJedinicaId.toString() ==
                                    value,
                                orElse: () => MjernaJedinica(),
                              );
                              sastojak.mjernaJedinica!.naziv = jedinica?.naziv;
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            widget.sastojciList.removeAt(index);
                            kolicinaControllers.removeAt(index);
                          });
                          if (widget.onSastojciChanged != null) {
                            widget.onSastojciChanged!();
                          }
                        },
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
