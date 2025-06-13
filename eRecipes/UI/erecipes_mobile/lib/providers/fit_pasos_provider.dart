import 'package:erecipes_mobile/models/fit_pasos.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

class FitPasosProvider extends BaseProvider<FitPasos> {
  FitPasosProvider() : super("FitPasos");

  @override
  fromJson(data) {
    return FitPasos.FromJson(data);
  }
}
