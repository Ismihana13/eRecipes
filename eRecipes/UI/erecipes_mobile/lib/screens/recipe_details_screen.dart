import 'dart:convert';
import 'dart:io';

import 'package:erecipes_mobile/layouts/master_screen.dart';
import 'package:erecipes_mobile/models/kategorija.dart';
import 'package:erecipes_mobile/models/recept.dart';
import 'package:erecipes_mobile/models/search_result.dart';
import 'package:erecipes_mobile/models/vrsta_jela.dart';
import 'package:erecipes_mobile/providers/kategorija_provider.dart';
import 'package:erecipes_mobile/providers/recipe_provider.dart';
import 'package:erecipes_mobile/providers/vrsta_jela_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class RecipeDetailsScreen extends StatefulWidget {
   
  Recept? recept;
  RecipeDetailsScreen({super.key, this.recept});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  final _formKey= GlobalKey<FormBuilderState>();
  Map<String,dynamic> _initialValue={};
  late RecipeProvider recipeProvider;
   late KategorijaProvider kategorijaProvider;
   late VrstaJelaProvider vrstaJelaProvider;
   SearchResult<VrstaJela>? vrstaJelaResult=null;
   SearchResult<Kategorija>? kategorijaResult=null;
   bool isLoading=true;

   @override
   void didChangeDependencies(){
    super.didChangeDependencies();
   
   }
  @override
  void initState(){
    recipeProvider=context.read<RecipeProvider>();
    kategorijaProvider=context.read<KategorijaProvider>();
    vrstaJelaProvider=context.read<VrstaJelaProvider>();
    super.initState();
    _initialValue={
      'naziv':widget.recept?.naziv,
      'opisRecepta':widget.recept?.opisRecepta,
      'vrstaJelaId':widget.recept?.vrstaJelaId.toString(),
      'kategorijaId':widget.recept?.kategorijaId.toString(),
      
    };
    print("Vrsta jela ID: ${widget.recept?.vrstaJelaId}");
      print("Kategorija ID: ${widget.recept?.kategorijaId}");
    initForm();
  }
  Future initForm() async{
    vrstaJelaResult= await vrstaJelaProvider.get();
    kategorijaResult= await kategorijaProvider.get();
    print("vrtsa:${kategorijaResult?.result.length}");
    setState(() {
      isLoading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen("Detalji", 
    Column(children: [
       isLoading? Container(): _buildForm(),
       _saveRow()

    ],)
    );
  }

  Widget _buildForm() {
    return FormBuilder(key: _formKey, initialValue: _initialValue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
              Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      decoration: InputDecoration(labelText: "Naziv"),
                      name: "naziv",
                    )),
                    SizedBox(width: 10,),
                     Expanded(
                    child: FormBuilderTextField(
                      decoration: InputDecoration(labelText: "Opis recepta"),
                      name: "opisRecepta",
                    )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: FormBuilderDropdown(name:"vrstaJelaId",
                    decoration: InputDecoration(labelText: "Vrsta jela"),
                    items: vrstaJelaResult?.result.map((item) => DropdownMenuItem(value: item.vrstaJelaId.toString(), child: Text(item.naziv?? ""))).toList()??[],
                    )
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                    child: FormBuilderDropdown(name:"kategorijaId",
                    decoration: InputDecoration(labelText: "Kategorija"),
                    items: kategorijaResult?.result.map((item) => DropdownMenuItem(value: item.kategorijaId.toString(), child: Text(item.naziv?? ""))).toList()??[],
                    )
                    ),
                    SizedBox(width: 10,),
                    
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: FormBuilderField(
                      name: "ImageId",
                      builder: (field)  {
                            return InputDecorator(
                              decoration: InputDecoration(labelText: "Odaberite sliku"),
                              child: ListTile(
                                leading: Icon(Icons.image),
                                title: Text("Select image"),
                                trailing: Icon(Icons.file_upload),
                                onTap: getImage,
                              ),
                            );
                      },
                    )
                  )
                ],
              )
          ],),
      ));
}

 Widget _saveRow() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(onPressed: (){
            _formKey.currentState?.saveAndValidate();
            debugPrint(_formKey.currentState?.value.toString());
            var request=  Map.from(_formKey.currentState!.value);

            request['slika']= _base64Image;


            if(widget.recept==null)
            {
              recipeProvider.insert(request);
            } else {
              recipeProvider.update(widget.recept!.receptId!,request );
            }
           // recipeProvider.insert(_formKey.currentState?.value!);
        }, child: Text("Sačuvaj"))
      ],
    ),
  );
 }
 File? _image;
 String? _base64Image;

 void getImage() async {
    var result= await FilePicker.platform.pickFiles(type: FileType.image);

    if(result!=null && result.files.single.path!=null)
    {
      _image=File(result.files.single.path!);
      _base64Image=base64Encode(_image!.readAsBytesSync());
    }
 }
}

