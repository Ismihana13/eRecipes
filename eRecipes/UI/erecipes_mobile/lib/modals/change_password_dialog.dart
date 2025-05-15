import 'package:erecipes_mobile/main.dart';
import 'package:erecipes_mobile/providers/auth_provider.dart';
import 'package:erecipes_mobile/providers/korisnik_provider.dart';
import 'package:erecipes_mobile/widgets/custom_snack_bar.dart';
import 'package:erecipes_mobile/widgets/custom_title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordDialog extends StatefulWidget {
  final Function(String oldPassword, String newPassword) onPasswordChange;
  final String? oldPassword;

  const ChangePasswordDialog({
    super.key,
    required this.onPasswordChange,
    required this.oldPassword,
  });

  @override
  // ignore: library_private_types_in_public_api
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

  void _submitPasswordChange() async {
    if (_formKey.currentState!.validate()) {
      final newPassword = newPasswordController.text;
      final confirmPassword = confirmNewPasswordController.text;

      final request = {
        'ime': AuthProvider.korisnik!.ime,
        'prezime': AuthProvider.korisnik!.prezime,
        'datumRodjenja':
            AuthProvider.korisnik!.datumRodjenja?.toIso8601String(),
        'email': AuthProvider.korisnik!.email,
        'telefon': AuthProvider.korisnik!.telefon,
        'korisnickoIme': AuthProvider.korisnik!.korisnickoIme,
        'lozinka': newPassword,
        'lozinkaPotvrda': confirmPassword,
        'ulogaId': AuthProvider.korisnik!.ulogaId,
      };

      try {
        await context.read<KorisnikProvider>().update(
              AuthProvider.korisnik!.korisnikId!,
              request,
            );
        AuthProvider.username = "";
        AuthProvider.password = "";

        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Lozinka promijenjena'),
              content: const Text(
                  'Uspješno ste promijenili lozinku. Molimo prijavite se s novom lozinkom.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        Navigator.of(context).pushNamedAndRemoveUntil(
          LoginScreen.routeName,
          (route) => false,
        );
      } catch (e) {
        CustomSnackBar.showErrorSnackBar(
          context,
          'Neuspješna promjena lozinke. Pokušajte ponovo.}',
        );
      }
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
            onPressed: _submitPasswordChange,
            child: const Text("Spremi"),
          ),
      ],
    );
  }
}
