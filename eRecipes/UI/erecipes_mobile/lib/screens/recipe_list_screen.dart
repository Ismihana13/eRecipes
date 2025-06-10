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
import 'package:erecipes_mobile/screens/locked_recipe.dart';
import 'package:erecipes_mobile/screens/mood_tracker_screen.dart';
import 'package:erecipes_mobile/screens/omiljeni_recepti_screen.dart';
import 'package:erecipes_mobile/screens/recipe_details_screen.dart';
import 'package:erecipes_mobile/screens/rezervacija_prostora_screen.dart';
import 'package:erecipes_mobile/screens/user_screen.dart';
import 'package:erecipes_mobile/widgets/custom_snack_bar.dart';
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
  bool isEmpty = false;
  int _selectedIndex = 0;
  bool _showRecommended = true;

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
      CustomSnackBar.showErrorSnackBar(
          context, 'Uklonili ste recept iz omiljenih.');
    } else {
      await _omiljeniReceptProvider?.insert(noviOmiljeniRecept);
      setState(() {
        recept.isFavorite = true;
      });
      CustomSnackBar.showSuccessSnackBar(
          context, 'Dodali ste recept u omiljene.');
    }
  }

  Future loadData({String query = ''}) async {
    var filter = {
      'FTS': query,
      'Status': true,
    };
    var tmpData = await _recipeProvider?.get(filter: filter);
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

  final List<Widget> _screens = [
    const RecipeListScreen(),
    const AddNewRecipeScreen(),
    const UserScreen(),
  ];

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
      body: _selectedIndex == 0
          ? RefreshIndicator(
              onRefresh: () async {
                await loadData();
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        _buildRecipeSearch(),
                        _buildCategoryAndDishTypeFilter(),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RezervacijaProstoraScreen(),
                                ),
                              );
                            },
                            child: const Text("Rezervisi")),
                            ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const MoodTrackerScreen(),
                                ),
                              );
                            },
                            child: const Text("MoodTracker")),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Preporučeni recepti:",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xCC0D3E09),
                            ),
                          ),
                        ),
                        if (listaRekomed.isNotEmpty && _showRecommended) ...[
                          const SizedBox(height: 10),
                          _buildRecommenedrecipe(),
                        ],
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(150, 25),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  _showRecommended = !_showRecommended;
                                });
                              },
                              child: _showRecommended
                                  ? const Icon(Icons.arrow_upward,
                                      color: Colors.red)
                                  : const Icon(Icons.arrow_downward,
                                      color: Color.fromARGB(255, 63, 152, 55)),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Ostali recepti:",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xCC0D3E09),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    sliver: SliverGrid(
                      delegate: SliverChildListDelegate(
                        _buildRecipeCard(),
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.70,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 30,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 20),
                  ),
                ],
              ),
            )
          : _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.receipt_rounded),
            label: 'Recepti',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 71, 125, 73),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
            label: 'Dodaj',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_2),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/addNewRecipe');
          } else {
            setState(() {
              loadData();
              _selectedIndex = index;
            });
          }
        },
      ),
    );
  }

  Widget _buildCategoryAndDishTypeFilter() {
    List<dynamic> combinedList = [];
    if (kategorije != null) combinedList.addAll(kategorije!.result);
    if (vrsteJela != null) combinedList.addAll(vrsteJela!.result);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  var tmpData = await _recipeProvider?.get(
                      filter: {'Status': true, 'FTS': _searchController.text});
                  setState(() {
                    _selectedFilter = 'Svi';
                    data = tmpData!;
                    isEmpty = data?.result.isEmpty ?? true;
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
                                isEmpty = data?.result.isEmpty ?? true;
                              });
                              SearchResult<Recept>? newData;
                              if (kategorije?.result.contains(item) ?? false) {
                                newData = await _recipeProvider?.get(
                                  filter: {
                                    'KategorijaId':
                                        item.kategorijaId.toString(),
                                    'FTS': _searchController.text,
                                    'Status': true
                                  },
                                );
                              } else if (vrsteJela?.result.contains(item) ??
                                  false) {
                                newData = await _recipeProvider?.get(
                                  filter: {
                                    'VrstaJelaId': item.vrstaJelaId.toString(),
                                    'FTS': _searchController.text,
                                    'Status': true
                                  },
                                );
                              }
                              setState(() {
                                data = newData;
                                isEmpty = data?.result.isEmpty ?? true;
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
        ],
      ),
    );
  }

  Widget _buildRecipeSearch() {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: SizedBox(
                height: 40,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search recipes by name and description",
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  onChanged: (value) async {
                    var filter = {
                      'FTS': _searchController.text,
                      'Status': true,
                    };
                    if (_selectedFilter != null) {
                      if (kategorije?.result.contains(_selectedFilter) ??
                          false) {
                        filter['KategorijaId'] =
                            _selectedFilter.kategorijaId.toString();
                      } else if (vrsteJela?.result.contains(_selectedFilter) ??
                          false) {
                        filter['VrstaJelaId'] =
                            _selectedFilter.vrstaJelaId.toString();
                      }
                    }

                    var tmpData = await _recipeProvider?.get(filter: filter);
                    setState(() {
                      data = tmpData;
                      isEmpty = data?.result.isEmpty ?? true;
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
                ).then((_) {
                  loadData();
                });
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
        ],
      ),
    );
  }

  List<Widget> _buildRecipeCard() {
    if (isEmpty == true) {
      return [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Nema recepata...",
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ),
      ];
    }
    if (data?.result.isEmpty ?? true) {
      return [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ];
    }

    bool isPremiumUser = AuthProvider.korisnik!.uloga!.ulogaId == 3;
    return data!.result.map((x) {
      bool isPremiumRecipe = x.premium ?? false;
      bool isLocked = !isPremiumUser && isPremiumRecipe;

      return GestureDetector(
        onTap: () {
          if (isLocked) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const LockedRecipeScreen()),
            ).then((azuriraniKorisnik) {
              if (azuriraniKorisnik != null) {
                setState(() {
                  AuthProvider.korisnik = azuriraniKorisnik;
                });
              }
            });
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RecipeDetailsScreen(recept: x)),
            ).then((_) => loadData());
          }
        },
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: isLocked ? Colors.grey.withOpacity(0.2) : Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: x.slika == null
                        ? const Placeholder()
                        : imageFromString(x.slika!),
                  ),
                  const SizedBox(height: 8),
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
                      FutureBuilder<bool>(
                        future:
                            _omiljeniReceptProvider?.isFavorite(x.receptId!),
                        builder: (context, snapshot) {
                          bool isFavorite = snapshot.data ?? false;
                          return IconButton(
                            onPressed:
                                isLocked ? null : () => toggleFavorite(x),
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                              size: 30,
                            ),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    (x.opisRecepta ?? "").length > 50
                        ? "${x.opisRecepta?.substring(0, 50)}..."
                        : (x.opisRecepta ?? ""),
                    style: const TextStyle(color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isLocked
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RecipeDetailsScreen(recept: x),
                                ),
                              ).then((_) => loadData());
                            },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: isLocked ? Colors.grey : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text("Pregledaj recept"),
                    ),
                  ),
                ],
              ),
            ),
            if (isLocked)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
          ],
        ),
      );
    }).toList();
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
    var filteredRecipes =
        listaRekomed.where((recipe) => recipe.status == true).toList();
    if (filteredRecipes.isEmpty) {
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
    bool isPremiumUser = AuthProvider.korisnik!.uloga!.ulogaId == 3;

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filteredRecipes.length,
        itemBuilder: (context, index) {
          var x = filteredRecipes[index];
          bool isPremiumRecipe = x.premium ?? false;
          bool isLocked = !isPremiumUser && isPremiumRecipe;

          return GestureDetector(
            onTap: () {
              if (isLocked) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LockedRecipeScreen()),
                ).then((azuriraniKorisnik) {
                  if (azuriraniKorisnik != null) {
                    setState(() {
                      AuthProvider.korisnik = azuriraniKorisnik;
                    });
                  }
                });
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecipeDetailsScreen(recept: x)),
                ).then((_) => loadData());
              }
            },
            child: Container(
              width: 160,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 205, 205, 205), width: 2),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12)),
                              child: x.slika == null
                                  ? const Placeholder()
                                  : imageFromString(x.slika!),
                            ),
                          ),
                          if (isLocked)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Icon(Icons.lock,
                                    color: Colors.white, size: 40),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      x.naziv ?? '',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      x.opisPripreme ?? '',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (isLocked) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const LockedRecipeScreen(),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RecipeDetailsScreen(recept: x),
                              ),
                            );
                          }
                        },
                        child: const Text('Pregledaj'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
