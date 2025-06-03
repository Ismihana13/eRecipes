import 'dart:convert';

import 'package:erecipes_mobile/models/rezervacija_prostora.dart';
import 'package:erecipes_mobile/models/rezervacija_prostora_statistika.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

class RezervacijaProstoraProvider extends BaseProvider<RezervacijaProstora> {
  RezervacijaProstoraProvider() : super("RezervacijaProstora");

  @override
  fromJson(data) {
    return RezervacijaProstora.fromJson(data);
  }

  Future<List<RezervacijaProstoraStatistika>> getRezervacija() async {
    var url = "$fullUrl/BrojRezervacija";
    print("${url}");
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (isValidResponse(response)) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => RezervacijaProstoraStatistika.fromJson(e)).toList();
    } else {
      throw Exception(
          "Failed to fetch mood stats. Status code: ${response.statusCode}");
    
    }
  }
}
