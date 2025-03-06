import 'dart:convert';

import 'package:erecipes_mobile/models/omiljeni_recept.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

class OmiljeniReceptProvider extends BaseProvider<OmiljeniRecept> {
  OmiljeniReceptProvider() : super("OmiljeniRecept");

  @override
  fromJson(data) {
    return OmiljeniRecept.FromJson(data);
  }

  Future<List<OmiljeniRecept>> getFavoritesForCurrentUser(
      {dynamic filter}) async {
    var url = "$fullUrl/getOmiljeniRecepti";
    if (filter != null && filter.isNotEmpty) {
      var queryString = getQueryString(filter);
      url = "$url?$queryString";
    }
    var uri = Uri.parse(url);

    var headers = getHeaders();
    var response = await http!.get(uri, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => OmiljeniRecept.FromJson(item)).toList();
    } else {
      throw Exception('Failed to load favorite recipes');
    }
  }

  Future<void> removeFavorite(int receptId) async {
    var url = "$fullUrl/removeFavorite/$receptId";
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

  Future<bool> isFavorite(int receptId) async {
    try {
      var favorites = await getFavoritesForCurrentUser();
      return favorites.any((favorite) => favorite.receptId == receptId);
    } catch (e) {
      return false;
    }
  }
}
