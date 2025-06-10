import 'dart:async';

import 'package:erecipes_mobile/models/korisnik.dart';
import 'package:erecipes_mobile/models/mood_tracker.dart';
import 'package:erecipes_mobile/providers/korisnik_provider.dart';
import 'package:erecipes_mobile/providers/mood_tracker_provider.dart';
import 'package:erecipes_mobile/providers/utils.dart';
import 'package:erecipes_mobile/screens/mood_tracker_new_screen.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  State<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  final MoodTrackerProvider _moodTrackerProvider = MoodTrackerProvider();
  List<MoodTracker> _moodTrackerresult = [];
  final KorisnikProvider _korisnikProvider = KorisnikProvider();
  List<Korisnik> _listaKorisnika = [];
  Korisnik? _selectedKorisnik;
  int? _status;
  DateTime? _selectedDate;
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final response = await _moodTrackerProvider.get();
    final responseUser = await _korisnikProvider.get();
    setState(() {
      _moodTrackerresult = response.result;
      _listaKorisnika = responseUser.result;
    });
  }

  Future<void> filteredData() async {
    final response = await _moodTrackerProvider.get(
      filter: {
        'KorisnikId': _selectedKorisnik!.korisnikId,
        "VrijednostRaspolozenja": _status,
        'DatumEvidencije': _selectedDate,
      },
    );
    setState(() {
      _moodTrackerresult = response.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(naslov: "eRecipes"),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _fetchData();
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MoodTrackerNewScreen()))
                          .then((value) => _fetchData());
                    },
                    child: const Text("add Mood tracker"))
              ],
            ),
            DropdownButtonFormField<Korisnik>(
              value: _listaKorisnika.contains(_selectedKorisnik)
                  ? _selectedKorisnik
                  : null,
              onChanged: (Korisnik? user) {
                setState(() {
                  _selectedKorisnik = user;
                });
              },
              items: _listaKorisnika.map((Korisnik e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text("${e.ime} ${e.prezime}"),
                );
              }).toList(),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Odabreite korisnika"),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField<int>(
              value: _status,
              onChanged: (int? status) {
                setState(() {
                  _status = status ?? _status;
                });
              },
              items: const [
                DropdownMenuItem<int>(
                  value: 0,
                  child: Text("Sretan"),
                ),
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text("Tuzan"),
                ),
                DropdownMenuItem<int>(
                  value: 2,
                  child: Text("pod stresom"),
                ),
                DropdownMenuItem<int>(
                  value: 3,
                  child: Text("Uzbudjen"),
                ),
                DropdownMenuItem<int>(
                  value: 4,
                  child: Text("Umoran"),
                ),
              ],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Odaberite rapsolozenje"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  final selecteddate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2200));
                  setState(() {
                    _selectedDate = selecteddate;
                  });
                },
                child:  Text(_selectedDate == null 
    ? "Odaberite datum" 
    : "Odabrali ste ${formatDate(_selectedDate!)}"),),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  filteredData();
                },
                child: Text("Pretrazi")),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text("Ime")),
                      DataColumn(label: Text("Prezime")),
                      DataColumn(label: Text("Raspolozenje")),
                      DataColumn(label: Text("Datum")),
                      DataColumn(label: Text("Opis")),
                    ],
                    rows: _moodTrackerresult.map((e) {
                      return DataRow(
                        cells: [
                          DataCell(Text(e.korisnik?.ime ?? "")),
                          DataCell(Text(e.korisnik?.prezime ?? "")),
                          DataCell(Text(e.vrijednostRaspolozenja ?? "")),
                          DataCell(Text(formatDate(e.datumEvidencije!))),
                          DataCell(Text(e.opis ?? "")),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
