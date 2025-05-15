import 'dart:convert';
import 'dart:io';
import 'package:erecipes_mobile/modals/new_ingredient_modal.dart';
import 'package:erecipes_mobile/models/kategorija.dart';
import 'package:erecipes_mobile/models/mjerna_jedinica.dart';
import 'package:erecipes_mobile/models/recept_sastojak.dart';
import 'package:erecipes_mobile/models/sastojak.dart';
import 'package:erecipes_mobile/models/search_result.dart';
import 'package:erecipes_mobile/models/vrsta_jela.dart';
import 'package:erecipes_mobile/providers/kategorija_provider.dart';
import 'package:erecipes_mobile/providers/mjerna_jedinica_provider.dart';
import 'package:erecipes_mobile/providers/recipe_provider.dart';
import 'package:erecipes_mobile/providers/sastojak_provider.dart';
import 'package:erecipes_mobile/providers/vrsta_jela_provider.dart';
import 'package:erecipes_mobile/screens/edit_sastojci_list_card.dart';
import 'package:erecipes_mobile/widgets/custom_snack_bar.dart';
import 'package:erecipes_mobile/widgets/input_text.dart';
import 'package:erecipes_mobile/widgets/multiselect_sastojal.dart';
import 'package:file_picker/file_picker.dart';
import 'package:erecipes_mobile/models/recept.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:erecipes_mobile/widgets/custom_title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditRecipeScreen extends StatefulWidget {
  final Recept recept;
  final sastojci;

  const EditRecipeScreen({super.key, required this.recept, this.sastojci});

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _recipeDescriptionController =
      TextEditingController();
  final TextEditingController _preparationDescriptionController =
      TextEditingController();
  final TextEditingController _preparationTimeController =
      TextEditingController();
  late KategorijaProvider _kategorijaProvider;
  late VrstaJelaProvider _vrstaJelaProvider;
  late SastojakProvider _sastojakProvider;
  late RecipeProvider _recipeProvider;
  late MjernaJedinicaProvider _mjernaJedinicaProvider;
  SearchResult<Kategorija>? kategorijaResult;
  SearchResult<VrstaJela>? vrstaJelaResult;
  SearchResult<Sastojak>? sastojakResult;
  SearchResult<MjernaJedinica>? mjernaJedinicaResult;
  String? _selectedKategorijaId;
  String? _selectedVrstaJelaId;
  File? _image;
  String? _base64Image;
  String? _selectedMjernaJedinicaId;
  List<ReceptSastojak> newSastojci = [];
  List<Sastojak> selectedSastojakIds = [];
  String? sastojciError;
  bool? open;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _kategorijaProvider = context.read<KategorijaProvider>();
    _vrstaJelaProvider = context.read<VrstaJelaProvider>();
    _sastojakProvider = context.read<SastojakProvider>();
    _recipeProvider = context.read<RecipeProvider>();
    _mjernaJedinicaProvider = context.read<MjernaJedinicaProvider>();
    _recipeNameController.text = widget.recept.naziv ?? "";
    _recipeDescriptionController.text = widget.recept.opisRecepta ?? "";
    _preparationDescriptionController.text = widget.recept.opisPripreme ?? "";
    _preparationTimeController.text =
        widget.recept.vrijemePripreme?.toString() ?? "";
    _selectedKategorijaId = widget.recept.kategorijaId.toString();
    _selectedVrstaJelaId = widget.recept.vrstaJelaId.toString();

    if (widget.recept.slika != null) {
      _base64Image = widget.recept.slika;
    }
    initForm();
  }

  Future<void> initForm() async {
    sastojakResult = await _sastojakProvider.get();
    kategorijaResult = await _kategorijaProvider.get();
    vrstaJelaResult = await _vrstaJelaProvider.get();
    mjernaJedinicaResult = await _mjernaJedinicaProvider.get();
    _selectedKategorijaId = widget.recept.kategorijaId.toString();
    _selectedVrstaJelaId = widget.recept.vrstaJelaId.toString();
    if (mjernaJedinicaResult != null &&
        mjernaJedinicaResult!.result.isNotEmpty) {
      _selectedMjernaJedinicaId =
          mjernaJedinicaResult!.result.first.mjernaJedinicaId.toString();
    }
    setState(() {});
  }

  void getImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      setState(() {
        _image = File(result.files.single.path!);
        _base64Image = base64Encode(_image!.readAsBytesSync());
      });
    }
  }

  void openDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NewIngredientModal(
          onIngredientAdded: () async {
            var noviSastojci = await _sastojakProvider.get();
            setState(() {
              sastojakResult = noviSastojci;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(naslov: "eRecipes"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const CustomTitleText(title: 'Uredi recept'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: _base64Image == null
                          ? (widget.recept.slika == null
                              ? const Placeholder()
                              : Image.memory(
                                  base64Decode(widget.recept.slika!),
                                  fit: BoxFit.cover,
                                ))
                          : Image.memory(
                              base64Decode(_base64Image!),
                              fit: BoxFit.cover,
                            ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: ElevatedButton(
                        onPressed: getImage,
                        child: const Text('Promjeni sliku'),
                      ),
                    ),
                  ],
                ),
              ),
              _buildRecipedetails(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecipedetails() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.00),
        child: Column(
          children: [
            const SizedBox(height: 13),
            InputText(
                controller: _recipeNameController,
                label: "Naslov recepta",
                hint: 'Unesite naziv recepta'),
            const SizedBox(height: 20),
            InputText(
              controller: _recipeDescriptionController,
              label: 'Opis recepta',
              hint: 'Unesite opis recepta',
              maxLines: 4,
            ),
            const SizedBox(height: 20),
            InputText(
              controller: _preparationDescriptionController,
              label: 'Opis pripreme',
              hint: 'Unesite opis pripreme',
              maxLines: 4,
            ),
            const SizedBox(height: 20),
            InputText(
              controller: _preparationTimeController,
              label: 'Vrijeme pripreme (u minutama)',
              hint: 'Unesite vrijeme pripreme',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),
            _buildDropdown(
                'Kategorija jela',
                kategorijaResult?.result,
                _selectedKategorijaId,
                (value) => setState(() => _selectedKategorijaId = value)),
            _buildDropdown(
                'Vrsta jela',
                vrstaJelaResult?.result,
                _selectedVrstaJelaId,
                (value) => setState(() => _selectedVrstaJelaId = value)),
            const SizedBox(height: 30),
            EditSastojciListCard(
              sastojciList: widget.sastojci,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  open = true;
                });
              },
              child: const Text('Dodaj novi sastojak',
                  style: TextStyle(fontSize: 16)),
            ),
            if (open == true)
              MultiSelectSastojak(
                label: 'Potrebni sastojci',
                items: sastojakResult?.result,
                selectedSastojci: selectedSastojakIds,
                onChanged: (List<Sastojak> selectedItems) {
                  setState(() {
                    selectedSastojakIds = selectedItems;
                  });
                },
                errorMessage: sastojciError,
              ),
            if (selectedSastojakIds.isNotEmpty)
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Dodajte količinu i mjernu jedinicu",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            Column(
              children: selectedSastojakIds.map((su) {
                if (su.nazivMjerneJedinice == null &&
                    _selectedMjernaJedinicaId != null) {
                  final jedinica = mjernaJedinicaResult?.result.firstWhere(
                    (element) =>
                        element.mjernaJedinicaId.toString() ==
                        _selectedMjernaJedinicaId,
                    orElse: () => MjernaJedinica(),
                  );
                  su.nazivMjerneJedinice = jedinica?.naziv;
                  su.mjernaJedinicaId = jedinica?.mjernaJedinicaId;
                }
                return Row(
                  children: [
                    Expanded(child: Text(su.naziv ?? "Nepoznat sastojak")),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Količina'),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Unesite količinu';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Mora biti broj.';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              final index = selectedSastojakIds.indexWhere(
                                  (s) => s.sastojakId == su.sastojakId);
                              if (index != -1) {
                                selectedSastojakIds[index].kolicina =
                                    double.tryParse(value) ?? 0.0;
                              }
                            });
                          }),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField<String>(
                        value: su.mjernaJedinicaId?.toString(),
                        decoration: const InputDecoration(labelText: 'Mjera'),
                        items: mjernaJedinicaResult?.result.map((jedinica) {
                          return DropdownMenuItem<String>(
                            value: jedinica.mjernaJedinicaId.toString(),
                            child: Text(jedinica.naziv ?? ""),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            su.mjernaJedinicaId = int.tryParse(value!);
                            final jedinica =
                                mjernaJedinicaResult?.result.firstWhere(
                              (element) =>
                                  element.mjernaJedinicaId.toString() == value,
                              orElse: () => MjernaJedinica(),
                            );
                            su.nazivMjerneJedinice = jedinica?.naziv;
                          });
                        },
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            if (open == true)
              ElevatedButton(
                onPressed: () {
                  openDialog();
                },
                child: const Text('Dodaj novi sastojak u listu sastojaka',
                    style: TextStyle(fontSize: 16)),
              ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: _onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
              child: const Text('Sačuvaj promjene'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List? items, String? selectedValue,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedValue,
          onChanged: onChanged,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: items?.map((item) {
            return DropdownMenuItem<String>(
              value: item is Kategorija
                  ? item.kategorijaId.toString()
                  : item is VrstaJela
                      ? item.vrstaJelaId.toString()
                      : '',
              child: Text(item is Kategorija
                  ? item.naziv ?? "Nepoznata kategorija"
                  : item is VrstaJela
                      ? item.naziv ?? "Nepoznata vrsta jela"
                      : ""),
            );
          }).toList(),
          validator: (value) => value == null ? 'Odaberite opciju' : null,
        ),
      ],
    );
  }

  void _onSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      String recipeName = _recipeNameController.text;
      String recipeDescription = _recipeDescriptionController.text;
      String preparationDescription = _preparationDescriptionController.text;
      int preparationTime = int.tryParse(_preparationTimeController.text) ?? 0;
      int? kategorijaId = int.tryParse(_selectedKategorijaId ?? '');
      int? vrstaJelaId = int.tryParse(_selectedVrstaJelaId ?? '');
      String? base64Image = _base64Image;

      Recept newRecipe = Recept(
        naziv: recipeName,
        opisRecepta: recipeDescription,
        opisPripreme: preparationDescription,
        vrijemePripreme: preparationTime,
        kategorijaId: kategorijaId,
        vrstaJelaId: vrstaJelaId,
        slika: base64Image,
      );

      for (var sastojak in widget.sastojci) {
        print(
            'Naziv: ${sastojak.sastojak?.sastojakId}, Količina: ${sastojak.kolicina}, Mjerna jedinica: ${sastojak.mjernaJedinica?.naziv}');
      }

      var id = widget.recept.receptId;
      await _recipeProvider.update(id!, newRecipe);
      await _recipeProvider.updateSastojci(
        id,
        widget.sastojci,
      );
      if (selectedSastojakIds.isNotEmpty) {
        await Provider.of<RecipeProvider>(context, listen: false)
            .addSastojkeToRecept(widget.recept.receptId!, selectedSastojakIds);
      }
      CustomSnackBar.showSuccessSnackBar(
          context, 'Izvršili ste promjene na receptu!');

      Navigator.pop(context, 2);
    }
  }
}
