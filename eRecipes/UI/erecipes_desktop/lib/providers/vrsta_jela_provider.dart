import 'package:erecipes_desktop/models/vrsta_jela.dart';
import 'package:erecipes_desktop/providers/base_provider.dart';

class VrstaJelaProvider extends BaseProvider<VrstaJela> {
  VrstaJelaProvider() : super("VrstaJela");

  @override
  fromJson(data) {
    return VrstaJela.FromJson(data);
  }

  Future<int> fetchBrojRecepataZaVrstuJela(int vrstaJelaId) async {
    var url = "$fullUrl/$vrstaJelaId/broj-recepata";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (isValidResponse(response)) {
      return int.parse(response.body);
    } else {
      throw Exception('Error');
    }
  }

  Future<void> deleteVrstaJela(int? id) async {
    var url = "$fullUrl/$id/DeleteVrstaJela";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.put(uri, headers: headers);

    if (isValidResponse(response)) {
      print("Vrsta jela obrisana.");
    } else {
      throw Exception("Neuspješno brisanje vrste jela.");
    }
  }
}
