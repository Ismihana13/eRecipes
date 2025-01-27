import 'dart:convert';
import 'package:erecipes_mobile/models/lajkovi.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

class LajkoviProvider extends BaseProvider<Lajkovi> {
  LajkoviProvider() : super("Lajkovi");

  @override
  fromJson(data) {
    return Lajkovi.FromJson(data);
  }

  Future<int> getLikesCountForRecipe(int? receptId) async {
    var url = "$fullUrl/$receptId/likesCount";
    var uri = Uri.parse(url);
    var headers = getHeaders();

    try {
      var response = await http!.get(uri, headers: headers);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to get likes count');
      }
    } catch (e) {
      throw Exception('Failed to get likes count: $e');
    }
  }

  Future<void> removeLike(int? receptId) async {
    var url = "$fullUrl/$receptId/removeLike";
    var uri = Uri.parse(url);
    var headers = getHeaders();

    try {
      var response = await http!.delete(uri, headers: headers);

      if (response.statusCode != 200) {
        throw Exception('Failed to remove favorite');
      }
    } catch (e) {
      throw Exception('Failed to remove favorite: $e');
    }
  }

  Future<bool> isLiked(int? receptId) async {
    var url = "$fullUrl/isLiked/$receptId";
    var uri = Uri.parse(url);
    var headers = getHeaders();
    try {
      var response = await http!.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Greška pri proveri da li je recept lajkovan: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Greška pri slanju zahteva: $e');
    }
  }
}
