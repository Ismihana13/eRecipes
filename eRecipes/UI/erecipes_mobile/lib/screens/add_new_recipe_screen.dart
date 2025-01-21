import 'dart:convert';
import 'dart:io';

import 'package:erecipes_mobile/models/kategorija.dart';
import 'package:erecipes_mobile/models/search_result.dart';
import 'package:erecipes_mobile/models/vrsta_jela.dart';
import 'package:erecipes_mobile/providers/kategorija_provider.dart';
import 'package:erecipes_mobile/providers/recipe_provider.dart';
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
  final TextEditingController _recipeDescriptionController =TextEditingController();
  final TextEditingController _preparationDescriptionController =TextEditingController();
  final TextEditingController _preparationTimeController =TextEditingController();
  late RecipeProvider _recipeProvider;
  late KategorijaProvider _kategorijaProvider;
  late VrstaJelaProvider _vrstaJelaProvider;
  SearchResult<Kategorija>? kategorijaResult;
  SearchResult<VrstaJela>? vrstaJelaResult;
  bool isLoading = true;
  String? _selectedKategorijaId;
  String? _selectedVrstaJelaId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _recipeProvider = context.read<RecipeProvider>();
    _kategorijaProvider = context.read<KategorijaProvider>();
    _vrstaJelaProvider = context.read<VrstaJelaProvider>();
    // TODO: implement initState
    super.initState();

    initForm();
  }

  Future initForm() async {
    kategorijaResult = await _kategorijaProvider.get();
    vrstaJelaResult = await _vrstaJelaProvider.get();
    if (kategorijaResult != null && kategorijaResult!.result.isNotEmpty) {
      _selectedKategorijaId = kategorijaResult!.result.first.kategorijaId
          .toString(); // Prva kategorija kao podrazumevana
    }
    if (vrstaJelaResult != null && vrstaJelaResult!.result.isNotEmpty) {
      _selectedVrstaJelaId = vrstaJelaResult!.result.first.vrstaJelaId
          .toString(); // Prva kategorija kao podrazumevana
    }
    setState(() {
      isLoading = false;
    });
  }

  void handleSignup(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        final receptRequest = {
          'naziv': _recipeNameController.text,
          'opisRecepta': _recipeDescriptionController.text,
          'opisPripreme': _preparationDescriptionController.text,
          'vrijemePripreme': _preparationTimeController,
          'slika': _base64Image,
          'kategorijaId':_selectedKategorijaId,
          '_vrstaJelaId':_selectedVrstaJelaId,
        };

         await _recipeProvider.insert(receptRequest);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful!'),
            duration: Duration(seconds: 3),
          ),
        );
        //Navigator.pushNamed(context, LoginScreen.routeName);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed. Error: $e'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('eRecipes',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            )),
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
                    Text(
                      'Dobro došli!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 24,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Dodajte novi recept',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xCC0D3E09),
              ),
            ),
            _buildFormForRecipe()
          ],
        ),
      ),
    );
  }

  Widget _buildFormForRecipe() {
    return 
       FormBuilder(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Naziv recepta
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Naslov recepta',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
              TextFormField(
                controller: _recipeNameController,
                decoration: const InputDecoration(
                  //labelText: 'Naziv recepta',  // Naziv recepta iznad inputa
                  hintText: 'Unesite naziv recepta', // Hint tekst unutar inputa
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Unesite naziv recepta';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Opis recepta
              TextFormField(
                controller: _recipeDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Opis recepta',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Unesite opis recepta';
                  }
                  return null;
                },
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              // Opis pripreme
              TextFormField(
                controller: _preparationDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Opis pripreme',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Unesite opis pripreme';
                  }
                  return null;
                },
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              // Vrijeme pripreme
              TextFormField(
                controller: _preparationTimeController,
                decoration: const InputDecoration(
                  labelText: 'Vrijeme pripreme (u minutama)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Unesite vrijeme pripreme';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: FormBuilderField(
                      name: "imageId",
                      builder: (field) {
                        return ListTile(
                          leading: const Icon(Icons.image, color: Colors.green),
                          title: Text(
                            _image == null ? "Odaberite sliku" : "Slika odabrana",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          trailing:
                              const Icon(Icons.file_upload, color: Colors.green),
                          onTap: getImage,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Kategorija jela',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        FormBuilderDropdown(
                          name: "kategorijaId",
                          initialValue: _selectedKategorijaId,
                          decoration: const InputDecoration(),
                          items: kategorijaResult?.result.map((e) {
                                return DropdownMenuItem(
                                  value: e.kategorijaId.toString(),
                                  child: Text(e.naziv ?? "Nepoznata kategorija"),
                                );
                              }).toList() ??
                              [],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Vrsta jela',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        FormBuilderDropdown(
                          name: "vrstaJelaId",
                          initialValue: _selectedVrstaJelaId,
                          decoration: const InputDecoration(),
                          items: vrstaJelaResult?.result.map((e) {
                                return DropdownMenuItem(
                                  value: e.vrstaJelaId.toString(),
                                  child: Text(e.naziv ?? "Nepoznata vrsta jela"),
                                );
                              }).toList() ??
                              [],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Dugme za dodavanje recepta
             ElevatedButton(
            onPressed: () {
              if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                _formKey.currentState!.save();  // Save the form data
                //var formData = _formKey.currentState!.value; // Access form data
              //var request = Map.from(formData);  // Create a copy of form data
               // ['slika'] = _base64Image;   // Add the image data
          
                //_recipeProvider.insert(request);  // Insert data using your provider
          
                ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recept je dodan!')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text('Dodaj recept'),
          ),
          
            ],
          ),
        ),
      );
    
  }

  File? _image;
  String? _base64Image;

  void getImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      _base64Image = base64Encode(_image!.readAsBytesSync());
    }
  }
}
