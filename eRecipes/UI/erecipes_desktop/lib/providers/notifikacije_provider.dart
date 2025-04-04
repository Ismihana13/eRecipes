import 'dart:convert';

import 'package:erecipes_desktop/models/notifikacije.dart';
import 'package:erecipes_desktop/providers/base_provider.dart';

class NotifikacijeProvider extends BaseProvider<Notifikacije> {
  NotifikacijeProvider() : super("Notifikacije");

  @override
  fromJson(data) {
    return Notifikacije.FromJson(data);
  }

  Future<List<Notifikacije>> getSve({dynamic filter})async{
    var url="$fullUrl";
    if(filter!=null){
      var queryString=getQueryString(filter);
      url="$url?$queryString";
   }
    var uri=Uri.parse(url);
    var headers= createHeaders();
    var response=await http!.get(uri,headers: headers);
    if(isValidResponse(response)){
      var data= jsonDecode(response.body);
      List<Notifikacije> result=[];
      for(var item in data){
        result.add(fromJson(item));
      }
      return result;
    }else{
      throw Exception("Unknown error.");
    }
  }

   Future<void> oznaciObavijestKaoProcitanu(int notifikacijeId, bool procitano) async {
    var url = "$fullUrl/$notifikacijeId/procitano?procitano=$procitano";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    try {
      var response = await http!.put(uri, headers: headers);

      if (isValidResponse(response)) {
        print("Obavijest je uspješno ažurirana.");
      } else {
        print("Greška pri ažuriranju obavijesti: ${response.statusCode}");
        throw Exception("Greška pri ažuriranju obavijesti.");
      }
    } catch (e) {
      print("Došlo je do greške: $e");
      throw Exception("Došlo je do greške prilikom slanja zahtjeva.");
    }
  }

  Future<void> obrisiObavijest(int notifikacijeId) async{
    var url="$fullUrl/$notifikacijeId";
     var uri = Uri.parse(url);
    var headers = getHeaders();
    var response = await http!.delete(uri, headers: headers);
    if (isValidResponse(response)) {
      print("Obavijest uspješno obrisana.");
    } else {
      throw Exception("Došlo je do greške prilikom slanja zahtjeva.");
    }
  }
}
