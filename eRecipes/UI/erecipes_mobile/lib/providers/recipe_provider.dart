import 'package:erecipes_mobile/models/recept.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

class RecipeProvider extends BaseProvider<Recept>{

  RecipeProvider():super("Recept");
  
 @override
  fromJson(data) {
    return Recept.FromJson(data);
  }
}