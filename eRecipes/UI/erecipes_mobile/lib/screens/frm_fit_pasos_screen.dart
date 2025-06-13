import 'package:erecipes_mobile/models/fit_pasos.dart';
import 'package:erecipes_mobile/models/korisnik.dart';
import 'package:erecipes_mobile/providers/fit_pasos_provider.dart';
import 'package:erecipes_mobile/providers/korisnik_provider.dart';
import 'package:erecipes_mobile/providers/utils.dart';
import 'package:erecipes_mobile/screens/frm_fit_pasos_screen_new.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class FrmFitPasosScreen extends StatefulWidget {
  const FrmFitPasosScreen({super.key});

  @override
  State<FrmFitPasosScreen> createState() => _FrmFitPasosScreenState();
}

class _FrmFitPasosScreenState extends State<FrmFitPasosScreen> {
  final FitPasosProvider _fitPasosProvider = FitPasosProvider();
  final KorisnikProvider _korisnikProvider = KorisnikProvider();
  List<Korisnik> _listaKorisnika = [];
  Korisnik? _selectedKorisnik;
  List<FitPasos> _listaFitPasos = [];
  DateTime? _selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    final response = await _fitPasosProvider.get();
    final responseUser = await _korisnikProvider.get();
    setState(() {
      _listaFitPasos = response.result;
      _listaKorisnika = responseUser.result;
    });
  }
  void _filteredData() async{
    final response= await _fitPasosProvider.get(filter: {
      'KorisnikId':_selectedKorisnik?.korisnikId,
      'DatumVazenja':_selectedDate
    });
    setState(() {
      _listaFitPasos=response.result;
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
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FrmFitPasosNewScreen()));
                    },
                    child: const Text("Dodaj"))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
              value: _listaKorisnika.contains(_selectedKorisnik)
                  ? _selectedKorisnik
                  : null,
              onChanged: (Korisnik? e) {
                setState(() {
                  _selectedKorisnik = e;
                });
              },
              items: _listaKorisnika.map((Korisnik e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text("${e.ime} ${e.prezime}"),
                );
              }).toList(),
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Odaberite korisnika"),
            ),  const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () async{
              final selected= await showDatePicker(context: context,
              initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2200));
              if(selected!=null){
                setState(() {
                  _selectedDate=selected;
                });
              }
            }, child: Text(_selectedDate==null? "Odaberite datum" : "Odabrani datum ${formatDate(_selectedDate!)}")),
              const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () async{
              _filteredData();
            }, child: const Text("Pretrazi")),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text("Ime")),
                  DataColumn(label: Text("Prezime")),
                  DataColumn(label: Text("datumVazenja")),
                  DataColumn(label: Text("Validnost")),
                ],
                rows: _listaFitPasos.map((e) {
                  return DataRow(cells: [
                    DataCell(Text(e.korisnik?.ime ?? "")),
                    DataCell(Text(e.korisnik?.prezime ?? "")),
                    DataCell(Text(formatDate(e.datumIzdavanja!))),
                    DataCell(Text(e.validan == true ? "Validan" : "Nevalidan")),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ));
  }
}
