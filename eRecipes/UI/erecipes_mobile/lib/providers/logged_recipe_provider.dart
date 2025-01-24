import 'package:erecipes_mobile/models/recept.dart';
import 'package:erecipes_mobile/models/search_result.dart';
import 'package:erecipes_mobile/providers/recipe_provider.dart';

class LoggedRecipeProvider extends RecipeProvider{
  @override
  Future<SearchResult<Recept>> get({filter}) {
    // TODO: implement get
    print(" in in logged");
    return super.get(filter: filter);
  }
}