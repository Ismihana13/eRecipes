import 'package:erecipes_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:erecipes_mobile/providers/korisnik_provider.dart';


class SingupScreen extends StatelessWidget {
  SingupScreen({super.key});
  
  TextEditingController _imeController = TextEditingController();
  TextEditingController _prezimeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _telefonController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();
  TextEditingController _datumRodjenjaController = TextEditingController();

  late KorisnikProvider _korisnikProvider;
  final _formKey = GlobalKey<FormState>();
  static const String routeName = "/signup";

  void handleSignup(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        final korisnikRequest = {
          'ime': _imeController.text,
          'prezime': _prezimeController.text,
          'email': _emailController.text,
          'telefon': _telefonController.text,
          'korisnickoIme': _usernameController.text,
          'lozinka': _passwordController.text,
          'lozinkaPotvrda': _passwordConfirmController.text,
          'datumRodjenja': _datumRodjenjaController.text.isNotEmpty
              ? DateTime.parse(_datumRodjenjaController.text).toIso8601String()
              : null,
        };

        print('Korisnički zahtev: $korisnikRequest');

        var result = await _korisnikProvider.insert(korisnikRequest);
        print('Rezultat registracije: $result');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful!'),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.of(context).pushNamedAndRemoveUntil(
          LoginScreen.routeName,
          (route) => false,
        );
      } catch (e) {
        print('Greška prilikom registracije: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed. Error: $e'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _korisnikProvider = Provider.of<KorisnikProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'eRecipes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: Color.fromRGBO(1, 100, 34, 1),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(1, 100, 34, 1),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _imeController,
                    label: 'Ime',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _prezimeController,
                    label: 'Prezime',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    icon: Icons.email,
                    validator: _emailValidator,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _telefonController,
                    label: 'Telefon',
                    icon: Icons.phone,
                    validator: _phoneValidator,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _usernameController,
                    label: 'Username',
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Password',
                    icon: Icons.lock_outline,
                    obscureText: true,
                    validator: _passwordValidator,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _passwordConfirmController,
                    label: 'Confirm Password',
                    icon: Icons.lock_outline,
                    obscureText: true,
                    validator: _confirmPasswordValidator,
                  ),
                  const SizedBox(height: 20),
                  _buildDateField(),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => handleSignup(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 42, 99, 56),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator ??
          (value) {
            if (value!.isEmpty) {
              return '$label cannot be empty';
            }
            return null;
          },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: const Color(0xFFEFEFEF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return TextFormField(
      controller: _datumRodjenjaController,
      decoration: InputDecoration(
        labelText: 'Datum Rođenja',
        prefixIcon: Icon(Icons.calendar_today),
        filled: true,
        fillColor: const Color(0xFFEFEFEF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: _formKey.currentContext!,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (selectedDate != null) {
          _datumRodjenjaController.text = selectedDate.toLocal().toString().split(' ')[0];
        }
      },
    );
  }

  String? _emailValidator(String? value) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _phoneValidator(String? value) {
    final phoneRegExp = RegExp(r"^\d{3}-\d{3}-\d{3}$");
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    } else if (!phoneRegExp.hasMatch(value)) {
      return 'Phone number must be in format xxx-xxx-xxx';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
