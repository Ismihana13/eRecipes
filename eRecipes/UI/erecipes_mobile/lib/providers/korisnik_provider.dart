

import 'dart:convert';

import 'package:erecipes_mobile/models/korisnik.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

class KorisnikProvider extends BaseProvider<Korisnik> {
  KorisnikProvider() : super("Korisnik");
Korisnik? _korisnik;
  @override
  Korisnik fromJson(data) {
    return Korisnik.FromJson(data);
    
  }
  Korisnik? get korisnik => _korisnik;
  Future<Korisnik> Authenticate() async {
    var url = "$fullUrl/Authenticate";
    var uri = Uri.parse(url);

    var headers = getHeaders();
    var response = await http!.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      Korisnik user = fromJson(data) as Korisnik;
      return user;
    } else {
      throw Exception("Wrong username or password");
    }
  }
   Future<Korisnik> updateMobile(int id, Map<String, dynamic> request) async {
    var url = "$fullUrl/$id/UpdateMobile";
    var uri = Uri.parse(url);
    var headers = getHeaders();
    var jsonRequest = jsonEncode(request);

    try {
      var response = await http!.put(uri, headers: headers, body: jsonRequest);

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);
        Korisnik updatedUser = fromJson(data) as Korisnik;
        return updatedUser;
      } else {
        throw Exception("Failed to update mobile: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to update mobile: $e");
    }
  }
    Future<Korisnik> deleteKorisnikPorfil(int id) async {
    var url = "$fullUrl/$id/DeleteKorisnikProfil";
    var uri = Uri.parse(url);

    var headers = getHeaders();
    var response = await http!.delete(uri, headers: headers); 
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      Korisnik user = fromJson(data) as Korisnik;
      return user;
    } else {
      throw Exception("Failed to delete user profile");
    }
  }

}