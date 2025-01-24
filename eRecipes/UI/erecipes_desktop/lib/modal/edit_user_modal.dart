import 'package:erecipes_desktop/models/korisnik.dart';
import 'package:erecipes_desktop/models/search_result.dart';
import 'package:erecipes_desktop/models/uloga.dart';
import 'package:erecipes_desktop/providers/uloga_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditUserModal extends StatefulWidget {
  final VoidCallback onCancelPressed;
  final void Function(int, dynamic) onUpdatePressed;
  final Korisnik? korisnikToEdit;

  const EditUserModal({
    required this.onCancelPressed,
    required this.onUpdatePressed,
    required this.korisnikToEdit,
  });

  @override
  _EditUserModalState createState() => _EditUserModalState();
}

class _EditUserModalState extends State<EditUserModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  late Korisnik? _korisnikToEdit;
  late UlogaProvider ulogaProvider;
  SearchResult<Uloga>? ulogaResult=null;
  Map<String,dynamic> _initialValue={};
   bool isLoading=true;

  @override
   void didChangeDependencies(){
    super.didChangeDependencies();
   
   }
    @override
  void initState() {
    ulogaProvider=context.read<UlogaProvider>();
    super.initState();
    _korisnikToEdit = widget.korisnikToEdit;
     nameController.text = _korisnikToEdit!.ime ?? '';
     surnameController.text = _korisnikToEdit!.prezime ?? '';
     emailController.text = _korisnikToEdit!.email ?? '';
     telephoneController.text = _korisnikToEdit!.telefon ?? '';
     userNameController.text = _korisnikToEdit!.korisnickoIme ?? '';
     _initialValue={
       'ulogaId':_korisnikToEdit?.ulogaId.toString(),
      };
    initForm();   
}

    Future initForm() async{
    ulogaResult= await ulogaProvider.get();
    print("vrtsa:${ulogaResult?.result.length}");
    setState(() {
      isLoading=false;
    });
  }
 
 Future<void> _editUser() async {
  final name = nameController.text;
  final surname = surnameController.text;
  final email = emailController.text;
  final telephone = telephoneController.text;
  final userName = userNameController.text;
  final ulogaId = _initialValue['ulogaId'];

  if (_korisnikToEdit != null) {
    widget.onUpdatePressed(_korisnikToEdit!.korisnikId!, {
      'ime': name,
      'prezime': surname,
      'email': email,
      'telefon': telephone,
      'korisnickoIme': userName,
      'ulogaId': ulogaId,
    }); 
    Navigator.pop(context);
  } else {
    print("Error: User to edit is null!");
  }
}

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: const Color.fromRGBO(247, 249, 253, 1),
          width: MediaQuery.of(context).size.width * 0.2,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Edit User',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Ime',
                        hintText: 'Example: John',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                          return 'Name can only contain letters';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: surnameController,
                      decoration: const InputDecoration(
                        labelText: 'Prezime',
                        hintText: 'Example: Smith',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your surname';
                        }
                        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                          return 'Surname can only contain letters';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: userNameController,
                      decoration: const InputDecoration(
                        labelText: 'Korisničko ime',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'example@email.com',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                            .hasMatch(value)) {
                          return 'Invalid email format';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: telephoneController,
                      decoration: const InputDecoration(
                        labelText: 'Telefon',
                        hintText: 'Example: 037-123-456',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your telephone';
                        }
                        if (!RegExp(r'^\d{3}-\d{3}-\d{3}$').hasMatch(value)) {
                          return 'Invalid phone number format';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: _initialValue['ulogaId'],
                      onChanged: (String? value) {
                      setState(() {
                        _initialValue['ulogaId'] = value; 
                      });
                    },
                     validator: (String? value) {
                     if (value == null || value.isEmpty) {
                          return 'Please select a role';
                         }
                       return null;
                      },
                      items: ulogaResult?.result.map((item) {
                      return DropdownMenuItem<String>(
                       value: item.ulogaId.toString(), 
                      child: Text(item.naziv ?? ''), 
                     );
                       }).toList() ?? [],
                     decoration: const InputDecoration(labelText: "Uloga"),
                    dropdownColor: const Color.fromRGBO(247, 249, 253, 1),
                  ),
                    const SizedBox(height: 20),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                          ),
                          onPressed: widget.onCancelPressed,
                          child: const Text('Cancel',
                              style: TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(97, 142, 246, 1),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _editUser();
                            }
                          },
                          child: const Text('Save',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


