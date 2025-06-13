import 'package:erecipes_mobile/models/korisnik.dart';
import 'package:erecipes_mobile/models/to_do4924.dart';
import 'package:erecipes_mobile/providers/korisnik_provider.dart';
import 'package:erecipes_mobile/providers/to_do4924_provider.dart';
import 'package:erecipes_mobile/providers/utils.dart';
import 'package:erecipes_mobile/screens/to_do4924_novi_screen.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class ToDo4924Screen extends StatefulWidget {

  const ToDo4924Screen({super.key});

  @override
  State<ToDo4924Screen> createState() => ToDo4924ScreenState();
}

class ToDo4924ScreenState extends State<ToDo4924Screen> {
  final ToDo4924Provider _do4924provider=ToDo4924Provider();
  List<ToDo4924> _listaToDo=[];
  final KorisnikProvider _korisnikProvider=KorisnikProvider();
  List<Korisnik> _listaKorisnika=[];
  Korisnik? _selectedKorisnik;
  int? _slectedStatus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  void _fetchData() async{
    final response= await _do4924provider.get();
    final reposneUser= await _korisnikProvider.get();
    setState(() {
      _listaToDo=response.result;
      _listaKorisnika=reposneUser.result;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(naslov: 'eRecipes'),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const ToDo4924NoviScreen()));
              }, child: const Text("Dodaj"))
            ],
          ),
          DropdownButtonFormField(
            value: _listaKorisnika.contains(_selectedKorisnik)? _selectedKorisnik:null,
            onChanged: (Korisnik? kor){
              setState(() {
                _selectedKorisnik=kor;
              });
            },
            items: _listaKorisnika.map((Korisnik e){
              return DropdownMenuItem(
                value: e,
                child: Text("${e.ime} ${e.prezime}"),
              );
            }).toList(),
            decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Odaberite kroisnika"),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns:const [
                DataColumn(label: Text("Ime")),
                DataColumn(label: Text("prezime")),
                DataColumn(label: Text("Naziv")),
                DataColumn(label: Text("Opis")),
                DataColumn(label: Text("Rok za realizaciju")),
                DataColumn(label: Text("Status")),
              ],
              rows: _listaToDo.map((e) {
                return DataRow(
                  cells: [
                    DataCell(Text(e.korisnik?.ime ?? "")),
                    DataCell(Text(e.korisnik?.prezime ?? "")),
                    DataCell(Text(e.naziv?? "")),
                    DataCell(Text(e.opis?? "")),
                    DataCell(Text(formatDate(e.datumIzvrsenja!))),
                    DataCell(Text(e.status?? "")),
                  ]
                );
              }).toList(),
            ),
          ),
        ],
      )
    );
  }
}
