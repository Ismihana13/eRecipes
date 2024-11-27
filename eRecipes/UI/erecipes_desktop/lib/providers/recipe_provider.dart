import 'package:erecipes_desktop/models/recept.dart';
import 'package:erecipes_desktop/providers/base_provider.dart';

class RecipeProvider extends BaseProvider<Recept>{

  RecipeProvider():super("Recept");
  
 @override
  fromJson(data) {
    return Recept.FromJson(data);
  }
}