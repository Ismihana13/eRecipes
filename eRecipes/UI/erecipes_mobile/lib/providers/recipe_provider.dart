import 'dart:convert';

import 'package:erecipes_mobile/models/recept.dart';
import 'package:erecipes_mobile/models/recept_sastojak.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

class RecipeProvider extends BaseProvider<Recept>{

  RecipeProvider():super("Recept");
  
 @override
  fromJson(data) {
    return Recept.FromJson(data);
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
  Future<void> activateRecipe(int id) async {
  var url = "$fullUrl/$id/activate";
  var uri = Uri.parse(url);
  var headers = createHeaders();

  var response = await http!.put(uri, headers: headers); 

  if (!isValidResponse(response)) {
    throw Exception('Failed to activate recipe');
  }
}
Future<String> addSastojkeToRecept(int receptId, List<int> sastojakIds) async {
  var url = "$fullUrl/$receptId/sastojci";
  var uri = Uri.parse(url);
  var headers = createHeaders();
    final response = await http!.post(
      uri,
      headers:headers,
      body: jsonEncode(sastojakIds),
    );
    if (response.statusCode == 200) {
      return "Sastojci su uspješno dodani!";
    } else {
      return "Došlo je do greške: ${response.body}";
    }
  }
  Future<List<Recept>> getReceptiByKorisnikId(int id) async {
    var url = "$fullUrl/$id/recepti";  
    var uri = Uri.parse(url);
    var headers = createHeaders();
    
    final response = await http!.get(uri, headers: headers);  

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Recept.FromJson(item)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

    Future<Recept> deleteRecept(int? id) async {
    var url = "$fullUrl/$id/BrisanjeRecepta";
    var uri = Uri.parse(url);

    var headers = getHeaders();
    var response = await http!.delete(uri, headers: headers); 
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      Recept recipe = fromJson(data) as Recept;
      return recipe;
    } else {
      throw Exception("Failed to delete recipe");
    }
  }
}