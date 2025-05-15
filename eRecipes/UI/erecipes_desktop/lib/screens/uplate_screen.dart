import 'package:erecipes_desktop/models/search_result.dart';
import 'package:erecipes_desktop/models/uplata.dart';
import 'package:erecipes_desktop/providers/uplata_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UplataScreen extends StatefulWidget {
  const UplataScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UplataScreenState createState() => _UplataScreenState();
}

class _UplataScreenState extends State<UplataScreen> {
  UplataProvider? _uplataProvider;
  SearchResult<Uplata>? result;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _uplataProvider = context.read<UplataProvider>();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      result = await _uplataProvider!.get();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pregled uplata',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : result == null || result!.result.isEmpty
                    ? const Center(child: Text('Nema dostupnih uplata.'))
                    : ListView.builder(
                        itemCount: result!.result.length,
                        itemBuilder: (context, index) {
                          final uplata = result!.result[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: const Icon(Icons.payment),
                              title: Text(
                                '${uplata.korisnik?.ime ?? 'Nepoznato'} ${uplata.korisnik?.prezime ?? ''}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Datum: ${uplata.datumUplate?.toLocal().toString().split('.')[0]}',
                              ),
                              trailing: Text(
                                '${uplata.iznos?.toStringAsFixed(2)} KM',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
