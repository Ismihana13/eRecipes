import 'dart:convert';
import 'package:erecipes_mobile/models/kategorija.dart';
import 'package:erecipes_mobile/models/omiljeni_recept.dart';
import 'package:erecipes_mobile/models/search_result.dart';
import 'package:erecipes_mobile/models/vrsta_jela.dart';
import 'package:erecipes_mobile/providers/kategorija_provider.dart';
import 'package:erecipes_mobile/providers/omiljeni_recept_provider.dart';
import 'package:erecipes_mobile/providers/vrsta_jela_provider.dart';
import 'package:erecipes_mobile/screens/add_new_recipe_screen.dart';
import 'package:erecipes_mobile/screens/recipe_details_screen.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:erecipes_mobile/widgets/welcome_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class OmiljeniReceptiScreen extends StatefulWidget {
  static const String routeName = "/omiljeniRecept";

  const OmiljeniReceptiScreen({Key? key}) : super(key: key);

  @override
  State<OmiljeniReceptiScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<OmiljeniReceptiScreen> {
  VrstaJelaProvider? _vrstaJelaProvider = null;
  KategorijaProvider? _kategorijaProvider = null;
  OmiljeniReceptProvider? _omiljeniReceptProvider = null;
  List<OmiljeniRecept>? data;
  SearchResult<Kategorija>? kategorije;
  SearchResult<VrstaJela>? vrsteJela;
  TextEditingController _searchController = TextEditingController();
  dynamic _selectedFilter;

  @override
  void initState() {
    super.initState();
    _omiljeniReceptProvider = context.read<OmiljeniReceptProvider>();
    _kategorijaProvider = context.read<KategorijaProvider>();
    _vrstaJelaProvider = context.read<VrstaJelaProvider>();
    _selectedFilter = 'Svi';
    loadData();
  }

  loadData({String query = ''}) async {
    try {
      var filter = {
        'FTS': query,
        'Status': true,
      };
      var tmpData = await _omiljeniReceptProvider?.getFavoritesForCurrentUser(
          filter: filter);
      var tmpKategorije = await _kategorijaProvider?.get(filter: filter);
      var tmpVrsteJela = await _vrstaJelaProvider?.get(filter: filter);

      setState(() {
        data = tmpData! as List<OmiljeniRecept>?;
        kategorije = tmpKategorije!;
        vrsteJela = tmpVrsteJela!;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        data = null;
        kategorije = null;
        vrsteJela = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(naslov: 'eRecipes'),
      body: SingleChildScrollView(
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
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Nazad")),
            const Text(
              'Omiljeni Recepti',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 500,
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 8 / 4,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                ),
                scrollDirection: Axis.vertical,
                children: _buildRecipeCard(),
              ),
            ),
          ],
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
            onPressed: () {
              setState(() {
                _selectedFilter = 'Svi';
                loadData();
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
                          List<OmiljeniRecept>? newData;
                          if (kategorije?.result.contains(item) ?? false) {
                            newData = await _omiljeniReceptProvider
                                ?.getFavoritesForCurrentUser(
                              filter: {
                                'KategorijaId': item.kategorijaId.toString()
                              },
                            );
                          } else if (vrsteJela?.result.contains(item) ??
                              false) {
                            newData = await _omiljeniReceptProvider
                                ?.getFavoritesForCurrentUser(
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
                onChanged: (value) {
                  loadData(query: value);
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
                    builder: (context) => OmiljeniReceptiScreen()),
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
    if (data?.isEmpty ?? true) {
      return [
        const Center(
          child: Text(
            "Nema omiljenih recepata.",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
      ];
    }
    return data!
        .map((x) => Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              padding: const EdgeInsets.all(5.0),
              color: const Color.fromARGB(187, 247, 246, 246),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 150,
                      child: x.recept!.slika == null
                          ? const Placeholder()
                          : Image.memory(base64Decode(x.recept!.slika!),
                              fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            x.recept!.naziv ?? "",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            x.recept!.opisRecepta ?? "Nema opisa.",
                            style: const TextStyle(color: Colors.grey),
                            maxLines: 2, 
                            overflow: TextOverflow
                                .ellipsis, 
                          ),
                          const SizedBox(height: 6),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RecipeDetailsScreen(recept: x.recept)),
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
                    ),
                  ],
                ),
              ),
            ))
        .toList();
  }
}

String _getFirstSentence(String text) {
  if (text.isEmpty) return "Nema opisa."; // Ako je opis prazan

  RegExp regex = RegExp(r'([^.?!]+[.?!])'); // Traži prvu rečenicu
  Match? match = regex.firstMatch(text);

  return match?.group(0)?.trim() ??
      text; // Ako nema tačke, prikaži cijeli tekst
}
