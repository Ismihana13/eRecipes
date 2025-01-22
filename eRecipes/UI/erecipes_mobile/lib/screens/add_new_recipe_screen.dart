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
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
  List<String> _selectedSastojci = []; // List to store selected ingredients


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
      appBar: AppBar(
        title: const Text('eRecipes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
        backgroundColor: const Color.fromRGBO(1, 100, 34, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Row(
                  children: [
                    Text('Dobro došli!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Icon(Icons.person, color: Colors.black, size: 24),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text('Dodajte novi recept', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xCC0D3E09))),
            isLoading ? CircularProgressIndicator() : _buildFormForRecipe(),
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
                                  decoration: InputDecoration(labelText: "Odaberite sliku"),
                                  child: ListTile(
                                      leading: Icon(Icons.image),
                                      title: Text(_imageText),
                                      trailing: Icon(Icons.file_upload),
                                      onTap: getImage,
                                  ),
                                );
                            },
                          )
                        )],
            ),  if (_imageError != null) // Prikaz poruke o grešci
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
      // Prikazivanje liste sastojaka kao checkbox
      ...?items?.map((sastojak) {
        return CheckboxListTile(
          title: Text(sastojak.naziv ?? "Nepoznat sastojak"),
          value: _selectedSastojci.contains(sastojak.sastojakId.toString()),
          onChanged: (bool? selected) {
            setState(() {
              if (selected == true) {
                _selectedSastojci.add(sastojak.sastojakId.toString());
              } else {
                _selectedSastojci.remove(sastojak.sastojakId.toString());
              }
            });
          },
        );
      }).toList(),
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
        borderSide: BorderSide(color: Colors.red), // Red border on error
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red), // Red border when focused
      ),
      suffixIcon: label == 'Vrijeme pripreme (u minutama)' 
        ? const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.access_time), // Icon of a clock
          )
        : null, // No icon for other fields
    ),
    validator: (value) {
      if (value?.isEmpty ?? true) {
        return 'The field cannot be empty'; // Error message when field is empty
      }
      // Check if the value is a valid number for "Vrijeme pripreme"
      if (label == 'Vrijeme pripreme (u minutama)' && int.tryParse(value ?? '') == null) {
        return 'Please enter a number'; // Error message for non-numeric value
      }
      return null; // No error if the field is not empty and is a number
    },
    maxLines: maxLines,
    keyboardType: keyboardType,
  );
}

/*Widget _buildDropdownSastojak(String label, List<Sastojak>? items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      const SizedBox(height: 8),
      DropDownMultiSelect(
        onChanged: (List<String> selectedItems) {
          setState(() {
            _selectedSastojci = selectedItems;
          });
        },
        options: items!.map((item) => item.naziv ?? "Nepoznat sastojak").toList(),
        selectedValues: _selectedSastojci,
        whenEmpty: 'Odaberite sastojke',
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ),
      ),
    ],
  );
}*/


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
        _imageError = 'Slika je obavezna'; // Poruka o grešci
      });
      return; // Ne šaljemo formu dok korisnik ne odabere sliku
    }

    // Ako je slika odabrana, nastavi sa submit-ovanjem
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

    // Pozivanje metode za unos recepta
    // await _recipeProvider.insert(newRecipe);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RecipePreviewModal(recept: newRecipe);
      },
    );
  } else {
    print("Form validation failed");
  }
}

}


