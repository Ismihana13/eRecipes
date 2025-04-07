import 'package:erecipes_desktop/main.dart';
import 'package:erecipes_desktop/providers/auth_provider.dart';
import 'package:erecipes_desktop/providers/korisnik_provider.dart';
import 'package:erecipes_desktop/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordUserModal extends StatefulWidget {
  const ChangePasswordUserModal({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChangePasswordUserModalState createState() =>
      _ChangePasswordUserModalState();
}

class _ChangePasswordUserModalState extends State<ChangePasswordUserModal> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _submitPasswordChange() async {
    if (_formKey.currentState!.validate()) {
      final newPassword = _newPasswordController.text;
      final confirmPassword = _confirmPasswordController.text;
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
        Navigator.pop(context);
        Navigator.of(context).pushNamedAndRemoveUntil(
          LoginScreen.routeName,
          (route) => false,
        );
        await context
            .read<KorisnikProvider>()
            .update(AuthProvider.korisnik!.korisnikId!, request);
        SuccessSnackBar.show(context, "Uspješno ste promijenili lozinku.");
      } catch (e) {
        ErrorSnackBar.show(context,
            'Neuspješna promjena lozinke. Pokušajte ponovo.\n${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
         width: MediaQuery.of(context).size.width * 0.6,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Promjeni lozinku',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Nova lozinka',
                     prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Unesite novu lozinku.';
                    }
                    if (value.length < 6) {
                      return 'Lozinka mora imati najmanje 6 znakova';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Potvrdite novu lozinku',
                     prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Molimo potvrdite svoju novu lozinku';
                    }
                    if (value != _newPasswordController.text) {
                      return 'Lozinke se ne podudaraju';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitPasswordChange,
                  child: const Text('Potvrdi promjene'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
