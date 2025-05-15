import 'dart:convert';

import 'package:erecipes_desktop/models/korisnik.dart';
import 'package:erecipes_desktop/providers/base_provider.dart';

class KorisnikProvider extends BaseProvider<Korisnik> {
  KorisnikProvider() : super("Korisnik");

  @override
  Korisnik fromJson(data) {
    return Korisnik.FromJson(data);
  }

  Future<Korisnik> Authenticate() async {
    var url = "$fullUrl/Authenticate";
    var uri = Uri.parse(url);

    var headers = getHeaders();
    var response = await http!.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      Korisnik user = fromJson(data) as Korisnik;
      notifyListeners();
      return user;
    } else {
      throw Exception("Wrong username or password");
    }
  }

  Future<void> deleteKorisnik(int? id) async {
    var url = "$fullUrl/$id/DeleteKorisnik";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.put(uri, headers: headers);

    if (isValidResponse(response)) {
      print("Korisnik obrisan.");
    } else {
      throw Exception("Neuspješno brisanje korisnika.");
    }
  }

  Future<void> resetPassword(int? id) async {
    var url = "$fullUrl/$id/ResetPassword";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.post(uri, headers: headers);

    if (isValidResponse(response)) {
      print("Lozinka promjenjena.");
    } else {
      throw Exception("Neuspješno mijenjanje lozinke.");
    }
  }

  Future<Korisnik> updateMobile(int id, Map<String, dynamic> request) async {
    var url = "$fullUrl/$id/UpdateMobile";
    var uri = Uri.parse(url);
    var headers = getHeaders();
    var jsonRequest = jsonEncode(request);

    try {
      var response = await http!.put(uri, headers: headers, body: jsonRequest);
      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);
        Korisnik updatedUser = fromJson(data);
        return updatedUser;
      } else {
        throw Exception("Failed to update mobile: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to update mobile: $e");
    }
  }
}
