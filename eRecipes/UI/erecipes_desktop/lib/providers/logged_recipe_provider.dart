import 'package:erecipes_desktop/models/recept.dart';
import 'package:erecipes_desktop/models/search_result.dart';
import 'package:erecipes_desktop/providers/recipe_provider.dart';

class LoggedRecipeProvider extends RecipeProvider {
  @override
  Future<SearchResult<Recept>> get({filter}) {
    print(" in in logged");
    return super.get(filter: filter);
  }
}
