import 'package:erecipes_desktop/models/izvjestaj.dart';
import 'package:erecipes_desktop/providers/base_provider.dart';

class IzvjestajProvider extends BaseProvider<Izvjestaj> {
  IzvjestajProvider() : super("Izvjestaj");

  @override
  fromJson(data) {
    return Izvjestaj.FromJson(data);
  }
}
