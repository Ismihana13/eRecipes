import 'package:erecipes_mobile/models/finansijski_limit14072025.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

class FinansijskiLimit14072025Provider extends BaseProvider<FinansijskiLimit14072025> {
  FinansijskiLimit14072025Provider() : super("FinansijskiLimit14072025");

  @override
  fromJson(data) {
    return FinansijskiLimit14072025.FromJson(data);
  }
}
