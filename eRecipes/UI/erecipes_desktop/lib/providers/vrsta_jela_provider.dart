import 'package:erecipes_desktop/models/vrsta_jela.dart';
import 'package:erecipes_desktop/providers/base_provider.dart';

class VrstaJelaProvider extends BaseProvider<VrstaJela>{

  VrstaJelaProvider():super("VrstaJela");
  
 @override
  fromJson(data) {
    return VrstaJela.FromJson(data);
  }
}