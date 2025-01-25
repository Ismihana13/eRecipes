import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final int maxLines;
  final TextInputType? keyboardType;

  const InputText({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        suffixIcon: label == 'Vrijeme pripreme (u minutama)'
            ? const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.access_time),
              )
            : null,
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'The field cannot be empty';
        }
        if (label == 'Vrijeme pripreme (u minutama)' &&
            int.tryParse(value ?? '') == null) {
          return 'Please enter a number';
        }
        return null;
      },
      maxLines: maxLines,
      keyboardType: keyboardType,
    );
  }
}
