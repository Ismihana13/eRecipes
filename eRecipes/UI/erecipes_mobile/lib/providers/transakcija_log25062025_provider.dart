import 'package:erecipes_mobile/models/transakcija_log25062025.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

class TransakcijaLog25062025Provider extends BaseProvider<TransakcijaLog25062025> {
  TransakcijaLog25062025Provider() : super("TransakcijaLog25062025");

  @override
  fromJson(data) {
    return TransakcijaLog25062025.FromJson(data);
  }
}
