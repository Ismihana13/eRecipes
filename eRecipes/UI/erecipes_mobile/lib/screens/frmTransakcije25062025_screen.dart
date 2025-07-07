import 'package:erecipes_mobile/models/kategorija_transakcije25062025.dart';
import 'package:erecipes_mobile/models/stat_kategorija.dart';
import 'package:erecipes_mobile/models/transakcija25062025.dart';
import 'package:erecipes_mobile/providers/kategorija_transakcije25062025_provider.dart';
import 'package:erecipes_mobile/providers/transakcija25062025_provider.dart';
import 'package:erecipes_mobile/providers/utils.dart';
import 'package:erecipes_mobile/screens/frmTransakcije25062025New_screen.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FrmTRansakcije25062025Screen extends StatefulWidget {
  const FrmTRansakcije25062025Screen({super.key});

  @override
  State<FrmTRansakcije25062025Screen> createState() =>
      FrmTRansakcije25062025ScreenState();
}

class FrmTRansakcije25062025ScreenState
    extends State<FrmTRansakcije25062025Screen> {
  final Transakcija25062025Provider _transakcija25062025provider =
      Transakcija25062025Provider();
  List<Transakcija25062025> _listaTransakcija = [];
  final KategorijaTransakcije25062025Provider
      _kategorijaTransakcije25062025Provider =
      KategorijaTransakcije25062025Provider();
  List<KategorijaTransakcije25062025> _listaKategorija = [];
  KategorijaTransakcije25062025? _selectedKAtegorija;
  DateTime? _selectedDatumOd;
  DateTime? _selectedDatumDo;
  List<StatKategorija> _list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    final resposne = await _transakcija25062025provider.get();
    final resposneK = await _kategorijaTransakcije25062025Provider.get();
    final res = await _transakcija25062025provider.getStatistika(filter: {
      'KategorijaTransakcije25062025Id':
          _selectedKAtegorija?.kategorijaTransakcije25062025Id
    });
    setState(() {
      _listaTransakcija = resposne.result;
      _listaKategorija = resposneK.result;
      _list = res;
    });
  }

  void _filteredData() async {
    final resposne = await _transakcija25062025provider.get(filter: {
      'KategorijaTransakcije25062025Id':
          _selectedKAtegorija?.kategorijaTransakcije25062025Id,
      'DatumOd': _selectedDatumOd,
      'DatumDo': _selectedDatumDo
    });
    final res = await _transakcija25062025provider.getStatistika(filter: {
      'KategorijaTransakcije25062025Id':
          _selectedKAtegorija?.kategorijaTransakcije25062025Id
    });

    setState(() {
      _listaTransakcija = resposne.result;
      _list = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(naslov: 'eRecipes'),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FrmTRansakcije25062025NewScreen()));
                        },
                        child: Text("Dodaj"))
                  ],
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
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
                ElevatedButton(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2200),
                          initialDate: DateTime.now());
                      if (selectedDate != null) {
                        setState(() {
                          _selectedDatumOd = selectedDate;
                        });
                      }
                    },
                    child: Text(_selectedDatumOd == null
                        ? "Odaberite datum od"
                        : "Odabrani datum ${formatDate(_selectedDatumOd!)}")),
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
                          _selectedDatumDo = selectedDate;
                        });
                      }
                    },
                    child: Text(_selectedDatumDo == null
                        ? "Odaberite datum do"
                        : "Odabrani datum ${formatDate(_selectedDatumDo!)}")),
                ElevatedButton(
                    onPressed: () {
                      _filteredData();
                    },
                    child: Text("Pretraži")),
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
                          DataCell(Text(
                              e.kategorijaTransakcije25062025?.naziv ?? "")),
                          DataCell(Text(e.iznos.toString())),
                          DataCell(
                              Text(e.kategorijaTransakcije25062025?.tip ?? "")),
                          DataCell(Text(e.status ?? "")),
                          DataCell(Text(formatDate(e.datumTransakcije!))),
                        ]);
                      }).toList()),
                ),
                Column(
                  children: [
                    ..._list.map((e) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("${e.naziv}:"), Text(("${e.iznos}"))],
                      );
                    })
                  ],
                )
              ],
            )));
  }
}
