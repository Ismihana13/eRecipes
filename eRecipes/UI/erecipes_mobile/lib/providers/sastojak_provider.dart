import 'package:erecipes_mobile/models/sastojak.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

class SastojakProvider extends BaseProvider<Sastojak> {
  SastojakProvider() : super("Sastojak");

  @override
  fromJson(data) {
    return Sastojak.FromJson(data);
  }

  void addSastojak(Sastojak sastojak)  {
    insert(sastojak);
    notifyListeners();
  }
}
