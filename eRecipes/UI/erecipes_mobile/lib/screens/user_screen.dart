import 'dart:convert';

import 'package:erecipes_mobile/modals/edit_profile_modal.dart';
import 'package:erecipes_mobile/models/recept.dart';
import 'package:erecipes_mobile/providers/recipe_provider.dart';
import 'package:erecipes_mobile/screens/recipe_details_screen.dart';
import 'package:erecipes_mobile/screens/recipe_list_screen.dart';
import 'package:erecipes_mobile/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:erecipes_mobile/providers/auth_provider.dart';
import 'package:erecipes_mobile/providers/korisnik_provider.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:erecipes_mobile/widgets/custom_title_text.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  static const String routeName = "/user";
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final KorisnikProvider korisnikProvider = KorisnikProvider();
  RecipeProvider recipeProvider = RecipeProvider();
  List<Recept> userRecipes = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchUserRecipes();
  }

  @override
  void initState() {
    super.initState();
    recipeProvider = context.read<RecipeProvider>();
    _fetchUserRecipes();
  }

  _fetchUserRecipes() async {
    try {
      var userId = AuthProvider.korisnik?.korisnikId;
      if (userId != null) {
        var recipes = await recipeProvider.getReceptiByKorisnikId(userId);
        setState(() {
          userRecipes = recipes;
        });
      }
    } catch (e) {
      setState(() {
        userRecipes = [];
      });
    }
  }

  Future<void> updateUser(int id, Map<String, dynamic> request) async {
    try {
      var updatedUser = await korisnikProvider.updateMobile(id, request);
      setState(() {
        AuthProvider.korisnik = updatedUser;
      });
       CustomSnackBar.showSuccessSnackBar(context,'Podaci su uspješno ažurirani.');
    } catch (e) {
      print("Error updating user: $e");
    }
  }

  _deleteProfile() async {
    try {
      await korisnikProvider
          .deleteKorisnikPorfil(AuthProvider.korisnik?.korisnikId ?? 0);
      Navigator.pushReplacementNamed(context, '/login');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil je uspješno obrisan.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Došlo je do greške pri brisanju profila.')),
      );
    }
  }

  _deleteRecipe(int? receptId) async {
    try {
      await recipeProvider.deleteRecept(receptId);
      _fetchUserRecipes();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recept je obrisan.')),
      );
    } catch (e) {
      print("Greška pri brisanju recepta: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Došlo je do greške pri brisanju recepta.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeListScreen(),
          ),
        );
        return true;
      },
      child: Scaffold(
        appBar: const CustomAppBar(naslov: 'eRecipes'),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Center(child: CustomTitleText(title: 'Moj profil')),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EditProfileDialog(
                                onEditPressed: (Map<String, dynamic> newEdit) {
                                  updateUser(
                                    AuthProvider.korisnik?.korisnikId ?? 0,
                                    newEdit,
                                  );
                                },
                                userData: {
                                  'name': AuthProvider.korisnik?.ime ?? '',
                                  'surname':
                                      AuthProvider.korisnik?.prezime ?? '',
                                  'email': AuthProvider.korisnik?.email ?? '',
                                  'telephone': AuthProvider.korisnik?.telefon
                                          ?.toString() ??
                                      '',
                                },
                              );
                            },
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Uredi podatke',
                            style: TextStyle(color: Colors.blue, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          _deleteProfile();
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 3),
                          child: Text(
                            'Obriši profil',
                            style: TextStyle(color: Colors.red, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    _buildUserData(),
                    const SizedBox(
                      height: 13,
                    ),
                    const CustomTitleText(title: "MOJI RECEPTI:"),
                    _buildUserRecipes(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildUserData() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (AuthProvider.korisnik?.ime != null)
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  children: [
                    const TextSpan(
                      text: 'Ime i prezime: ',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text:
                          '${AuthProvider.korisnik?.ime} ${AuthProvider.korisnik?.prezime}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 7),
            if (AuthProvider.korisnik?.email != null)
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  children: [
                    const TextSpan(
                      text: 'Email: ',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text: '${AuthProvider.korisnik?.email}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 7),
            if (AuthProvider.korisnik?.telefon != null)
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  children: [
                    const TextSpan(
                      text: 'Telefon: ',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text: '${AuthProvider.korisnik?.telefon}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserRecipes() {
    if (userRecipes.isEmpty) {
      return const Center(
        child: Text(
          'Nemate recepte.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return Column(
      children: userRecipes.map((recipe) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          padding: const EdgeInsets.all(5.0),
          color: const Color.fromARGB(187, 247, 246, 246),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: recipe.slika == null
                      ? const Placeholder()
                      : Image.memory(
                          base64Decode(recipe.slika!),
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(height: 10),
                Text(
                  recipe.naziv ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailsScreen(
                              recept: recipe,
                              fromScreen: "user",
                            ),
                          ),
                        ).then((value) {
                          _fetchUserRecipes();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text("Pregled recepta"),
                    ),
                    const SizedBox(width: 10),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        _deleteRecipe(recipe.receptId);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text("Obriši recept"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
