import 'package:erecipes_mobile/models/kategorija_transakcije14072025.dart';
import 'package:erecipes_mobile/models/transakcija14072025.dart';
import 'package:erecipes_mobile/providers/auth_provider.dart';
import 'package:erecipes_mobile/providers/kategorija_transakcije14072025_provider.dart';
import 'package:erecipes_mobile/providers/transakcija14072025_provider.dart';
import 'package:erecipes_mobile/providers/utils.dart';
import 'package:erecipes_mobile/screens/frmTransakcije14072025.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FrmTransakcije14072025New extends StatefulWidget {
  const FrmTransakcije14072025New({super.key});

  @override
  State<FrmTransakcije14072025New> createState() =>
      FrmTransakcije14072025NewState();
}

class FrmTransakcije14072025NewState extends State<FrmTransakcije14072025New> {
  final Transakcija14072025Porvider _transakcija14072025porvider =
      Transakcija14072025Porvider();
  final KategorijaTransakcije14072025Provider
      _kategorijaTransakcije14072025Provider =
      KategorijaTransakcije14072025Provider();
  List<KategorijaTransakcije14072025> _listaKategorija = [];
  KategorijaTransakcije14072025? _selectedKategorija;
  var korisnik;
  double? _iznos;
  DateTime? _selectedDate;
  String? _opis;
  String? _status = "Planirano";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    final reponseKategorija =
        await _kategorijaTransakcije14072025Provider.get();
    korisnik = AuthProvider.korisnik;
    setState(() {
      _listaKategorija = reponseKategorija.result;
    });
  }

  void _addTransakcija() async {
    if (_iznos == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Greška niste unijeli iznos pravilno"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok"))
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
              title: Text("Greška odabrali datum!"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok"))
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
              title: Text("Greška unijeli opis"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok"))
              ],
            );
          });
      return;
    }
    if (_selectedKategorija == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Greška niste odabrali kategoriju"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok"))
              ],
            );
          });
      return;
    }
    if (_status == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Greška odabrali status"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok"))
              ],
            );
          });
      return;
    }
    try {
      await _transakcija14072025porvider.insert(Transakcija14072025(
          korisnik.korisnikId,
          _iznos,
          _selectedDate,
          _opis,
          _selectedKategorija!.kategorijaTransakcije14072025Id,
          _status));
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Uspješno dodano"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FrmTransakcije14072025()));
                    },
                    child: Text("Ok"))
              ],
            );
          });
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Premašili ste limit ${e.toString()}"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok"))
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(naslov: 'eRecipes'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Unesite iznos"),
              onChanged: (value) {
                setState(() {
                  _iznos = double.tryParse(value);
                });
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
                    : "Odabrani datum ${formatDate(_selectedDate!)}")),
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Unesite Opis"),
              onChanged: (value) {
                setState(() {
                  _opis = value;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField<KategorijaTransakcije14072025>(
              value: _listaKategorija.contains(_selectedKategorija)
                  ? _selectedKategorija
                  : null,
              onChanged: (KategorijaTransakcije14072025? e) {
                setState(() {
                  _selectedKategorija = e;
                });
              },
              items: _listaKategorija.map((KategorijaTransakcije14072025 e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text("${e.naziv}"),
                );
              }).toList(),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Odaberite kategoriju"),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField<String>(
              value: _status,
              onChanged: (String? e) {
                setState(() {
                  _status = e;
                });
              },
              items: const [
                DropdownMenuItem(
                  value: "Planirano",
                  child: Text("Planirano"),
                ),
                DropdownMenuItem(
                  value: "Realizovano",
                  child: Text("Realizovano"),
                ),
                DropdownMenuItem(
                  value: "Otkazano",
                  child: Text("Otkazano"),
                ),
              ],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Odaberite status"),
            ),
            ElevatedButton(
                onPressed: () {
                  _addTransakcija();
                },
                child: Text("Dodaj"))
          ]),
        ),
      ),
    );
  }
}
