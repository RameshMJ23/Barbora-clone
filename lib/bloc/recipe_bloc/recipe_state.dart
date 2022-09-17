
import 'package:barboraapp/data/models/recipe_model.dart';
import 'package:equatable/equatable.dart';

class RecipeState extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NoRecipeState extends RecipeState{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchedRecipeState extends RecipeState{

  List<RecipeModel> recipeList;

  FetchedRecipeState({required this.recipeList});

  @override
  // TODO: implement props
  List<Object?> get props => [recipeList];
}