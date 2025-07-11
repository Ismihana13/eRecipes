import 'package:erecipes_mobile/models/kategorija_transakcije14072025.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

class KategorijaTransakcije14072025Provider extends BaseProvider<KategorijaTransakcije14072025> {
  KategorijaTransakcije14072025Provider() : super("KategorijaTransakcije14072025");

  @override
  fromJson(data) {
    return KategorijaTransakcije14072025.FromJson(data);
  }
}
