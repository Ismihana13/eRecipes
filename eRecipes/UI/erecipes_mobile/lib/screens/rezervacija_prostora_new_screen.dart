import 'package:erecipes_mobile/models/korisnik.dart';
import 'package:erecipes_mobile/models/radni_prostor.dart';
import 'package:erecipes_mobile/models/rezervacija_prostora.dart';
import 'package:erecipes_mobile/models/search_result.dart';
import 'package:erecipes_mobile/providers/korisnik_provider.dart';
import 'package:erecipes_mobile/providers/radni_prostor_provider.dart';
import 'package:erecipes_mobile/providers/rezervacija_prostora_provider.dart';
import 'package:erecipes_mobile/providers/utils.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:erecipes_mobile/widgets/custom_title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class RezervacijaProstoraNewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RezervacijaProstoraNewState();
}

class _RezervacijaProstoraNewState extends State<RezervacijaProstoraNewScreen> {
  final _formKey = GlobalKey<FormState>();
  final RezervacijaProstoraProvider _rezervacijaProstoraProvider =
      RezervacijaProstoraProvider();
  List<RezervacijaProstora> _rezervacijaProstora = [];
  final KorisnikProvider _korisnikProvider = KorisnikProvider();
  SearchResult<Korisnik>? korisnikResult;
  String? _selectedkorisnikId;
  final RadniProstorProvider _radniProstorProvider = RadniProstorProvider();
  SearchResult<RadniProstor>? radniProstorResult;
  String? _selectedradniProstorId;
  int _trajanje = 1;
  DateTime _selectedDate = DateTime.now();
  String _napomena = "";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await _rezervacijaProstoraProvider.get();
      final responseUser = await _korisnikProvider.get();
      final responseRadniProstor = await _radniProstorProvider.get();
      if (responseUser != null && responseUser.result.isNotEmpty) {
        _selectedkorisnikId = responseUser.result.first.korisnikId.toString();
      }
      if (responseRadniProstor != null &&
          responseRadniProstor.result.isNotEmpty) {
        _selectedradniProstorId =
            responseRadniProstor.result.first.radniProstorId.toString();
      }
      setState(() {
        _rezervacijaProstora = response.result;
        korisnikResult = responseUser;
        radniProstorResult = responseRadniProstor;
      });
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(naslov: 'eRecipes'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const CustomTitleText(title: 'Dodajte novi recept'),
            _buildFormForRezervation(),
          ],
        ),
      ),
    );
  }

  Widget _buildFormForRezervation() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildDropdown(
                  'Odaberite korisnika',
                  korisnikResult?.result,
                  _selectedkorisnikId,
                  (value) => setState(() => _selectedkorisnikId = value)),
              const SizedBox(height: 30),
              _buildDropdown(
                  'Odaberite radni prostor',
                  radniProstorResult?.result,
                  _selectedradniProstorId,
                  (value) => setState(() => _selectedradniProstorId = value)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Trajanje: '),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: _trajanje > 1
                        ? () => setState(() => _trajanje = _trajanje - 1)
                        : null,
                  ),
                  Text(
                    "$_trajanje h",
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => setState(() => _trajanje = _trajanje + 1),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Unesite opcionalno napomenu',
                  border: OutlineInputBorder(),
                ),
                onChanged: (napomena) {
                  setState(() {
                    _napomena = napomena;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (selectedDate != null) {
                    final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                    );

                    if (selectedTime != null) {
                      setState(() {
                        _selectedDate = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );
                      });
                    }
                  }
                },
                child: Text(
                  'Odabrani datum i vrijeme: ${formatDateWithTime(_selectedDate)}',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () {
                    _addrezervacija();
                  },
                  child: const Text("Rezerviši")),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List? items, String? selectedValue,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedValue,
          onChanged: onChanged,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: items?.map((item) {
            return DropdownMenuItem<String>(
              value: item is Korisnik
                  ? item.korisnikId.toString()
                  : item is RadniProstor
                      ? item.radniProstorId.toString()
                      : '',
              child: Text(item is Korisnik
                  ? '${item.ime ?? ''} ${item.prezime ?? ''}'
                  : item is RadniProstor
                      ? item.oznaka ?? "Nepoznat radni prostor"
                      : ""),
            );
          }).toList(),
          validator: (value) => value == null ? 'Odaberite opciju' : null,
        ),
      ],
    );
  }

  void _addrezervacija() async {
    if (_trajanje > 6) {
      bool? continueReservation = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Upozorenje'),
          content: const Text(
              'Morate čekati odobrenje od Admina za svako trajanje duže od 6h!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Nastavi'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Prekini'),
            ),
          ],
        ),
      );

      if (continueReservation == false) {
        return; //
      }
    }
    RezervacijaProstora request = RezervacijaProstora(
        datumIVrijemePocetkaRezervacije: _selectedDate,
        trajanje: _trajanje,
        statusRezervacije: _trajanje > 6 ? 'Na_cekanju' : 'Potvrdjena',
        napomena: _napomena,
       korisnikId: int.tryParse(_selectedkorisnikId ?? ''),
       radniProstorId: int.tryParse(_selectedradniProstorId ?? ''));
    
    try {
      await _rezervacijaProstoraProvider.insert(request);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Uspješno'),
          content: const Text('Uspješno dodana rezervacija.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, true);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Greška'),
          content: const Text(
              'Greška prilikom rezervacije, molimo pokušajte ponovo!'),
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
