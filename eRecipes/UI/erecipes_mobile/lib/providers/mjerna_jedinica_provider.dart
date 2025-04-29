import 'package:erecipes_mobile/models/mjerna_jedinica.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

class MjernaJedinicaProvider extends BaseProvider<MjernaJedinica> {
  MjernaJedinicaProvider() : super("MjernaJedinica");

  @override
  fromJson(data) {
    return MjernaJedinica.FromJson(data);
  }
}
