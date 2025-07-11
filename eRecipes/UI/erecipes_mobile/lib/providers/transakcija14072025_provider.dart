import 'dart:convert';

import 'package:erecipes_mobile/models/statistika.dart';
import 'package:erecipes_mobile/models/transakcija14072025.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

class Transakcija14072025Porvider extends BaseProvider<Transakcija14072025> {
  Transakcija14072025Porvider() : super("Transakcija14072025");

  @override
  fromJson(data) {
    return Transakcija14072025.FromJson(data);
  }

    Future<List<Statistika>> GetIznos(
      {dynamic filter}) async {
    var url = "$fullUrl/iznos";
    if (filter != null && filter.isNotEmpty) {
      var queryString = getQueryString(filter);
      url = "$url?$queryString";
    }
    var uri = Uri.parse(url);

    var headers = getHeaders();
    var response = await http!.get(uri, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Statistika.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load ');
    }
  }
}
