import 'dart:ui';

import 'package:erecipes_mobile/models/kategorija.dart';
import 'package:erecipes_mobile/models/omiljeni_recept.dart';
import 'package:erecipes_mobile/models/vrsta_jela.dart';
import 'package:erecipes_mobile/providers/auth_provider.dart';
import 'package:erecipes_mobile/providers/kategorija_provider.dart';
import 'package:erecipes_mobile/providers/omiljeni_recept_provider.dart';
import 'package:erecipes_mobile/providers/utils.dart';
import 'package:erecipes_mobile/providers/vrsta_jela_provider.dart';
import 'package:erecipes_mobile/screens/add_new_recipe_screen.dart';
import 'package:erecipes_mobile/screens/omiljeni_recepti_screen.dart';
import 'package:erecipes_mobile/screens/recipe_details_screen.dart';
import 'package:erecipes_mobile/widgets/custom_title_text.dart';
import 'package:erecipes_mobile/widgets/welcome_row.dart';
import 'package:flutter/material.dart';
import 'package:erecipes_mobile/models/recept.dart';
import 'package:erecipes_mobile/models/search_result.dart';
import 'package:erecipes_mobile/providers/recipe_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
  static const String routeName = "/recept";
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  RecipeProvider? _recipeProvider;
  VrstaJelaProvider? _vrstaJelaProvider;
  KategorijaProvider? _kategorijaProvider;
  OmiljeniReceptProvider? _omiljeniReceptProvider;
  SearchResult<Recept>? data;
  SearchResult<Kategorija>? kategorije;
  SearchResult<VrstaJela>? vrsteJela;
  TextEditingController _searchController = TextEditingController();
  dynamic _selectedFilter;
  List<Recept> listaRekomed = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData();
  }

  @override
  void initState() {
    super.initState();
    _recipeProvider = context.read<RecipeProvider>();
    _kategorijaProvider = context.read<KategorijaProvider>();
    _vrstaJelaProvider = context.read<VrstaJelaProvider>();
    _omiljeniReceptProvider = context.read<OmiljeniReceptProvider>();
    _selectedFilter = 'Svi';
    loadData();
  }

  Future toggleFavorite(Recept recept) async {
    var noviOmiljeniRecept = OmiljeniRecept();
    noviOmiljeniRecept.receptId = recept.receptId;
    bool isFavorite =
        await _omiljeniReceptProvider?.isFavorite(recept.receptId!) ?? false;

    if (isFavorite) {
      await _omiljeniReceptProvider?.removeFavorite(recept.receptId!);
      setState(() {
        recept.isFavorite = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Uklonili ste recept iz omiljenih.'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      await _omiljeniReceptProvider?.insert(noviOmiljeniRecept);
      setState(() {
        recept.isFavorite = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Dodali ste recept u omiljene.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future loadData({String query = ''}) async {
    var filter = {
      'FTS': query,
      'Status': true,
    };
    var tmpData = await _recipeProvider?.get();
    var tmpKategorije = await _kategorijaProvider?.get(filter: filter);
    var tmpVrsteJela = await _vrstaJelaProvider?.get(filter: filter);
    await loadRecommenedData();
    setState(() {
      data = tmpData!;
      kategorije = tmpKategorije!;
      vrsteJela = tmpVrsteJela!;
    });
  }

  Future loadRecommenedData() async {
    try {
      var lista =
          await _recipeProvider!.recommend(AuthProvider.korisnik!.korisnikId!);
      setState(() {
        listaRekomed = lista;
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Greška ${e.toString()}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "eRecipes",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: const Color.fromRGBO(1, 100, 34, 1),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await loadData(); 
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      WelcomeRow(), 
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildRecipeSearch(), 
              const SizedBox(height: 10),
              _buildCategoryAndDishTypeFilter(), 
              const SizedBox(height: 10),
              SizedBox(
                height: 400,
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.70,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 30,
                  ),
                  scrollDirection: Axis.vertical,
                  children: _buildRecipeCard(), 
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomTitleText(title: "Preporučeni recepti:"),
                ),
              ),
              const SizedBox(height: 10),

            _buildRecommenedrecipe()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryAndDishTypeFilter() {
    List<dynamic> combinedList = [];
    if (kategorije != null) combinedList.addAll(kategorije!.result);
    if (vrsteJela != null) combinedList.addAll(vrsteJela!.result);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () async {
              var tmpData = await _recipeProvider?.get();
              setState(() {
                _selectedFilter = 'Svi';
                data = tmpData!;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _selectedFilter == 'Svi'
                  ? Colors.grey[800]
                  : const Color.fromARGB(207, 243, 243, 243),
              foregroundColor:
                  _selectedFilter == 'Svi' ? Colors.white : Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
            ),
            child: const Text('Svi'),
          ),
          if (combinedList.isNotEmpty)
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: combinedList.map((item) {
                    bool isSelected = _selectedFilter == item;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _selectedFilter = item;
                          });
                          SearchResult<Recept>? newData;
                          if (kategorije?.result.contains(item) ?? false) {
                            newData = await _recipeProvider?.get(
                              filter: {
                                'KategorijaId': item.kategorijaId.toString()
                              },
                            );
                          } else if (vrsteJela?.result.contains(item) ??
                              false) {
                            newData = await _recipeProvider?.get(
                              filter: {
                                'VrstaJelaId': item.vrstaJelaId.toString()
                              },
                            );
                          }
                          setState(() {
                            data = newData;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSelected
                              ? Colors.grey[800]
                              : const Color.fromARGB(207, 243, 243, 243),
                          foregroundColor:
                              isSelected ? Colors.white : Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                        child: Text(item.naziv),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRecipeSearch() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                onChanged: (value) async {
                  var tmpData = await _recipeProvider
                      ?.get(filter: {'FTS': _searchController.text});
                  setState(() {
                    data = tmpData;
                  });
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const OmiljeniReceptiScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 242, 104, 150),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Icon(Icons.favorite, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddNewRecipeScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildRecipeCard() {
    if (data?.result.isEmpty ?? true) {
      return [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Loading...",
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ),
      ];
    }

    List<Widget>? list = data?.result
            .map((x) => Container(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 120,
                          width: double.infinity,
                          child: x.slika == null
                              ? const Placeholder()
                              : imageFromString(x.slika!),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                x.naziv ?? "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            FutureBuilder(
                              future: _omiljeniReceptProvider
                                  ?.isFavorite(x.receptId!),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Icon(Icons.favorite_border,
                                      color: Colors.red, size: 30);
                                }
                                if (snapshot.hasData) {
                                  bool isFavorite = snapshot.data!;
                                  return IconButton(
                                    onPressed: () {
                                      toggleFavorite(x);
                                    },
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                    padding: const EdgeInsets.all(0),
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                  );
                                } else {
                                  return const Icon(Icons.favorite_border,
                                      color: Colors.red, size: 30);
                                }
                              },
                            ),
                          ],
                        ),
                        Text(
                          (x.opisRecepta ?? "").length > 50
                              ? (x.opisRecepta?.substring(0, 50) ?? "") + "..."
                              : (x.opisRecepta ?? ""),
                          style: const TextStyle(color: Colors.grey),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RecipeDetailsScreen(recept: x)),
                            ).then((value) {
                              loadData();
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
                        const SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                ))
            .toList() ??
        [];
    return list;
  }

  Widget _buildRecommenedrecipe() {
    if (listaRekomed.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            "Loading...",
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ),
      );
    }

    return SizedBox(
      height: 300, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listaRekomed.length,
        itemBuilder: (context, index) {
          var x = listaRekomed[index];
          return Container(
            width: 180,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(

              color: const Color.fromARGB(155, 223, 253, 217),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: x.slika == null
                      ? const Placeholder()
                      : imageFromString(x.slika!),
                ),
                const SizedBox(height: 8.0),
                Text(
                  x.naziv ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  (x.opisRecepta ?? "").length > 50
                      ? "${x.opisRecepta?.substring(0, 50)}..."
                      : (x.opisRecepta ?? ""),
                  style: const TextStyle(color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailsScreen(recept: x),
                      ),
                    ).then((value) {
                      loadData();
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
              ],
            ),
          );
        },
      ),
    );
  }
}
