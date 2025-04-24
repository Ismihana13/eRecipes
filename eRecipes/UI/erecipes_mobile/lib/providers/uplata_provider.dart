import 'package:erecipes_mobile/models/uplata.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

class UplataProvider extends BaseProvider<Uplata> {
  UplataProvider() : super("Uplata");

  @override
  fromJson(data) {
    return Uplata.FromJson(data);
  }
}
