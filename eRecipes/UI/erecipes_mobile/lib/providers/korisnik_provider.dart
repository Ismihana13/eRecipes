import 'dart:convert';

import 'package:erecipes_mobile/models/korisnik.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

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
      Korisnik user = fromJson(data);
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

  Future<Korisnik> updateUserRole(int? id, int role) async {
    if (id == null) {
      throw Exception("ID korisnika ne može biti null");
    }

    var url = "$fullUrl/$id/uloga";
    var uri = Uri.parse(url);
    var headers = getHeaders();
    var body = jsonEncode(role);
    try {
      var response = await http!.put(uri, headers: headers, body: body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var data = jsonDecode(response.body);
        Korisnik user = Korisnik.FromJson(data);
        return user;
      } else {
        throw Exception(
            "Neuspješno ažuriranje korisničke uloge: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Greška prilikom komunikacije sa serverom");
    }
  }

  Future<bool> checkUsername(String korisnickoIme) async {
    var url = "$fullUrl/check-username?korisnickoIme=$korisnickoIme";
    var uri = Uri.parse(url);
    var response = await http?.get(uri);
    if (response == null) {
      throw Exception("HTTP zahtjev nije poslan.");
    }

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 404) {
      return false;
    } else {
      throw Exception("Greška prilikom provjere korisničkog imena");
    }
  }

  Future<bool> resetPasswordByEmail(String email) async {
    var url = "$fullUrl/resetPasswordByEmail";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    final response = await http!.post(
      uri,
      headers: headers,
      body: json.encode(email),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
