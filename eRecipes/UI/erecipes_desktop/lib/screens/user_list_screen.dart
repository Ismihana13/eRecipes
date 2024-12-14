import 'package:erecipes_desktop/modal/edit_user_modal.dart';
import 'package:erecipes_desktop/models/korisnik.dart';
import 'package:erecipes_desktop/models/search_result.dart';
import 'package:erecipes_desktop/providers/korisnik_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late final KorisnikProvider provider;  
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

      result = await provider.get(filter: filter);

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
    ).then((_) =>{
        _fetchData()
    } );
  }
   void updateUser(int id, dynamic request) async {
    try {
      var updatedUser = await provider.update(id, request);
      if (updatedUser != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User updated successfully'),
          ),
        );
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update user'),
          ),
        );
      }
    } catch (e) {
      print("Error updating user: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildSearch(),
          if (_isLoading)
            CircularProgressIndicator(),  
          _buildResultView(),
        ],
      ),
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
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0), 
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
    return Center(
      child: Text('No results found'),
    );
  }

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
        columns: [
          DataColumn(
            label: Center(child: Text("Korisnik ID", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
          ),
          DataColumn(
            label: Center(child: Text("Korisničko ime", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
          ),
          DataColumn(
            label: Center(child: Text("Email", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
          ),
          DataColumn(
            label: Center(child: Text("Uloga", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
          ),
          DataColumn(
            label: Center(child: Text("Uredi korisnika", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
          ),
          DataColumn(
            label: Center(child: Text("Obriši korisnika", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
          ),
        ],
        rows: result!.result.map((e) {
          return DataRow(
            cells: [
              DataCell(Center(child: Text(e.korisnikId.toString(), style: TextStyle(fontWeight: FontWeight.bold)))),
              DataCell(Center(child: Text(e.korisnickoIme ?? "", style: TextStyle(fontWeight: FontWeight.bold)))),
              DataCell(Center(child: Text(e.email ?? "", style: TextStyle(fontWeight: FontWeight.bold)))),
              DataCell(Center(child: Text(e.uloge ?? "", style: TextStyle(fontWeight: FontWeight.bold)))),
              DataCell(
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(226, 121, 191, 248),
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      openEditUserModal(e);
                    },
                    child: Text('Uredi korisnika'),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.black, 
                    ),
                   onPressed: () async {
                      final confirm = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                              return AlertDialog(
                              title: Text('Potvrda'),
                              content: Text('Da li ste sigurni da želite obrisati korisnika?'),
                              actions: [
                                  TextButton(
                                     onPressed: () {
                                         Navigator.pop(context, false); 
                                     },
                                     child: Text('Ne'),
                                     ),
                                  TextButton(
                                     onPressed: () {
                                       Navigator.pop(context, true); 
                                    },
                                  child: Text('Da'),
                                  ),
                                  ],
                               );
                             },
                           );

                         if (confirm == true) {
                            try {
                               await provider.deleteKorisnik(e.korisnikId);
                               await _fetchData(); 
                               ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(content: Text('Korisnik je uspješno obrisan')),
                             );
                           } catch (error) {
                         print("Greška pri brisanju korisnika: $error");
                        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Došlo je do greške pri brisanju korisnika')),
                      );
                    }
                  }
                },
                  child: Text("Obriši korisnika"),
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