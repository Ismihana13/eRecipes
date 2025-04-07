import 'package:erecipes_desktop/modal/password_change_modal.dart';
import 'package:erecipes_desktop/providers/auth_provider.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromRGBO(0, 111, 37, 0.464),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(vertical: 20),
            width: 600, 
            decoration: BoxDecoration(
              color: const Color.fromRGBO(247, 249, 253, 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: <Widget>[
                 const Text(
                'Osnovni podaci',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 32, 62, 33),
                ),
              ),
              const SizedBox(height: 10),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        _buildProfileRow('Ime', AuthProvider.korisnik!.ime!),
                        _buildProfileRow('Prezime',  AuthProvider.korisnik!.prezime!),
                        _buildProfileRow('Korisničko ime', AuthProvider.korisnik!.korisnickoIme!),
                        _buildProfileRow('Email', AuthProvider.korisnik!.email!),
                        _buildProfileRow('Telefon', AuthProvider.korisnik!.telefon!),
                        _buildProfileRow('Uloga',AuthProvider.korisnik!.uloga!.naziv!),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () {
                    _resetPassword(context);
                  },
                  child: const Text('Promjeni lozinku', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

Widget _buildProfileRow(String label, String value) {
  IconData? icon;

  
if (label == 'Telefon') {
  icon = Icons.phone;
} else if (label == 'Email') {
  icon = Icons.email;
} else if (label == 'Korisničko ime') {
  icon = Icons.person;
} else if (label == 'Ime' || label == 'Prezime') {
  icon = Icons.badge;
}

  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18, color: const Color.fromARGB(255, 32, 62, 33)),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 32, 62, 33),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Color.fromARGB(255, 32, 62, 33),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
      const Divider(
        color: Colors.grey,
        thickness: 1,
        height: 1,
      ),
    ],
  );
}



  void _resetPassword(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ChangePasswordUserModal();
    },
  );
}

}
