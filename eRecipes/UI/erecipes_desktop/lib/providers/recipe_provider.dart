import 'dart:convert';
import 'package:erecipes_desktop/models/recept.dart';
import 'package:erecipes_desktop/models/recept_sastojak.dart';
import 'package:erecipes_desktop/providers/base_provider.dart';

class RecipeProvider extends BaseProvider<Recept> {
  RecipeProvider() : super("Recept");

  @override
  fromJson(data) {
    return Recept.FromJson(data);
  }

  Future<void> deleteRecept(int? id) async {
    var url = "$fullUrl/$id/DeleteRecept";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http!.put(uri, headers: headers);
    if (isValidResponse(response)) {
      print("Recept obrisan.");
    } else {
      throw Exception("Neuspješno brisanje recepta.");
    }
  }

  Future<List<ReceptSastojak>> sastojci(int? id) async {
    var url = "$fullUrl/$id/sastojci";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (isValidResponse(response)) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => ReceptSastojak.FromJson(item)).toList();
    } else {
      throw Exception('Failed to load ingredients');
    }
  }
}
