import 'package:erecipes_mobile/models/kategorija_transakcije14072025.dart';
import 'package:erecipes_mobile/models/statistika.dart';
import 'package:erecipes_mobile/models/transakcija14072025.dart';
import 'package:erecipes_mobile/providers/kategorija_transakcije14072025_provider.dart';
import 'package:erecipes_mobile/providers/transakcija14072025_provider.dart';
import 'package:erecipes_mobile/providers/utils.dart';
import 'package:erecipes_mobile/screens/frmTransakcija14072025New.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FrmTransakcije14072025 extends StatefulWidget {
  const FrmTransakcije14072025({super.key});

  @override
  State<FrmTransakcije14072025> createState() => FrmTransakcije14072025State();
}

class FrmTransakcije14072025State extends State<FrmTransakcije14072025> {
  final Transakcija14072025Porvider _transakcija14072025porvider =
      Transakcija14072025Porvider();
  List<Transakcija14072025> _listaTransakcija = [];
  final KategorijaTransakcije14072025Provider
      _kategorijaTransakcije14072025Provider =
      KategorijaTransakcije14072025Provider();
  List<KategorijaTransakcije14072025> _listaKategorija = [];
  KategorijaTransakcije14072025? _selectedKat;
  DateTime? _datumOd;
  DateTime? _datumDo;
  List<Statistika> _lista=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    final response = await _transakcija14072025porvider.get();
    final kat = await _kategorijaTransakcije14072025Provider.get();
    final l=await _transakcija14072025porvider.GetIznos();
    setState(() {
      _listaTransakcija = response.result;
      _listaKategorija = kat.result;
      _lista=l;
    });
  }

  void _filteredData() async {
    final res = await _transakcija14072025porvider.get(filter: {
      'KategorijaTransakcije14072025Id':
          _selectedKat?.kategorijaTransakcije14072025Id,
      'DatumOd': _datumOd,
      'DatumDo': _datumDo
    });
    final l=await _transakcija14072025porvider.GetIznos(filter: {'KategorijaTransakcije14072025Id':
          _selectedKat?.kategorijaTransakcije14072025Id,});
    setState(() {
      _listaTransakcija = res.result;
         _lista=l;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(naslov: 'eRecipes'),
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => FrmTransakcije14072025New()));
                  },
                  child: Text("Dodaj"))
            ],
          ),
          DropdownButtonFormField<KategorijaTransakcije14072025>(
            value:
                _listaKategorija.contains(_selectedKat) ? _selectedKat : null,
            onChanged: (KategorijaTransakcije14072025? e) {
              setState(() {
                _selectedKat = e;
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
          ElevatedButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2200));
                if (selectedDate != null) {
                  setState(() {
                    _datumDo = selectedDate;
                  });
                }
              },
              child: Text(_datumDo == null
                  ? "Odaberite datum do"
                  : "Odabrani datum do ${formatDate(_datumDo!)}")),
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
                    _datumOd = selectedDate;
                  });
                }
              },
              child: Text(_datumOd == null
                  ? "Odaberite datum od"
                  : "Odabrani datum od ${formatDate(_datumOd!)}")),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                _filteredData();
              },
              child: Text("Pretrazi")),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                columns: const [
                  DataColumn(label: Text("Naziv")),
                  DataColumn(label: Text("Iznos")),
                  DataColumn(label: Text("Tip")),
                  DataColumn(label: Text("Status")),
                  DataColumn(label: Text("datum")),
                ],
                rows: _listaTransakcija.map((e) {
                  return DataRow(
                    cells: [
                      DataCell(
                          Text(e.kategorijaTransakcije14072025?.naziv ?? "")),
                      DataCell(Text(e.iznos.toString() ?? "")),
                      DataCell(
                          Text(e.kategorijaTransakcije14072025?.tip ?? "")),
                      DataCell(Text(e.status ?? "")),
                      DataCell(Text(formatDate(e.datumTransakcije!))),
                    ],
                  );
                }).toList()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ..._lista.map((e) {
                  return Row(
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${e.naziv}: "),
                      Text("${e.iznos}"),
                    ],
                  );
                })
              ],
            ),
          )
        ]),
      ),
    );
  }
}
