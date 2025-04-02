import 'package:erecipes_desktop/modal/edit_user_modal.dart';
import 'package:erecipes_desktop/models/korisnik.dart';
import 'package:erecipes_desktop/models/search_result.dart';
import 'package:erecipes_desktop/providers/auth_provider.dart';
import 'package:erecipes_desktop/providers/korisnik_provider.dart';
import 'package:erecipes_desktop/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  KorisnikProvider? provider;
  SearchResult<Korisnik>? result;
  TextEditingController _ftsEditingController = TextEditingController();
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = context.read<KorisnikProvider>();
    _fetchData();
  }

  Future<void> _fetchData({String query = ''}) async {
    setState(() {
      _isLoading = true;
    });

    try {
      var filter = {
        'KorisnickoIme': query,
        'isKorisnikUlogeIncluded': true,
        'Status': true,
      };

      result = await provider!.get(filter: filter);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching data: $e');
    }
  }

  void openEditUserModal(Korisnik korisnik) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditUserModal(
          onCancelPressed: () {
            Navigator.pop(context);
          },
          onUpdatePressed: updateUser,
          korisnikToEdit: korisnik,
        );
      },
    ).then((_) {
      setState(() {
        _fetchData();
      });
    });
  }

  void updateUser(int id, dynamic request) async {
    try {
      var updatedUser = await provider!.update(id, request);
      // ignore: unnecessary_null_comparison
      if (updatedUser != null) {
        SuccessSnackBar.show(context, 'User updated successfully');
        setState(() {
          _fetchData();
        });
      } else {
        ErrorSnackBar.show(context, 'Failed to update user');
      }
    } catch (e) {
      print("Error updating user: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearch(),
        if (_isLoading) const CircularProgressIndicator(),
        _buildResultView(),
      ],
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: TextField(
                  controller: _ftsEditingController,
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                  ),
                  onChanged: (value) {
                    _fetchData(query: value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultView() {
    if (result == null || result!.result.isEmpty) {
      return const Center(
        child: Text('No results found'),
      );
    }
    final loggedInUserId = AuthProvider.korisnik!.korisnikId;
    return Container(
      width: double.infinity,
      color: Colors.grey[200],
      child: SingleChildScrollView(
        child: DataTable(
          columnSpacing: 10,
          border: TableBorder.all(
            color: Colors.black,
            width: 1,
            borderRadius: BorderRadius.zero,
          ),
          columns: const [
            DataColumn(
                label: Center(
                    child: Text("Korisničko ime",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)))),
            DataColumn(
                label: Center(
                    child: Text("Email",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)))),
            DataColumn(
                label: Center(
                    child: Text("Uloga",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)))),
            DataColumn(
                label: Center(
                    child: Text("Uredi korisnika",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)))),
            DataColumn(
                label: Center(
                    child: Text("Obriši korisnika",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)))),
          ],
          rows: result!.result.where((e) => e.korisnikId != 1).map((e) {
            return DataRow(
              cells: [
                DataCell(Center(
                    child: Text(e.korisnickoIme ?? "Nema korisničkog imena",
                        style: const TextStyle(fontWeight: FontWeight.bold)))),
                DataCell(Center(
                    child: Text(e.email ?? "Nema emaila",
                        style: const TextStyle(fontWeight: FontWeight.bold)))),
                DataCell(Center(
                    child: Text(e.uloga?.naziv ?? "Nema uloge",
                        style: const TextStyle(fontWeight: FontWeight.bold)))),
                DataCell(
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(226, 121, 191, 248),
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        openEditUserModal(e);
                      },
                      child: const Text('Uredi korisnika'),
                    ),
                  ),
                ),
                DataCell(
                  Center(
                    child: e.korisnikId == loggedInUserId
                        ? const SizedBox()
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.black,
                            ),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Potvrda'),
                                    content: const Text(
                                        'Da li ste sigurni da želite obrisati korisnika?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                        child: const Text(
                                          'Ne',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 42, 87, 44)),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, true);
                                        },
                                        child: const Text(
                                          'Da',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 42, 87, 44)),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (confirm == true) {
                                try {
                                  await provider!.deleteKorisnik(e.korisnikId);
                                  await _fetchData();
                                  SuccessSnackBar.show(
                                      context, 'Korisnik je uspješno obrisan.');
                                } catch (error) {
                                  ErrorSnackBar.show(context,
                                      'Došlo je do greške pri brisanju korisnika.');
                                }
                              }
                            },
                            child: const Text("Obriši korisnika"),
                          ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
