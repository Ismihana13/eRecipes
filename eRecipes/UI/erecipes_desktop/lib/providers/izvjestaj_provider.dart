import 'package:erecipes_desktop/models/izvjestaj.dart';
import 'package:erecipes_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IzvjestajProvider extends BaseProvider<Izvjestaj> {
  IzvjestajProvider() : super("Izvjestaj");

  @override
  fromJson(data) {
    return Izvjestaj.FromJson(data);
  }

  Future<void> insertIzvjestaj(int? receptId) async {
    var url = "$fullUrl";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var body = jsonEncode({
      "ReceptId": receptId
    });

    var response = await http.post(uri, headers: headers, body: body);

    if (isValidResponse(response)) {
      print("Izvještaj uspješno kreiran!");
    } else {
      print("Greška pri kreiranju izvještaja: ${response.body}");
      throw Exception("Neuspješno kreiranje izvještaja.");
    }
  }
  Future<List<Izvjestaj>> getSve({dynamic filter})async{
    var url="$fullUrl";
    if(filter!=null){
      var queryString=getQueryString(filter);
      url="$url?$queryString";
    }
     print("Pozivam GET URL: $url"); 
    var uri=Uri.parse(url);
    var headers= createHeaders();
    var response=await http.get(uri,headers: headers);
    if(isValidResponse(response)){
      var data= jsonDecode(response.body);
      List<Izvjestaj> result=[];
      for(var item in data){
        result.add(fromJson(item));
      }
      return result;
    }else{
      throw new Exception("Unknown error.");
    }

  }
}
