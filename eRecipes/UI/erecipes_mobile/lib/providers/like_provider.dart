
import 'package:collection/collection.dart';
import 'package:erecipes_mobile/models/like.dart';
import 'package:erecipes_mobile/models/recept.dart';
import 'package:flutter/material.dart';

class LikeProvider with ChangeNotifier {
  Like like = Like();
  addToCart(Recept recipe) {
      print("Dodajem recept: ${recipe.naziv}");
    if (findInCart(recipe) != null) {
      findInCart(recipe)?.count++;
    } else {
      like.items.add(LikeItem(recipe, 1));
    }
    
    notifyListeners();
  }

  removeFromCart(Recept recipe) {
    like.items.removeWhere((item) => item.recept.receptId == recipe.receptId);
    notifyListeners();
  }

  LikeItem? findInCart(Recept recipe) {
    LikeItem? item = like.items.firstWhereOrNull((item) => item.recept.receptId == recipe.receptId);
    return item;
  }
}