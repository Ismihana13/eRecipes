import 'package:erecipes_mobile/models/korisnik.dart';
import 'package:erecipes_mobile/models/mood_tracker.dart';
import 'package:erecipes_mobile/providers/korisnik_provider.dart';
import 'package:erecipes_mobile/providers/mood_tracker_provider.dart';
import 'package:erecipes_mobile/providers/utils.dart';
import 'package:erecipes_mobile/screens/mood_tracker_screen.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MoodTrackerNewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MoodTrackerNewScreenState();
}

class _MoodTrackerNewScreenState extends State<MoodTrackerNewScreen> {
  final KorisnikProvider _korisnikProvider = KorisnikProvider();
  final MoodTrackerProvider _moodTrackerProvider = MoodTrackerProvider();
  List<Korisnik> _listaKorisnika = [];
  Korisnik? _selectedKorisnik;
  String? _vrijednostRaspolozenja = "Sretan";
  DateTime _selectedDate = DateTime.now();
  String _napomena = "";

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    final responseUser = await _korisnikProvider.get();

    setState(() {
      _listaKorisnika = responseUser.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(naslov: "eRecipes"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
              value: _selectedKorisnik,
              onChanged: (Korisnik? user) {
                setState(() {
                  _selectedKorisnik = user;
                });
              },
              items: _listaKorisnika.map((Korisnik e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text("${e.ime}"),
                );
              }).toList(),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Odabrite korisnika"),
            ),
          ),
          DropdownButtonFormField<String>(
            value: _vrijednostRaspolozenja,
            onChanged: (String? value) {
              setState(() {
                _vrijednostRaspolozenja = value ?? _vrijednostRaspolozenja;
              });
            },
            items: const [
              DropdownMenuItem(value: "Sretan", child: Text("Sretan/a")),
              DropdownMenuItem(value: "Tuzan", child: Text("Tuzan/a")),
              DropdownMenuItem(
                  value: "Pod_stresom", child: Text("Pod stresom/a")),
              DropdownMenuItem(value: "Uzbuđen", child: Text("Uzbuđen/a")),
              DropdownMenuItem(value: "Umoran", child: Text("Umoran/a")),
            ],
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Odaberite  raspolozenja"),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2200),
                    initialDate: DateTime.now());
                if (selectedDate != null) {
                  setState(() {
                    _selectedDate = selectedDate;
                  });
                }
              },
              child: Text("Odabrani datum: ${formatDate(_selectedDate)}")),
          TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: "Unesite napomenu "),
            onChanged: (napomena) {
              setState(() {
                _napomena = napomena;
              });
            },
          ),
          ElevatedButton(
              onPressed: () {
                _addModdTracker();
              },
              child: const Text("Sačuvaj"))
        ]),
      ),
    );
  }

  void _addModdTracker() async {
    if (_napomena == " ") {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Greška"),
                content: Text("Morate unijeti napomenu"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Ok"))
                ],
              ));
    }
    try {
      var request = MoodTracker(
        _selectedKorisnik!.korisnikId,
        _vrijednostRaspolozenja,
        _napomena,
        _selectedDate,
      );
      await _moodTrackerProvider.insert(request);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Uspješno ste dodali mood tracker"),
                actions: [
                  TextButton(
                      onPressed: () {
                       Navigator.of(context).pop();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MoodTrackerScreen()),
                          );
                      },
                      child: Text("Ok"))
                ],
              ));
    } catch (e) {
      print("${e}");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Greška'),
          content: const Text(
              'Ne možete za isti datum i istu osobu dodati vise od dva raspolozenja'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
