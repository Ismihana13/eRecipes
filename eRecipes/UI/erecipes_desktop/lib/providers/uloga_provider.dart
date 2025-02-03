import 'package:erecipes_desktop/models/uloga.dart';
import 'package:erecipes_desktop/providers/base_provider.dart';

class UlogaProvider extends BaseProvider<Uloga> {
  UlogaProvider() : super("Uloga");

  @override
  Uloga fromJson(x) {
    return Uloga.fromJson(x);
  }
}
