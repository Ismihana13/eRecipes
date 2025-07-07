import 'package:erecipes_mobile/models/finansijski_limit25062025.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

class FinansijskiLimit25062025Provider extends BaseProvider<FinansijskiLimit25062025> {
  FinansijskiLimit25062025Provider() : super("FinansijskiLimit25062025");

  @override
  fromJson(data) {
    return FinansijskiLimit25062025.FromJson(data);
  }
}
