import 'package:erecipes_mobile/providers/auth_provider.dart';
import 'package:flutter/material.dart';

class WelcomeRow extends StatelessWidget {
  const WelcomeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Dobro došli!',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/user');
          },
          child: const Icon(Icons.person, color: Colors.black, size: 24),
        ),
        const SizedBox(width: 13),
        GestureDetector(
          onTap: () {
            AuthProvider.username = null;
            AuthProvider.password = null;
            Navigator.pushNamed(context, '/login');
          },
          child: const Icon(Icons.exit_to_app, color: Colors.black, size: 24),
        ),
        const SizedBox(width: 3),
      ],
    );
  }
}
