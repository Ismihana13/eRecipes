import 'package:erecipes_mobile/widgets/custom_title_text.dart';
import 'package:flutter/material.dart';

class ChangePasswordDialog extends StatefulWidget {
  final Function(String oldPassword, String newPassword) onPasswordChange;
  final String? oldPassword; // 👈 dodano

  const ChangePasswordDialog({
    required this.onPasswordChange,
    required this.oldPassword, // 👈 dodano
  });

  @override
  _ChangePasswordDialogState createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  bool showNewPasswordFields = false;
  bool isOldPasswordInvalid = false;
  bool isNewPasswordInvalid = false;
  bool isConfirmPasswordInvalid = false;

  void _checkOldPassword() {
    if (oldPasswordController.text == widget.oldPassword) {
      setState(() {
        showNewPasswordFields = true;
        isOldPasswordInvalid = false;
      });
    } else {
      setState(() {
        isOldPasswordInvalid = true;
      });
    }
  }

  void _submit() {
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmNewPasswordController.text;

    // Provjera validnosti novih lozinki
    setState(() {
      isNewPasswordInvalid = newPassword.length < 6;
      isConfirmPasswordInvalid = newPassword != confirmPassword;
    });

    if (_formKey.currentState!.validate()) {
      if (isNewPasswordInvalid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Nova lozinka mora imati najmanje 6 karaktera.')),
        );
        return;
      }

      if (isConfirmPasswordInvalid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Nova lozinka i potvrda se ne poklapaju.')),
        );
        return;
      }

      widget.onPasswordChange(oldPasswordController.text, newPassword);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const CustomTitleText(
        title: "Izmjeni lozinku",
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: oldPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Stara lozinka",
                errorText: isOldPasswordInvalid ? "Netačna lozinka" : null,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Unesite staru lozinku';
                }
                return null;
              },
            ),
            if (showNewPasswordFields) ...[
              TextFormField(
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Nova lozinka",
                  errorText: isNewPasswordInvalid
                      ? "Lozinka mora imati najmanje 6 karaktera"
                      : null,
                ),
              ),
              TextFormField(
                controller: confirmNewPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Potvrdi novu lozinku",
                  errorText: isConfirmPasswordInvalid
                      ? "Lozinke se ne poklapaju"
                      : null,
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Otkaži"),
        ),
        if (!showNewPasswordFields)
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _checkOldPassword();
              }
            },
            child: const Text("Dalje"),
          ),
        if (showNewPasswordFields)
          ElevatedButton(
            onPressed: _submit,
            child: const Text("Spremi"),
          ),
      ],
    );
  }
}
