import 'package:erecipes_mobile/main.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:erecipes_mobile/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:erecipes_mobile/providers/korisnik_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String routeName = "/signup";

  @override
  State<SignUpScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignUpScreen> {
  final TextEditingController _imeController = TextEditingController();
  final TextEditingController _prezimeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefonController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _datumRodjenjaController =
      TextEditingController();
  late KorisnikProvider _korisnikProvider;
  final _formKey = GlobalKey<FormState>();

  void handleSignup(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        bool usernameExists =
            await _korisnikProvider.checkUsername(_usernameController.text);

        if (usernameExists) {
          CustomSnackBar.showErrorSnackBar(
              context, 'Korisničko ime je već zauzeto.');
          return;
        }
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

        await _korisnikProvider.insert(korisnikRequest);
        CustomSnackBar.showSuccessSnackBar(context, 'Registration successful!');
        Navigator.pushNamed(context, LoginScreen.routeName);
      } catch (e) {
        CustomSnackBar.showErrorSnackBar(context, 'Registration failed.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _korisnikProvider = Provider.of<KorisnikProvider>(context, listen: false);
    return Scaffold(
      appBar: const CustomAppBar(naslov: 'eRecipes'),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: const [
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
                      backgroundColor: const Color.fromARGB(255, 42, 99, 56),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                            color: Color.fromRGBO(1, 100, 34, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
              return '$label can not be empty';
            }
            return null;
          },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
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
      prefixIcon: const Icon(Icons.calendar_today),
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
        _datumRodjenjaController.text =
            selectedDate.toLocal().toString().split(' ')[0];
      }
    },
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Molimo unesite datum rođenja.';
      }
      DateTime? birthDate = DateTime.tryParse(value);
      if (birthDate == null) {
        return 'Unesite važeći datum.';
      }

      DateTime today = DateTime.now();
      int age = today.year - birthDate.year;
      if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }

      if (age < 10) {
        return 'Morate biti stariji od 10 godina.';
      }
      return null;
    },
  );
}

  String? _emailValidator(String? value) {
    final emailRegExp =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
    if (value == null || value.isEmpty) {
      return 'Email can not be empty';
    } else if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _phoneValidator(String? value) {
    final phoneRegExp = RegExp(r"^\d{3}-\d{3}-\d{3,6}$");

    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    } else if (!phoneRegExp.hasMatch(value)) {
      return 'Phone number must be in format xxx-xxx-xxx or xxx-xxx-xxxxxx';
    }

    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password can not be empty';
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
