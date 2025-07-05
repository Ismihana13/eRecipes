import 'package:erecipes_mobile/models/finansijski_limit25062025.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

class FinanskijskiLimit25062025Provider extends BaseProvider<FinanskijskiLimit25062025> {
  FinanskijskiLimit25062025Provider() : super("FinanskijskiLimit25062025");

  @override
  fromJson(data) {
    return FinanskijskiLimit25062025.FromJson(data);
  }
}
