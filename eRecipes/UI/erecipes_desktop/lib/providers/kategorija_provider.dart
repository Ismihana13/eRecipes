import 'package:erecipes_desktop/models/kategorija.dart';
import 'package:erecipes_desktop/providers/base_provider.dart';

class KategorijaProvider extends BaseProvider<Kategorija>{

  KategorijaProvider():super("Kategorija");
  
 @override
  fromJson(data) {
    return Kategorija.FromJson(data);
  }
}