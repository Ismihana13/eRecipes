// ignore_for_file: must_be_immutable

import 'package:erecipes_mobile/models/lajkovi.dart';
import 'package:erecipes_mobile/models/omiljeni_recept.dart';
import 'package:erecipes_mobile/models/recept.dart';
import 'package:erecipes_mobile/providers/lajkovi_provider.dart';
import 'package:erecipes_mobile/providers/omiljeni_recept_provider.dart';
import 'package:erecipes_mobile/providers/recipe_provider.dart';
import 'package:erecipes_mobile/providers/utils.dart';
import 'package:erecipes_mobile/screens/edit_recipe_screen.dart';
import 'package:erecipes_mobile/screens/sastojcli_list.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:erecipes_mobile/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RecipeDetailsScreen extends StatefulWidget {
  static const String routeName = "/recipeDetails";
  Recept? recept;
  final String? fromScreen;
  RecipeDetailsScreen({super.key, this.recept, this.fromScreen});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  var sastojciList;
  late RecipeProvider recipeProvider;
  OmiljeniReceptProvider? _omiljeniReceptProvider;
  bool isLoading = true;
  int likesCount = 0;
  bool isliked = false;
  LajkoviProvider? _lajkoviProvider;
  bool showLikesSection = true;
  bool showButton = false;
  var sastojci;
  Recept? _recept;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _recept = widget.recept;
    recipeProvider = context.read<RecipeProvider>();
    _omiljeniReceptProvider = context.read<OmiljeniReceptProvider>();
    _lajkoviProvider = context.read<LajkoviProvider>();
    if (widget.fromScreen == 'user') {
      setState(() {
        showLikesSection = false;
        showButton = true;
      });
    }
    _getLikesCount();
    _checkIfLiked();
    recipeProvider.sastojci(_recept!.receptId).then((result) {
      setState(() {
        sastojciList = result;
      });
    });
  }

  Future<void> loadRecipe() async {
    var noviRecept = await recipeProvider.getById(_recept!.receptId);
    setState(() {
      _recept = noviRecept;
    });
  }

  Future<void> loadSastojci() async {
    recipeProvider = context.read<RecipeProvider>();
    _omiljeniReceptProvider = context.read<OmiljeniReceptProvider>();
    _lajkoviProvider = context.read<LajkoviProvider>();
    if (widget.fromScreen == 'user') {
      setState(() {
        showLikesSection = false;
        showButton = true;
      });
    }
    _getLikesCount();
    _checkIfLiked();
    recipeProvider.sastojci(_recept!.receptId).then((result) {
      setState(() {
        sastojciList = result;
      });
    });
  }

  Future<void> _checkIfLiked() async {
    bool liked = await _lajkoviProvider!.isLiked(_recept!.receptId);
    setState(() {
      isliked = liked;
    });
  }

  Future<int> _getLikesCount() async {
    int count =
        await LajkoviProvider().getLikesCountForRecipe(_recept?.receptId);
    return likesCount = count;
  }

  void _toggleFavorite(Recept recept) async {
    var noviOmiljeniRecept = OmiljeniRecept();
    noviOmiljeniRecept.receptId = recept.receptId;
    bool isFavorite =
        await _omiljeniReceptProvider?.isFavorite(recept.receptId!) ?? false;
    if (isFavorite) {
      await _omiljeniReceptProvider?.removeFavorite(recept.receptId!);
      CustomSnackBar.showErrorSnackBar(
          context, 'Uklonili ste recept iz omiljenih.');
    } else {
      await _omiljeniReceptProvider?.insert(noviOmiljeniRecept);
      CustomSnackBar.showSuccessSnackBar(
          context, 'Dodali ste recept u omiljene.');
    }
    setState(() {});
  }

  void handleLike() async {
    bool isLiked = await _lajkoviProvider!.isLiked(_recept!.receptId);
    if (isLiked) {
      await _lajkoviProvider!.removeLike(_recept!.receptId);
      setState(() {
        isliked = false;
        likesCount--;
      });
      CustomSnackBar.showErrorSnackBar(
          context, 'Uklonili ste recept iz lajkovanih.');
    } else {
      Lajkovi newLajk = Lajkovi(receptId: _recept!.receptId);
      await _lajkoviProvider!.insert(newLajk);
      setState(() {
        isliked = true;
        likesCount++;
      });
      CustomSnackBar.showSuccessSnackBar(context, 'Lajkali ste recept');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(naslov: 'eRecipes'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 5),
            _buildRecipeDetails(),
            if (showButton)
              ElevatedButton(
                onPressed: () async {
                  loadRecipe();
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditRecipeScreen(
                        recept: _recept!,
                        sastojci: sastojciList,
                      ),
                    ),
                  );
                  if (result != null) {
                    loadRecipe();
                    loadSastojci();
                    setState(() {});
                  }
                },
                child: const Text('Uredi recept'),
              ),
            if (showLikesSection)
              FutureBuilder<bool>(
                future: _lajkoviProvider?.isLiked(_recept!.receptId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasData && snapshot.data!) {
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Expanded(
                              child: Text(
                                'Ukoliko vam se svidio recept, ostavite like',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap: true,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.thumb_up,
                                  color: Colors.blue),
                              onPressed: () => handleLike(),
                            ),
                            Text(
                              '$likesCount',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Expanded(
                              child: Text(
                                'Ukoliko vam se svidio recept, ostavite like',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap: true,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.thumb_up_outlined,
                                  color: Colors.grey),
                              onPressed: () => handleLike(),
                            ),
                            Text(
                              '$likesCount',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeDetails() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 250,
            child: _recept!.slika == null
                ? const Placeholder()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: imageFromStringDetails(_recept!.slika!),
                  ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _recept?.naziv ?? 'Naziv recepta nije dostupan',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    if (_recept?.vrijemePripreme != null) ...[
                      const Icon(Icons.access_time,
                          color: Colors.black, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        '${_recept?.vrijemePripreme} min',
                        style: const TextStyle(
                            fontSize: 16, fontStyle: FontStyle.italic),
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(width: 8),
                    FutureBuilder<bool>(
                      future: _omiljeniReceptProvider
                          ?.isFavorite(_recept!.receptId!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.hasData && snapshot.data!) {
                          return IconButton(
                            icon: const Icon(Icons.favorite, color: Colors.red),
                            iconSize: 35,
                            onPressed: () => _toggleFavorite(_recept!),
                          );
                        } else {
                          return IconButton(
                            icon: const Icon(Icons.favorite_border,
                                color: Colors.red),
                            iconSize: 35,
                            onPressed: () => _toggleFavorite(_recept!),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              _recept?.opisRecepta ?? 'Opis recepta nije dostupan',
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 92, 92, 92),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SastojciListCard(
            sastojciList: sastojciList ?? [],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Način pripreme:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _recept?.opisPripreme ?? 'Način pripreme nije dostupan',
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Autor recepta: ${_recept!.korisnik?.korisnickoIme ?? 'Nepoznat korisnik'}',
                  style: const TextStyle(
                      fontSize: 16, fontStyle: FontStyle.italic),
                ),
                Text(
                  _recept?.datumObjave != null
                      ? DateFormat('dd.MM.yyyy.').format(_recept!.datumObjave!)
                      : 'Datum nije dostupan',
                  style: const TextStyle(
                      fontSize: 16, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
