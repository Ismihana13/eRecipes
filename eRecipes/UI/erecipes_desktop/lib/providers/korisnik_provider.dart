import 'dart:convert';

import 'package:erecipes_desktop/models/korisnik.dart';
import 'package:erecipes_desktop/providers/base_provider.dart';

class KorisnikProvider extends BaseProvider<Korisnik> {
  KorisnikProvider() : super("Korisnik");

  @override
  Korisnik fromJson(x) {
    return Korisnik.FromJson(x);
  }

  Future<Korisnik> Authenticate() async {
     var url = "$fullUrl/Authenticate";
    var uri = Uri.parse(url);

    var headers = createHeaders();
    var response = await http!.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      Korisnik user = fromJson(data) as Korisnik;
      return user;
    } else {
      throw Exception("Wrong username or password");
    }
  }
}