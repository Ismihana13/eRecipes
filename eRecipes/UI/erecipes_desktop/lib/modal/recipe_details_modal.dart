import 'package:erecipes_desktop/models/kategorija.dart';
import 'package:erecipes_desktop/models/recept.dart';
import 'package:erecipes_desktop/models/search_result.dart';
import 'package:erecipes_desktop/models/vrsta_jela.dart';
import 'package:erecipes_desktop/providers/kategorija_provider.dart';
import 'package:erecipes_desktop/providers/recipe_provider.dart';
import 'package:erecipes_desktop/providers/utils.dart';
import 'package:erecipes_desktop/providers/vrsta_jela_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeDetailsModal extends StatefulWidget {
  Recept? recept;
  RecipeDetailsModal({super.key, this.recept});

  @override
  _RecipeDetailsModalState createState() => _RecipeDetailsModalState();
}

class _RecipeDetailsModalState extends State<RecipeDetailsModal> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController preparationTimeController =
      TextEditingController();
  final TextEditingController dateofPublicationController =
      TextEditingController();

  late Recept? _recept;
  var sastojciList;
  late RecipeProvider recipeProvider;
  late KategorijaProvider kategorijaProvider;
  late VrstaJelaProvider vrstaJelaProvider;
  SearchResult<VrstaJela>? vrstaJelaResult = null;
  SearchResult<Kategorija>? kategorijaResult = null;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    recipeProvider = context.read<RecipeProvider>();
    kategorijaProvider = context.read<KategorijaProvider>();
    vrstaJelaProvider = context.read<VrstaJelaProvider>();
    super.initState();
    _recept = widget.recept;
    nameController.text = _recept!.naziv ?? '';
    descriptionController.text = _recept!.opisRecepta ?? '';
    preparationTimeController.text =
        ("${_recept?.vrijemePripreme?.toString()}min");
    dateofPublicationController.text = (formatDate(_recept?.datumObjave));
    recipeProvider.sastojci(_recept!.receptId).then((result) {
      setState(() {
        sastojciList = result;
      });
    });
    initForm();
  }

  Future initForm() async {
    vrstaJelaResult = await vrstaJelaProvider.get();
    kategorijaResult = await kategorijaProvider.get();
    setState(() {
      isLoading = false;
    });
  }

  _buildSastojciList() {
    if (sastojciList == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (sastojciList.isEmpty) {
      return const Text('No ingredients available.');
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: sastojciList.length,
      itemBuilder: (context, index) {
        var sastojak = sastojciList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  sastojak.sastojak?.naziv ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 19, 51, 34),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String value,
      {TextStyle? titleStyle, TextStyle? valueStyle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle ??
                const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
          ),
          Text(
            value,
            style: valueStyle ??
                const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: const Color.fromRGBO(247, 249, 253, 1),
          width: MediaQuery.of(context).size.width * 0.3,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Detalji recepta',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                      child: _recept!.slika != null
                          ? SizedBox(
                              width: 250,
                              height: 200,
                              child: imageFromString(_recept!.slika!),
                            )
                          : const Text("")),
                  _buildDetailRow(
                    'Naziv recepta',
                    _recept?.naziv ?? 'N/A',
                    valueStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 19, 51, 34),
                    ),
                  ),
                  _buildDetailRow(
                    'Vrijeme pripreme',
                    _recept?.vrijemePripreme != null
                        ? "${_recept?.vrijemePripreme} min"
                        : 'N/A',
                    valueStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  _buildDetailRow(
                    'Opis',
                    _recept?.opisRecepta ?? 'N/A',
                    valueStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 19, 51, 34),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Sastojci:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  _buildSastojciList(),
                  _buildDetailRow(
                    'Opis pripreme',
                    _recept?.opisPripreme ?? 'N/A',
                    valueStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 19, 51, 34),
                    ),
                  ),
                  _buildDetailRow(
                    'Vrsta jela',
                    vrstaJelaResult?.result
                            .firstWhere(
                              (item) =>
                                  item.vrstaJelaId == _recept?.vrstaJelaId,
                            )
                            .naziv ??
                        'Nepoznato',
                    valueStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 19, 51, 34),
                    ),
                  ),
                  _buildDetailRow(
                    'Kategorija',
                    kategorijaResult?.result
                            .firstWhere(
                              (item) =>
                                  item.kategorijaId == _recept?.kategorijaId,
                            )
                            .naziv ??
                        'Nepoznato',
                    valueStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 19, 51, 34),
                    ),
                  ),
                  _buildDetailRow(
                    'Datum objave',
                    _recept?.datumObjave != null
                        ? formatDate(_recept!.datumObjave!)
                        : 'N/A',
                    valueStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
}
