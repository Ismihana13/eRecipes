import 'dart:async';
import 'package:erecipes_desktop/providers/notifikacije_provider.dart';
import 'package:erecipes_desktop/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:erecipes_desktop/models/notifikacije.dart';

class  NotifikacijeScreen extends StatefulWidget {
  @override
  _NotifikacijeScreenState createState() => _NotifikacijeScreenState();
}

class _NotifikacijeScreenState extends State<NotifikacijeScreen> {
  late NotifikacijeProvider _notifikacijeProvider;
  List<Notifikacije> _obavijesti = [];
  bool _isLoading = true;
  Timer? _timer;
  bool? _fileterProcitano;
  String? selectedFilter;

  @override
  void initState() {
    super.initState();
    _notifikacijeProvider = NotifikacijeProvider();
    _fetchData();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_fileterProcitano == null) {
        _fetchData();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _fetchData({bool? procitano}) async {
    try {
      final obavijesti = await _notifikacijeProvider.getSve(
        filter: procitano != null ? {'Procitano': procitano} : null,
      );
      setState(() {
        _obavijesti = obavijesti;
        _isLoading = false;
        _fileterProcitano = procitano;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Greška pri dohvaćanju podataka: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedFilter = null;
                });
                _fetchData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedFilter == null
                    ? Colors.grey
                    : const Color.fromARGB(255, 231, 231, 231),
                foregroundColor: Colors.black,
              ),
              child: const Text('Sve'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedFilter = 'true';
                });
                _fetchData(procitano: true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedFilter == 'true'
                    ? Colors.grey
                    : const Color.fromARGB(255, 231, 231, 231),
                foregroundColor: Colors.black,
              ),
              child: const Text('Pročitano'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedFilter = 'false';
                });
                _fetchData(procitano: false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedFilter == 'false'
                    ? Colors.grey
                    : const Color.fromARGB(255, 231, 231, 231),
                foregroundColor: Colors.black,
              ),
              child: const Text('Nepročitano'),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _obavijesti.isEmpty
              ? const Center(child: Text('Nema dostupnih obavijesti.'))
              : RefreshIndicator(
                  onRefresh: () async => _fetchData(),
                  child: ListView.builder(
                    itemCount: _obavijesti.length,
                    itemBuilder: (context, index) {
                      final obavijest = _obavijesti[index];

                      return Card(
                        elevation: 3,
                        color: obavijest.procitano == true
                            ? const Color.fromARGB(255, 224, 245, 207)
                            : null,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text(
                            obavijest.naslov ?? 'Bez naslova',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              SizedBox(
                                height: 60,
                                child: SingleChildScrollView(
                                  child:
                                      Text(obavijest.sadrzaj ?? 'Bez sadržaja'),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Datum slanja: ${formatDateAndHours(obavijest.datumSlanja)}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.check,
                                  color: obavijest.procitano == true
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                onPressed: () async {
                                  if (obavijest.procitano == false) {
                                    try {
                                      await _notifikacijeProvider
                                          .oznaciObavijestKaoProcitanu(
                                              obavijest.notifikacijeId!, true);
                                      setState(() {
                                        obavijest.procitano = true;
                                      });

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Obavijest je pročitana'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Neuspješno ažuriranje obavijesti'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.grey),
                                onPressed: () async {
                                  final confirmDelete = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Brisanje obavijesti'),
                                      content: const Text(
                                          'Jeste li sigurni da želite izbrisati ovu obavijest?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: const Text('Odustani'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: const Text('Obriši'),
                                        ),
                                      ],
                                    ),
                                  );
                                  if (confirmDelete == true) {
                                    try {
                                      await _notifikacijeProvider.obrisiObavijest(
                                          obavijest.notifikacijeId!);

                                      setState(() {
                                        _obavijesti.remove(obavijest);
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Obavijest je izbrisana'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Neuspješno brisanje obavijesti'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
