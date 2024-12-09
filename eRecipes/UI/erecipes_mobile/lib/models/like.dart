import 'package:erecipes_mobile/models/recept.dart';

class Like {
    List<LikeItem> items = [];
}

class LikeItem {
  LikeItem(this.recept, this.count);
  late Recept recept;
  late int count;
}