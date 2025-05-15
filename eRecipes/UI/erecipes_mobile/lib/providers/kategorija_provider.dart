import 'package:erecipes_mobile/models/kategorija.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

class KategorijaProvider extends BaseProvider<Kategorija> {
  KategorijaProvider() : super("Kategorija");

  @override
  fromJson(data) {
    return Kategorija.FromJson(data);
  }
}
