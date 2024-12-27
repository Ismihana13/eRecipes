

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
  print("Full URL: $uri");

  var headers = getHeaders();
  var response = await http!.get(uri, headers: headers);

  if (response.statusCode == 204) {
    print('Authentication successful, no content returned.');
    // Return a default Korisnik or handle this case differently
    return Korisnik(); // Or return null if that makes sense
  }

  if (isValidResponse(response)) {
    var data = jsonDecode(response.body);
    print('API response: ${response.body}');

    Korisnik user = fromJson(data);
    notifyListeners();
    return user;
  } else {
    throw Exception("Wrong username or password");
  }
}

}