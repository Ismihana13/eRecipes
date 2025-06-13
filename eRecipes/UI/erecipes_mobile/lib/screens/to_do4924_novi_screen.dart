import 'package:erecipes_mobile/models/korisnik.dart';
import 'package:erecipes_mobile/models/to_do4924.dart';
import 'package:erecipes_mobile/providers/korisnik_provider.dart';
import 'package:erecipes_mobile/providers/to_do4924_provider.dart';
import 'package:erecipes_mobile/providers/utils.dart';
import 'package:erecipes_mobile/screens/to_do4924_screen.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class ToDo4924NoviScreen extends StatefulWidget {
  const ToDo4924NoviScreen({super.key});

  @override
  State<ToDo4924NoviScreen> createState() => ToDo4924NoviScreenState();
}

class ToDo4924NoviScreenState extends State<ToDo4924NoviScreen> {
  final ToDo4924Provider _do4924provider = ToDo4924Provider();
  final KorisnikProvider _korisnikProvider = KorisnikProvider();
  List<Korisnik> _listaKorisniak = [];
  Korisnik? _selectedKorisnik;
  String? _selectedStatus = "U_toku";
  String? _naziv;
  String? _opis;
  DateTime? _selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    final responseUser = await _korisnikProvider.get();
    setState(() {
      _listaKorisniak = responseUser.result;
    });
  }

  void _addToDo() async {
    if (_selectedKorisnik == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Greška"),
              content: const Text("Niste odabrali korinsika"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text("Ok"))
              ],
            );
          });
      return;
    }
    if (_naziv == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Greška"),
              content: const Text("Niste unijeli naziv. "),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text("Ok"))
              ],
            );
          });
      return;
    }
    if (_opis == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Greška"),
              content: const Text("Niste unijeli opis"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text("Ok"))
              ],
            );
          });
      return;
    }
    if (_selectedDate == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Greška"),
              content: const Text("Niste odabrali datum"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text("Ok"))
              ],
            );
          });
      return;
    }
    try {
      await _do4924provider.insert(ToDo4924(
        _selectedKorisnik?.korisnikId,
        _naziv,
        _opis,
        _selectedDate,
        _selectedStatus
      ));
       showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Upsjeno ste dodali "),
            
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ToDo4924Screen()));
                    },
                    child: const Text("Ok"))
              ],
            );
          });
      
    } catch (e) {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(naslov: 'eRecipes'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            DropdownButtonFormField<Korisnik>(
              value: _listaKorisniak.contains(_selectedKorisnik)
                  ? _selectedKorisnik
                  : null,
              onChanged: (Korisnik? korisnik) {
                setState(() {
                  _selectedKorisnik = korisnik;
                });
              },
              items: _listaKorisniak.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text("${e.ime} ${e.prezime}"),
                );
              }).toList(),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Odaberite korisnika"),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
              value: _selectedStatus,
              onChanged: (String? status) {
                setState(() {
                  _selectedStatus = status;
                });
              },
              items: const [
                DropdownMenuItem(
                  value: "U_toku",
                  child: Text("U toku"),
                ),
                DropdownMenuItem(
                  value: "Realizovana",
                  child: Text("Realizovana"),
                ),
                DropdownMenuItem(
                  value: "Istekla",
                  child: Text("Istekla"),
                ),
              ],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Odaberite status"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Unsite naziv"),
              onChanged: (String? val) {
                _naziv = val;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Unsite opis"),
              onChanged: (String? val) {
                _opis = val;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2200));
                if (selectedDate != null) {
                  setState(() {
                    _selectedDate = selectedDate;
                  });
                }
              },
              child: Text(_selectedDate == null
                  ? "Odaberite datum"
                  : "Odabrani datum ${formatDate(_selectedDate!)}"),
            ),
            ElevatedButton(
                onPressed: () {
                  _addToDo();
                },
                child: const Text("Dodaj"))
          ],
        ),
      ),
    );
  }
}
