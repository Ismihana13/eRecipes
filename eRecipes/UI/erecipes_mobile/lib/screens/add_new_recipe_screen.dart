import 'dart:convert';
import 'dart:io';
import 'package:erecipes_mobile/modals/new_ingredient_modal.dart';
import 'package:erecipes_mobile/modals/recipe_preview_modal.dart';
import 'package:erecipes_mobile/models/kategorija.dart';
import 'package:erecipes_mobile/models/mjerna_jedinica.dart';
import 'package:erecipes_mobile/models/recept.dart';
import 'package:erecipes_mobile/models/sastojak.dart';
import 'package:erecipes_mobile/models/search_result.dart';
import 'package:erecipes_mobile/models/vrsta_jela.dart';
import 'package:erecipes_mobile/providers/kategorija_provider.dart';
import 'package:erecipes_mobile/providers/mjerna_jedinica_provider.dart';
import 'package:erecipes_mobile/providers/sastojak_provider.dart';
import 'package:erecipes_mobile/providers/vrsta_jela_provider.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:erecipes_mobile/widgets/custom_title_text.dart';
import 'package:erecipes_mobile/widgets/input_text.dart';
import 'package:erecipes_mobile/widgets/multiselect_sastojal.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class AddNewRecipeScreen extends StatefulWidget {
  static const String routeName = "/addNewRecipe";
  const AddNewRecipeScreen({super.key});

  @override
  State<AddNewRecipeScreen> createState() => AddNewRecipeScreenState();
}

class AddNewRecipeScreenState extends State<AddNewRecipeScreen> {
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
  late MjernaJedinicaProvider _mjernaJedinicaProvider;
  SearchResult<Kategorija>? kategorijaResult;
  SearchResult<VrstaJela>? vrstaJelaResult;
  SearchResult<Sastojak>? sastojakResult;
  SearchResult<MjernaJedinica>? mjernaJedinicaResult;
  bool isLoading = true;
  String? _selectedKategorijaId;
  String? _selectedMjernaJedinicaId;
  String? _selectedVrstaJelaId;
  String _imageText = 'Select image';
  File? _image;
  String? _base64Image;
  String? _imageError;
  List<Sastojak> _selectedSastojci = [];
  String? sastojciError;

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
    _mjernaJedinicaProvider = context.read<MjernaJedinicaProvider>();
    initForm();
  }

  Future<void> initForm() async {
    kategorijaResult = await _kategorijaProvider.get();
    vrstaJelaResult = await _vrstaJelaProvider.get();
    sastojakResult = await _sastojakProvider.get();
    mjernaJedinicaResult = await _mjernaJedinicaProvider.get();
    if(mjernaJedinicaResult!= null && mjernaJedinicaResult!.result.isNotEmpty){
      _selectedMjernaJedinicaId=mjernaJedinicaResult!.result.first.mjernaJedinicaId.toString();
    }
    if (kategorijaResult != null && kategorijaResult!.result.isNotEmpty) {
      _selectedKategorijaId =
          kategorijaResult!.result.first.kategorijaId.toString();
    }
    if (vrstaJelaResult != null && vrstaJelaResult!.result.isNotEmpty) {
      _selectedVrstaJelaId =
          vrstaJelaResult!.result.first.vrstaJelaId.toString();
    }
    setState(() {
      isLoading = false;
    });
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

  void getImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      setState(() {
        _image = File(result.files.single.path!);
        _base64Image = base64Encode(_image!.readAsBytesSync());
        _imageText = 'Odabrali ste sliku';
        _imageError = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(naslov: 'eRecipes'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const CustomTitleText(title: 'Dodajte novi recept'),
            isLoading
                ? const CircularProgressIndicator()
                : _buildFormForRecipe(),
          ],
        ),
      ),
    );
  }

  Widget _buildFormForRecipe() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              InputText(
                controller: _recipeNameController,
                label: 'Naslov recepta',
                hint: 'Unesite naziv recepta',
              ),
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
              Row(
                children: [
                  Expanded(
                      child: FormBuilderField(
                    name: "imageId",
                    builder: (field) {
                      return InputDecorator(
                        decoration:
                            const InputDecoration(labelText: "Odaberite sliku"),
                        child: ListTile(
                          leading: const Icon(Icons.image),
                          title: Text(_imageText),
                          trailing: const Icon(Icons.file_upload),
                          onTap: getImage,
                        ),
                      );
                    },
                  ))
                ],
              ),
              if (_imageError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _imageError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 30),
              MultiSelectSastojak(
                label: 'Potrebni sastojci',
                items: sastojakResult?.result,
                selectedSastojci: _selectedSastojci,
                onChanged: (List<Sastojak> selectedItems) {
                  setState(() {
                    _selectedSastojci = selectedItems;
                    if (_selectedSastojci.isNotEmpty) {
                      sastojciError = null;
                    }
                  });
                },
                errorMessage: sastojciError,
              ),
              ElevatedButton(
                onPressed: () {
                  openDialog();
                },
                child: const Text('Dodaj novi sastojak',
                    style: TextStyle(fontSize: 16)),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Dodajte količinu i mjernu jedinicu",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                children: _selectedSastojci.map((su) {
                  return Row(
                    children: [
                      Expanded(child: Text(su.naziv ?? "Nepoznat sastojak")),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Količina'),
                            onChanged:  (value) => su.kolicina = value,
                            ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: DropdownButtonFormField<String>(
                          value: _selectedMjernaJedinicaId,
                          decoration: const InputDecoration(labelText: 'Mjera'),
                          items: mjernaJedinicaResult?.result.map((jedinica) {
                            return DropdownMenuItem<String>(
                              // ignore: unnecessary_type_check
                              value: jedinica is MjernaJedinica
                                  ? jedinica.mjernaJedinicaId.toString()
                                  : "",
                              child: Text(jedinica.naziv ?? ""),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedMjernaJedinicaId = value;
        su.mjernaJedinicaId = int.tryParse(value!);
                            });
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 30,
              ),
              _buildDropdown(
                  'Kategorija jela',
                  kategorijaResult?.result,
                  _selectedKategorijaId,
                  (value) => setState(() => _selectedKategorijaId = value)),
              const SizedBox(height: 30),
              _buildDropdown(
                  'Vrsta jela',
                  vrstaJelaResult?.result,
                  _selectedVrstaJelaId,
                  (value) => setState(() => _selectedVrstaJelaId = value)),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                child: const Text(
                  'Pregledaj recept',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
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
      if (_image == null) {
        setState(() {
          _imageError = 'Slika je obavezna';
        });
        return;
      }
      if (_selectedSastojci.isEmpty) {
        setState(() {
          sastojciError = 'Morate odabrati sastojke';
        });
        return;
      }

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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return RecipePreviewModal(
              recept: newRecipe, sastojci: _selectedSastojci);
        },
      );
    }
  }
}
