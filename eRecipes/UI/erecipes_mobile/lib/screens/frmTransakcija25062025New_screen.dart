import 'package:erecipes_mobile/models/kategorija_transakcije25062025.dart';
import 'package:erecipes_mobile/models/korisnik.dart';
import 'package:erecipes_mobile/models/transakcija25062025.dart';
import 'package:erecipes_mobile/providers/auth_provider.dart';
import 'package:erecipes_mobile/providers/kategorija_transakcije25062025_provider.dart';
import 'package:erecipes_mobile/providers/transakcija25062025_provider.dart';
import 'package:erecipes_mobile/providers/utils.dart';
import 'package:erecipes_mobile/screens/frmTransakcija25062025_screen.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FrmTransakcija25062025NewScreen extends StatefulWidget {
  const FrmTransakcija25062025NewScreen({super.key});

  @override
  State<FrmTransakcija25062025NewScreen> createState() =>
      FrmTransakcija25062025NewScreenState();
}

class FrmTransakcija25062025NewScreenState
    extends State<FrmTransakcija25062025NewScreen> {
  final Transakcija25062025Provider _transakcija25062025provider =
      Transakcija25062025Provider();
  List<Transakcija25062025> _listaTransakcija = [];
  final KategorijaTransakcije25062025Provider
      _kategorijaTransakcije25062025Provider =
      KategorijaTransakcije25062025Provider();
  List<KategorijaTransakcije25062025> _listaKat = [];
  KategorijaTransakcije25062025? _selectedKategorija;
  DateTime? _selectedDate;
  DateTime? _selectedDateDo;
  Korisnik? _korisnik;
  double? _iznos;
  String? _opis;
  String? _status = 'Planirano';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    final response = await _transakcija25062025provider.get();
    final rresultKategorija =
        await _kategorijaTransakcije25062025Provider.get();
    var user = AuthProvider.korisnik;
    setState(() {
      _listaTransakcija = response.result;
      _listaKat = rresultKategorija.result;
      _korisnik = user;
    });
  }

  void addTransakcija() async {
    if (_iznos == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Greška"),
              content: const Text("Niste dodali iznos/ ili iznos nije broj"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"))
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
              content: const Text("Niste odabrali datum "),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"))
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
              content: const Text("Niste unijeli opis "),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"))
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
              title: const Text("Greška"),
              content: const Text("Niste odabrali kategoriju "),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"))
              ],
            );
          });
      return;
    }
    try {
      await _transakcija25062025provider.insert(Transakcija25062025(
        _korisnik!.korisnikId, _iznos, _selectedDate, _opis, _selectedKategorija!.kategorijaTransakcije25062025Id, _status
      ));
         showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Upsjesno dodano"),
              
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> FrmTransakcija25062025Screen()));
                    },
                    child: const Text("OK"))
              ],
            );
          });
   } catch (e) {
  String errorMessage = e.toString();

  String poruka = "Došlo je do greške.";
  if (errorMessage.contains("premašio finansijski limit")) {
    poruka = "Greška: Unosom bi se premašio finansijski limit!";
  } else if (errorMessage.contains("Približavate se definisanom limitu")) {
    poruka = "Upozorenje: Približavate se definisanom mjesečnom limitu!";
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Obavještenje"),
        content: Text(poruka),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"))
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
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Unesite iznos"),
                onChanged: (String? e) {
                  setState(() {
                    _iznos = double.tryParse(e ?? "");
                  });
                },
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
                      ? "Odaberite datum od:"
                      : "Odabrani datum OD: ${formatDate(_selectedDate!)}")),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Unesite opis"),
                onChanged: (String? e) {
                  setState(() {
                    _opis = e ?? _opis;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                value: _listaKat.contains(_selectedKategorija)
                    ? _selectedKategorija
                    : null,
                onChanged: (KategorijaTransakcije25062025? e) {
                  setState(() {
                    _selectedKategorija = e;
                  });
                },
                items: _listaKat.map((KategorijaTransakcije25062025 e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text("${e.naziv}"),
                  );
                }).toList(),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Odaberite kategoriju"),
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                value: _status,
                onChanged: (String? e) {
                  setState(() {
                    _status = e;
                  });
                },
                items: const [
                  DropdownMenuItem(
                    value: 'Planirano',
                    child: Text("Planirano"),
                  ),
                  DropdownMenuItem(
                    value: 'Realizovano',
                    child: Text("Realizovano"),
                  ),
                  DropdownMenuItem(
                    value: 'Otkazano',
                    child: Text("Otkazano"),
                  ),
                ],
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Odaberite status transakcije"),
              ),
              ElevatedButton(
                  onPressed: () {
                    addTransakcija();
                  },
                  child: const Text("Dodaj"))
            ],
          ),
        ),
      ),
    );
  }
}
