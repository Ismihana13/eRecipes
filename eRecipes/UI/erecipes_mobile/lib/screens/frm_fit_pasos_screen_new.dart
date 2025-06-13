import 'package:erecipes_mobile/models/fit_pasos.dart';
import 'package:erecipes_mobile/models/korisnik.dart';
import 'package:erecipes_mobile/providers/fit_pasos_provider.dart';
import 'package:erecipes_mobile/providers/korisnik_provider.dart';
import 'package:erecipes_mobile/providers/utils.dart';
import 'package:erecipes_mobile/screens/frm_fit_pasos_screen.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class FrmFitPasosNewScreen extends StatefulWidget {
  const FrmFitPasosNewScreen({super.key});

  @override
  State<FrmFitPasosNewScreen> createState() => _FrmFitPasosNewScreenState();
}

class _FrmFitPasosNewScreenState extends State<FrmFitPasosNewScreen> {
  final FitPasosProvider _fitPasosProvider = FitPasosProvider();
  final KorisnikProvider _korisnikProvider = KorisnikProvider();
  List<Korisnik> _listaKorisnik = [];
  Korisnik? _selecetedKorisnik;
  DateTime _selectedDate = DateTime.now();
  bool? _validan = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    final responseUser = await _korisnikProvider.get();
    setState(() {
      _listaKorisnik = responseUser.result;
    });
  }
  void _addFitPasos() async{
    if(_selecetedKorisnik==null){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title:  const Text("Greška"),
          content: const Text("Niste odabrali kroisnika"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context,true);
            }, child: const Text("Ok"))
          ],
        );
      });
      return;
    }
    try {
      await _fitPasosProvider.insert(FitPasos(_selecetedKorisnik!.korisnikId,
    _selectedDate,_validan));
     showDialog(context: context, builder: (context){
        return AlertDialog(
          title:  const Text("Uspjesno dodato "),
          actions: [
            TextButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> const FrmFitPasosScreen()));
            }, child: const Text("Ok"))
          ],
        );
      });
    } catch (e) {
       showDialog(context: context, builder: (context){
        return AlertDialog(
          title:  const Text("Greška"),
          content: const Text("Greška prilikom dodavanja pokusajte opet"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context,true);
            }, child: const Text("Ok"))
          ],
        );
      });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(naslov: 'Dodaj novi Pasos'),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              DropdownButtonFormField(
                value: _listaKorisnik.contains(_selecetedKorisnik)
                    ? _selecetedKorisnik
                    : null,
                onChanged: (Korisnik? user) {
                  setState(() {
                    _selecetedKorisnik = user;
                  });
                },
                items: _listaKorisnik.map((Korisnik e) {
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
                  child: Text("Odabrani datum važenja ${formatDate(_selectedDate)}")),
              DropdownButtonFormField(
                value: _validan,
                onChanged: (bool? e) {
                  setState(() {
                    _validan = e;
                  });
                },
                items: const [
                  DropdownMenuItem(
                    value: true,
                    child: Text("Aktivan"),
                  ),
                  DropdownMenuItem(
                    value: false,
                    child: Text("Neaktivan"),
                  ),
                  
                ],
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Odaberi"),
              ),
              ElevatedButton(onPressed: (){
                _addFitPasos();
              }, child: const Text("Dodaj"))
            ],
          ),
        ));
  }
}
