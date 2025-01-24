import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String naslov;

  const CustomAppBar({super.key, required this.naslov});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        naslov,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
      backgroundColor: const Color.fromRGBO(1, 100, 34, 1),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
