import 'package:erecipes_desktop/models/kategorija.dart';
import 'package:erecipes_desktop/providers/base_provider.dart';

class KategorijaProvider extends BaseProvider<Kategorija>{

  KategorijaProvider():super("Kategorija");
  
 @override
  fromJson(data) {
    return Kategorija.FromJson(data);
  }

   Future<int> fetchBrojRecepataZaKategoriju(int kategorijaId) async {
    var url = "$fullUrl/$kategorijaId/broj-recepata";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (isValidResponse(response)) {
       return int.parse(response.body);
    } else {
      throw Exception('Error');
    }
  }
   Future<void> deleteKategorija(int? id) async {
  var url = "$fullUrl/$id/DeleteKategorija";
  var uri = Uri.parse(url);
  var headers = createHeaders();

  var response = await http!.put(uri, headers: headers);

  if (isValidResponse(response)) {
    print("Kategorija obrisana.");
  } else {
    throw Exception("Neuspješno brisanje kategorije.");
  }
}
}