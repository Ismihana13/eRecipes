import 'package:erecipes_mobile/models/kategorija_transakcije25062025.dart';
import 'package:erecipes_mobile/models/transakcija25062025.dart';
import 'package:erecipes_mobile/providers/kategorija_transakcije25062025_provider.dart';
import 'package:erecipes_mobile/providers/transakcija25062025_provider.dart';
import 'package:erecipes_mobile/providers/utils.dart';
import 'package:erecipes_mobile/screens/frmTransakcija25062025New_screen.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/iznos_kategorija.dart';

class FrmTransakcija25062025Screen extends StatefulWidget {
  const FrmTransakcija25062025Screen({super.key});

  @override
  State<FrmTransakcija25062025Screen> createState() =>
      FrmTransakcija25062025ScreenState();
}

class FrmTransakcija25062025ScreenState
    extends State<FrmTransakcija25062025Screen> {
  final Transakcija25062025Provider _transakcija25062025provider =
      Transakcija25062025Provider();
  List<Transakcija25062025> _listaTransakcija = [];
  final KategorijaTransakcije25062025Provider
      _kategorijaTransakcije25062025Provider =
      KategorijaTransakcije25062025Provider();
  List<KategorijaTransakcije25062025> _listaKat = [];
  KategorijaTransakcije25062025? _selectedKategorija;
  DateTime? _selectedDateOd;
  DateTime? _selectedDateDo;
  List<IznosKategorija> _listaIznosa=[];

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
        final resIznos= await _transakcija25062025provider.getIznos(filter: {
      'KategorijaTransakcije25062025Id':_selectedKategorija?.kategorijaTransakcije25062025Id,
      'DatumOd':_selectedDateOd,
      'DatumDo':_selectedDateDo
    });
    setState(() {
      _listaTransakcija = response.result;
      _listaKat = rresultKategorija.result;
      _listaIznosa=resIznos;
    });
  }
  
  void _filteredData() async{
    final rres= await _transakcija25062025provider.get(filter: {
      'KategorijaTransakcije25062025Id':_selectedKategorija?.kategorijaTransakcije25062025Id,
      'DatumOd':_selectedDateOd,
      'DatumDo':_selectedDateDo
    });
    setState(() {
      _listaTransakcija=rres.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(naslov: 'eRecipes'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> FrmTransakcija25062025NewScreen()));
                },
                child: Text("Dodaj"),
              )
            ]),
            Column(
              children: [
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
                  decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Odaberite kategoriju"),
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
                          _selectedDateOd = selectedDate;
                        });
                      }
                    },
                    child: Text(_selectedDateOd == null
                        ? "Odaberite datum od:"
                        : "Odabrani datum OD: ${formatDate(_selectedDateOd!)}")),
                ElevatedButton(
                    onPressed: () async {
                      final selectedDates = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2200));
                      if (selectedDates != null) {
                        setState(() {
                          _selectedDateDo = selectedDates;
                        });
                      }
                    },
                    child: Text(_selectedDateDo == null
                        ? "Odaberite datum Do:"
                        : "Odabrani datum Do: ${formatDate(_selectedDateDo!)}")),
                        ElevatedButton(onPressed: (){
                          _filteredData();
                        }, child: const Text("Pretraži"))
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  columns: const [
                    DataColumn(label: Text("Naziv")),
                    DataColumn(label: Text("Iznos")),
                    DataColumn(label: Text("Tip")),
                    DataColumn(label: Text("Status")),
                    DataColumn(label: Text("Datum")),
                  ],
                  rows: _listaTransakcija.map((e) {
                    return DataRow(cells: [
                      DataCell(
                          Text(e.kategorijaTransakcije25062025?.naziv ?? "")),
                      DataCell(Text(e.iznos.toString() )),
                      DataCell(
                          Text(e.kategorijaTransakcije25062025?.tip ?? "")),
                      DataCell(Text(e.status ?? "")),
                      DataCell(Text(e.datumTransakcije != null ? formatDate(e.datumTransakcije!) : "")),

                    ]);
                  }).toList()),
            ),
            Column(
              children: [
                ..._listaIznosa.map((e) {
                  return
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${e.nazivKategorije}:"),
                      Text("${e.iznos}")
                    ],
                  );
                  
                })
              ],
            )
          ],
        ),
      ),
    );
  }
}
