import 'package:erecipes_mobile/models/radni_prostor.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

class RadniProstorProvider extends BaseProvider<RadniProstor> {
  RadniProstorProvider() : super("RadniProstor");

  @override
  fromJson(data) {
    return RadniProstor.FromJson(data);
  }
}
