import 'dart:convert';
import 'dart:io';
import 'package:erecipes_mobile/modals/recipe_preview_modal.dart';
import 'package:erecipes_mobile/models/kategorija.dart';
import 'package:erecipes_mobile/models/recept.dart';
import 'package:erecipes_mobile/models/sastojak.dart';
import 'package:erecipes_mobile/models/search_result.dart';
import 'package:erecipes_mobile/models/vrsta_jela.dart';
import 'package:erecipes_mobile/providers/kategorija_provider.dart';
import 'package:erecipes_mobile/providers/recipe_provider.dart';
import 'package:erecipes_mobile/providers/sastojak_provider.dart';
import 'package:erecipes_mobile/providers/vrsta_jela_provider.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:erecipes_mobile/widgets/welcome_row.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:multiselect/multiselect.dart';
import 'package:provider/provider.dart';

class AddNewRecipeScreen extends StatefulWidget {
  const AddNewRecipeScreen({super.key});

  @override
  State<AddNewRecipeScreen> createState() => AddNewRecipeScreenState();
}

class AddNewRecipeScreenState extends State<AddNewRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _recipeDescriptionController = TextEditingController();
  final TextEditingController _preparationDescriptionController = TextEditingController();
  final TextEditingController _preparationTimeController = TextEditingController();

  late RecipeProvider _recipeProvider;
  late KategorijaProvider _kategorijaProvider;
  late VrstaJelaProvider _vrstaJelaProvider;
  late SastojakProvider _sastojakProvider;

  SearchResult<Kategorija>? kategorijaResult;
  SearchResult<VrstaJela>? vrstaJelaResult;
  SearchResult<Sastojak>? sastojakResult;
  
  bool isLoading = true;
  String? _selectedKategorijaId;
  String? _selectedVrstaJelaId;
String _imageText = 'Select image';
  File? _image;
  String? _base64Image;
  String? _imageError;
  List<Sastojak> _selectedSastojci = [];
  String? _recipeError;


  @override
  void initState() {
    super.initState();
    _recipeProvider = context.read<RecipeProvider>();
    _kategorijaProvider = context.read<KategorijaProvider>();
    _vrstaJelaProvider = context.read<VrstaJelaProvider>();
    _sastojakProvider=context.read<SastojakProvider>();
    initForm();
  }

  Future<void> initForm() async {
    kategorijaResult = await _kategorijaProvider.get();
    vrstaJelaResult = await _vrstaJelaProvider.get();
    sastojakResult=await _sastojakProvider.get();
    if (kategorijaResult != null && kategorijaResult!.result.isNotEmpty) {
      _selectedKategorijaId = kategorijaResult!.result.first.kategorijaId.toString();
    }
    if (vrstaJelaResult != null && vrstaJelaResult!.result.isNotEmpty) {
      _selectedVrstaJelaId = vrstaJelaResult!.result.first.vrstaJelaId.toString();
    }
    setState(() {
      isLoading = false;
    });
  }

  void getImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      setState(() {
        _image = File(result.files.single.path!);
        _base64Image = base64Encode(_image!.readAsBytesSync());
        _imageText = 'Odabrali ste sliku'; 
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
         const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    WelcomeRow(),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text('Dodajte novi recept', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xCC0D3E09))),
            isLoading ? const CircularProgressIndicator() : _buildFormForRecipe(),
          ],
        ),
      ),
    );
  }

  Widget _buildFormForRecipe() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildTextField(_recipeNameController, 'Naslov recepta', 'Unesite naziv recepta'),
            const SizedBox(height: 20),
            _buildTextField(_recipeDescriptionController, 'Opis recepta', 'Unesite opis recepta', maxLines: 4),
            const SizedBox(height: 20),
            _buildTextField(_preparationDescriptionController, 'Opis pripreme', 'Unesite opis pripreme', maxLines: 4),
            const SizedBox(height: 20),
            _buildTextField(_preparationTimeController, 'Vrijeme pripreme (u minutama)', 'Unesite vrijeme pripreme', keyboardType: TextInputType.number),
            const SizedBox(height: 30),
            Row(
              children: [  Expanded(
                        child: FormBuilderField(
                            name: "imageId",
                            builder: (field)  {
                                return InputDecorator(
                                  decoration: const InputDecoration(labelText: "Odaberite sliku"),
                                  child: ListTile(
                                      leading: const Icon(Icons.image),
                                      title: Text(_imageText),
                                      trailing: const Icon(Icons.file_upload),
                                      onTap: getImage,
                                  ),
                                );
                            },
                          )
                        )],
            ),  if (_imageError != null) 
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _imageError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            const SizedBox(height: 30),
            _buildDropdown('Kategorija jela', kategorijaResult?.result, _selectedKategorijaId, (value) => setState(() => _selectedKategorijaId = value)),
            const SizedBox(height: 30),
            _buildDropdown('Vrsta jela', vrstaJelaResult?.result, _selectedVrstaJelaId, (value) => setState(() => _selectedVrstaJelaId = value)),
            const SizedBox(height: 30),
              _buildMultiSelectSastojak('Potrebni sastojci', sastojakResult?.result),
              ElevatedButton(onPressed: (){

              }, 
              child: const Text('Dodaj novi sastojak', style: TextStyle(fontSize: 16)),),
             const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: _onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              child: const Text('Pregledaj recept'),
            ),
          ],
        ),
      ),
    );
  }

  
Widget _buildMultiSelectSastojak(String label, List<Sastojak>? items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      const SizedBox(height: 8),
      DropDownMultiSelect<String>(
        onChanged: (List<String> selectedValues) {
          setState(() {
            if (selectedValues.isEmpty) {
              _recipeError = 'Morate odabrati barem jedan sastojak.';
            } else {
              _selectedSastojci = items!.where((sastojak) {
                return selectedValues.contains(sastojak.naziv ?? "Nepoznat sastojak");
              }).toList();
              _selectedSastojci.sort((a, b) => a.naziv!.compareTo(b.naziv!));  
              _recipeError = null;  
            }
          });
        },
        options: items?.map((sastojak) => sastojak.naziv ?? "Nepoznat sastojak").toList() ?? [],
        selectedValues: _selectedSastojci.map((sastojak) => sastojak.naziv ?? "Nepoznat sastojak").toList(),
        selectedValuesStyle: const TextStyle(fontSize: 0.0),
        hint: const Text("Odaberite potrebne sastojke"),
      ),
      if (_recipeError != null) 
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            _recipeError!, 
            style: const TextStyle(color: Colors.red, fontSize: 14),
          ),
        ),
    ],
  );
}

Widget _buildTextField(TextEditingController controller, String label, String hint, {int maxLines = 1, TextInputType? keyboardType,}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      border: const OutlineInputBorder(),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red), 
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red), 
      ),
      suffixIcon: label == 'Vrijeme pripreme (u minutama)' 
        ? const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.access_time), 
          )
        : null, 
    ),
    validator: (value) {
      if (value?.isEmpty ?? true) {
        return 'The field cannot be empty'; 
      }
      if (label == 'Vrijeme pripreme (u minutama)' && int.tryParse(value ?? '') == null) {
        return 'Please enter a number'; 
      }
      return null; 
    },
    maxLines: maxLines,
    keyboardType: keyboardType,
  );
}

  Widget _buildDropdown(String label, List? items, String? selectedValue, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedValue,
          onChanged: onChanged,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: items?.map((item) {
            return DropdownMenuItem<String>(
              value: item is Kategorija ? item.kategorijaId.toString() : item is VrstaJela ? item.vrstaJelaId.toString() : '',
              child: Text(item is Kategorija ? item.naziv ?? "Nepoznata kategorija" : item is VrstaJela ? item.naziv ?? "Nepoznata vrsta jela" : ""),
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
        _recipeError = 'Morate odabrati sastojke'; 
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
        return RecipePreviewModal(recept: newRecipe, sastojci:_selectedSastojci);
      },
    );
  }
}
}
class MultiDropdown extends StatefulWidget {
  final 
  String label;final List<Sastojak>? items;
  const MultiDropdown({super.key, required this.label, this.items});

  @override
  State<MultiDropdown> createState() => _MultiDropdownState();
}

class _MultiDropdownState extends State<MultiDropdown> {
  List<String> selectedSastojci=[];


  @override
  Widget build(BuildContext context) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(widget.label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      const SizedBox(height: 8),
      DropDownMultiSelect<String>(
        onChanged: (List<String> selectedValues) {
          setState(() {
           selectedSastojci = selectedValues..sort();  
          });
        },
        options: widget.items?.map((sastojak) => sastojak.naziv ?? "Nepoznat sastojak").toList() ?? [],
        selectedValues: selectedSastojci,
        hint: Text("" )
      ),
    ],
  );
  }
}