import 'package:erecipes_mobile/models/to_do4924.dart';

import 'package:erecipes_mobile/providers/base_provider.dart';

class ToDo4924Provider extends BaseProvider<ToDo4924> {
  ToDo4924Provider() : super("ToDo4924");

  @override
  fromJson(data) {
    return ToDo4924.FromJson(data);
  }
}
