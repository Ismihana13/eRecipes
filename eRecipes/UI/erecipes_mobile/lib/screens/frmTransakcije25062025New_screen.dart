import 'package:erecipes_mobile/models/kategorija_transakcije25062025.dart';
import 'package:erecipes_mobile/models/transakcija25062025.dart';
import 'package:erecipes_mobile/providers/auth_provider.dart';
import 'package:erecipes_mobile/providers/kategorija_transakcije25062025_provider.dart';
import 'package:erecipes_mobile/providers/transakcija25062025_provider.dart';
import 'package:erecipes_mobile/providers/utils.dart';
import 'package:erecipes_mobile/screens/frmTransakcije25062025_screen.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class FrmTRansakcije25062025NewScreen extends StatefulWidget {
  const FrmTRansakcije25062025NewScreen({super.key});

  @override
  State<FrmTRansakcije25062025NewScreen> createState() =>
      FrmTRansakcije25062025NewScreenState();
}

class FrmTRansakcije25062025NewScreenState
    extends State<FrmTRansakcije25062025NewScreen> {
  final Transakcija25062025Provider _transakcija25062025provider =
      Transakcija25062025Provider();
  List<Transakcija25062025> _listaTransakcija = [];
  var korisnik;
  double? _iznos;
  DateTime? _selectedDate = DateTime.now();
  String? _opis;
  final KategorijaTransakcije25062025Provider
      _kategorijaTransakcije25062025Provider =
      KategorijaTransakcije25062025Provider();
  List<KategorijaTransakcije25062025> _listaKategorija = [];
  KategorijaTransakcije25062025? _selectedKAtegorija;
  String? _status = "Planirano";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    final resposne = await _transakcija25062025provider.get();
    final kategorijaR = await _kategorijaTransakcije25062025Provider.get();
    korisnik = AuthProvider.korisnik;
    setState(() {
      _listaTransakcija = resposne.result;
      _listaKategorija = kategorijaR.result;
    });
  }

  void addTransakcija() async {
    if (_iznos == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Greska"),
              content: Text("Mosrate unijeti iznos/ iznos mora biti broj"),
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
              title: Text("Greska"),
              content: Text("Mosrate unijeti datum"),
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
              title: Text("Greska"),
              content: Text("Mosrate unijeti opis"),
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
    if (_selectedKAtegorija == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Greska"),
              content: Text("Mosrate odabrati kategoriju"),
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
      await _transakcija25062025provider.insert(Transakcija25062025(
          this.korisnik.korisnikId,
          this._iznos,
          this._selectedDate,
          this._opis,
          this._selectedKAtegorija!.kategorijaTransakcije25062025Id,
          this._status));
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Uspjesno ste dodali"),
              content: Text(""),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const FrmTRansakcije25062025Screen()));
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
            title: Text("Greška"),
            content: Text("${e.toString()}"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Ok"),
              ),
            ],
          );
        },
      );
      
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
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    _iznos = double.tryParse(value) ?? _iznos;
                  });
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Unesite iznos"),
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
                  child: Text(_selectedDate == null
                      ? "Odaberite datum"
                      : "Odabrani datum ${formatDate(_selectedDate!)}")),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    _opis = value;
                  });
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Unesite opis"),
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Odaberite kategoriju"),
                value: _listaKategorija.contains(_selectedKAtegorija)
                    ? _selectedKAtegorija
                    : null,
                onChanged: (KategorijaTransakcije25062025? e) {
                  setState(() {
                    _selectedKAtegorija = e;
                  });
                },
                items: _listaKategorija.map(
                  (KategorijaTransakcije25062025 e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text("${e.naziv ?? ""}"),
                    );
                  },
                ).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Odaberite status"),
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
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    addTransakcija();
                  },
                  child: Text("Dodaj"))
            ],
          ),
        ),
      ),
    );
  }
}
