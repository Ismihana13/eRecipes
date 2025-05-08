import 'dart:convert';
import 'package:erecipes_desktop/models/katalog.dart';
import 'package:erecipes_desktop/models/katalog_recept.dart';
import 'package:erecipes_desktop/providers/base_provider.dart';

class KatalogProvider extends BaseProvider<Katalog> {
  KatalogProvider() : super("Katalog");

  @override
  fromJson(data) {
    return Katalog.FromJson(data);
  }

  Future<String> addReceptToKatalog(int? katalogId, List<int?> recepti) async {
    print("Pocetak slanja recepata u katalog: $katalogId");

    var url = "$fullUrl/$katalogId/recepti";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    print("Telo zahteva za slanje: ${jsonEncode(recepti)}");

    final response = await http!.post(
      uri,
      headers: headers,
      body: jsonEncode(recepti),
    );

    if (response.statusCode == 200) {
      print("Uspešno dodavanje recepata u katalog");
      return "Recepti su uspješno dodani!";
    } else {
      print("Greška prilikom slanja recepata: ${response.body}");
      return "Došlo je do greške: ${response.body}";
    }
  }

  Future<List<KatalogRecept>> recepti(int? id) async {
    var url = "$fullUrl/$id/with-recepti";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (isValidResponse(response)) {
      final data = jsonDecode(response.body);
      final katalog = Katalog.FromJson(data);
      return katalog.katalogRecepts ?? [];
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
