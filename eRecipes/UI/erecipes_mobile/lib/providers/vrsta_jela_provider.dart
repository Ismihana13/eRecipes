import 'package:erecipes_mobile/models/vrsta_jela.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

class VrstaJelaProvider extends BaseProvider<VrstaJela> {
  VrstaJelaProvider() : super("VrstaJela");

  @override
  fromJson(data) {
    return VrstaJela.FromJson(data);
  }
}
