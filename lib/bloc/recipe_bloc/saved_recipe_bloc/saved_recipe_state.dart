
import 'package:barboraapp/data/models/recipe_model.dart';
import 'package:equatable/equatable.dart';

class SavedRecipeState extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchedSavedRecipeState extends SavedRecipeState{

  List<RecipeModel> savedRecipeList;

  FetchedSavedRecipeState({required this.savedRecipeList});

  @override
  // TODO: implement props
  List<Object?> get props => [savedRecipeList];
}

class NoSavedRecipeState extends SavedRecipeState{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}