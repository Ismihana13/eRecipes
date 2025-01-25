import 'package:flutter/material.dart';

class CustomTitleText extends StatelessWidget {
  final String title;
  const CustomTitleText({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xCC0D3E09),
      ),
    );
  }
}
