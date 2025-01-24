import 'package:flutter/material.dart';

class WelcomeRow extends StatelessWidget {
  const WelcomeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          'Dobro došli!',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
        Icon(Icons.person, color: Colors.black, size: 24),
      ],
    );
  }
}
