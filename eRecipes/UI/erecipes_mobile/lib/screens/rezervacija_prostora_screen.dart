import 'package:erecipes_mobile/models/korisnik.dart';
import 'package:erecipes_mobile/models/radni_prostor.dart';
import 'package:erecipes_mobile/models/rezervacija_prostora.dart';
import 'package:erecipes_mobile/models/rezervacija_prostora_statistika.dart';
import 'package:erecipes_mobile/providers/korisnik_provider.dart';
import 'package:erecipes_mobile/providers/radni_prostor_provider.dart';
import 'package:erecipes_mobile/providers/rezervacija_prostora_provider.dart';
import 'package:erecipes_mobile/providers/utils.dart';
import 'package:erecipes_mobile/screens/rezervacija_prostora_new_screen.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

class RezervacijaProstoraScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RezervacijaProstoraState();
}

class _RezervacijaProstoraState extends State<RezervacijaProstoraScreen> {
  final RezervacijaProstoraProvider _rezervacijaProstoraProvider =
      RezervacijaProstoraProvider();
  List<RezervacijaProstora> _rezervacijaProstora = [];
  final KorisnikProvider _korisnikProvider = KorisnikProvider();
  final RadniProstorProvider _radniProstorProvider = RadniProstorProvider();
  List<Korisnik> _korisnik = [];
  List<RadniProstor> _radniProstor = [];
  Korisnik? _selectedKorisik;
  RadniProstor? _selectedradniProstor;
   int? _status;
   List<RezervacijaProstoraStatistika> rezervacijaStatistika=[];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await _rezervacijaProstoraProvider.get();
      final resposneUser = await _korisnikProvider.get();
      final responseRadniProstor = await _radniProstorProvider.get();
      final responsestatstika= await _rezervacijaProstoraProvider.getRezervacija();
      setState(() {
        _rezervacijaProstora = response.result;
        _korisnik = resposneUser.result;
        _radniProstor = responseRadniProstor.result;
        rezervacijaStatistika=responsestatstika;
      });
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Failed to load data');
    }
  }
Future<void> filteredData() async {
  try {
    final response= await _rezervacijaProstoraProvider.get(filter: {
      'KorisnikId':_selectedKorisik?.korisnikId,
      'RadniProstorId':_selectedradniProstor?.radniProstorId,
      'PretragaStatusRezervacije':_status,
    });
    setState(() {
      _rezervacijaProstora=response.result;
    });
  } catch (e) {
     throw Exception('Failed to load data');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(naslov: 'eRecipes'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RezervacijaProstoraNewScreen(),
                      ),
                    ).then((value) => fetchData());
                  },
                  child: const Text("Rezervisi")),
            ]),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<Korisnik>(
              value:
                  _korisnik.contains(_selectedKorisik) ? _selectedKorisik : null,
              onChanged: (Korisnik? user) {
                setState(() {
                  _selectedKorisik = user;
                });
              },
              items: _korisnik.map((Korisnik user) {
                return DropdownMenuItem(
                  value: user,
                  child: Text("${user.ime} ${user.prezime}"),
                );
              }).toList(),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Odaberi korisnika"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<RadniProstor>(
              value: _radniProstor.contains(_selectedradniProstor)
                  ? _selectedradniProstor
                  : null,
              onChanged: (RadniProstor? user) {
                setState(() {
                  _selectedradniProstor = user;
                });
              },
              items: _radniProstor.map((RadniProstor user) {
                return DropdownMenuItem(
                  value: user,
                  child: Text("${user.oznaka}"),
                );
              }).toList(),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Odaberi radni prostor"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<int>(
              value: _status,
              onChanged: (int? value){
                setState(() {
                  _status=value?? _status;
                });
              },
              items: const [
                DropdownMenuItem<int>(
                          value: 0,
                          child: Text('Potvrdjena'),
                        ),
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text('Na cekanju'),
                        ),
                        DropdownMenuItem<int>(
                          value: 2,
                          child: Text('Otkazana'),
                        ),
              ],
              decoration: const InputDecoration(
                        labelText: 'Status rezervacije',
                        border: OutlineInputBorder(),
                      ),
            ),
          ),
          ElevatedButton(onPressed: (){
            filteredData();
          }, child: const Text("Pretraži")),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Ime')),
                DataColumn(label: Text('Prezime')),
                DataColumn(label: Text('Naziv prostora')),
                DataColumn(label: Text('Kapacitet')),
                DataColumn(label: Text('Datum i vrijeme')),
                DataColumn(label: Text('Trajanje')),
                DataColumn(label: Text('Status')),
              ],
              rows: _rezervacijaProstora.map((e) {
  
                return DataRow(
                  cells: [
                    DataCell(Text(e.korisnik?.ime ?? "-")),
                    DataCell(Text(e.korisnik?.prezime ?? "-")),
                    DataCell(Text(e.radniProstor?.oznaka ?? "-")),
                    DataCell(
                        Text(e.radniProstor?.kapacitet?.toString() ?? "-")),
                    DataCell(Text(formatDateWithTime(
                        e.datumIVrijemePocetkaRezervacije!))),
                    DataCell(Text(e.trajanje?.toString() ?? "-")),
                    DataCell(Text(e.statusRezervacije ?? "-")),
                  ],
                );
              }).toList(),
            ),
          
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text("Statistika rezervacije"),
                const SizedBox(height: 10),
                ...rezervacijaStatistika.map((e){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        e.statusRezervacije!.replaceAll("_", " "),
                      ),
                      Text(
                        e.brojPojavljivanja.toString()
                      )
                    ],
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
