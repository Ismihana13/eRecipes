import 'package:erecipes_mobile/models/kategorija_transakcije25062025.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

class KategorijaTransakcije25062025Provider extends BaseProvider<KategorijaTransakcije25062025> {
  KategorijaTransakcije25062025Provider() : super("KategorijaTransakcije25062025");

  @override
  fromJson(data) {
    return KategorijaTransakcije25062025.FromJson(data);
  }
}
