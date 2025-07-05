import 'dart:convert';

import 'package:erecipes_mobile/models/iznos_kategorija.dart';
import 'package:erecipes_mobile/models/transakcija25062025.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

class Transakcija25062025Provider extends BaseProvider<Transakcija25062025> {
  Transakcija25062025Provider() : super("Transakcije25062025");

  @override
  fromJson(data) {
    return Transakcija25062025.FromJson(data);
  }
    Future<List<IznosKategorija>> getIznos(
      {dynamic filter}) async {
    var url = "$fullUrl/ukupan-iznos";
     if (filter != null && filter.isNotEmpty) {
      var queryString = getQueryString(filter);
      url = "$url?$queryString";
    }
    var uri = Uri.parse(url);

    var headers = getHeaders();
    var response = await http!.get(uri, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => IznosKategorija.FromJson(item)).toList();
    } else {
      throw Exception('Failed to load favorite recipes');
    }
  }

}
