import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample user data
    final user = {
      'ime': 'John',
      'prezime': 'Doe',
      'korisnickoIme': 'johndoe',
      'email': 'johndoe@example.com',
      'telefon': '037-123-456',
      'uloga': 'Admin'
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color.fromRGBO(0, 111, 37, 0.464),
      ),
      body: SingleChildScrollView( // Wrap the body in a SingleChildScrollView for scrollable content
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Padding to make the content fit well
          child: Center(
            child: Container(
              color: const Color.fromRGBO(247, 249, 253, 1),
              // Remove fixed width, let it take full available width
              child: Column(
                mainAxisSize: MainAxisSize.min, // Ensures the column uses only the space it needs
                children: <Widget>[
                  const SizedBox(height: 20),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProfileRow('Ime', user['ime']!),
                          _buildProfileRow('Prezime', user['prezime']!),
                          _buildProfileRow('Korisničko ime', user['korisnickoIme']!),
                          _buildProfileRow('Email', user['email']!),
                          _buildProfileRow('Telefon', user['telefon']!),
                          _buildProfileRow('Uloga', user['uloga']!),
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
                    child: const Text('Reset password', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  void _resetPassword(BuildContext context) {
    // Implement reset password functionality here
  }
}
