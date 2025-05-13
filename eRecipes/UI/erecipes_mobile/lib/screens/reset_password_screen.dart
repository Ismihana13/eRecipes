import 'package:erecipes_mobile/widgets/custom_title_text.dart';
import 'package:flutter/material.dart';
import 'package:erecipes_mobile/providers/korisnik_provider.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const routeName = '/reset-password';

  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isUserFound = false;
  bool isLoading = false;
  void checkUsername(BuildContext context) async {
    var korisnickoIme = usernameController.text;

    if (korisnickoIme.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Unesite korisničko ime."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    setState(() {
      isLoading = true;
    });

    try {
      final korisnikProvider = context.read<KorisnikProvider>();
      bool userExists = await korisnikProvider.checkUsername(korisnickoIme);
      setState(() {
        isUserFound = userExists;
      });

      if (!userExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Korisničko ime nije pronađeno."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Greška prilikom provjere korisničkog imena: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void sendResetEmail() async {
    String email = emailController.text;

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Molimo unesite email!"),
            backgroundColor: Colors.red),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final korisnikProvider = context.read<KorisnikProvider>();
      bool isSuccess = await korisnikProvider.resetPasswordByEmail(email);

      if (isSuccess) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const CustomTitleText(
                title: "Uspjesno resetovanje",
              ),
              content: const Text(
                  "Nova lozinka vam je poslata na email, proverite svoj inbox."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Korisnik sa unesenim emailom nije pronađen."),
              backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Greška pri resetovanju lozinke: $e"),
            backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Unesite korisničko ime za reset lozinke",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: "Korisničko ime",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : () => checkUsername(context),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Provjeri korisničko ime"),
            ),
            if (isUserFound) ...[
              const SizedBox(height: 20),
              const Text(
                "Unesite email adresu povezanu s vašim korisničkim računom kako bismo vam poslali novu lozinku.",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: sendResetEmail,
                child: const Text("Pošalji reset lozinke"),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
