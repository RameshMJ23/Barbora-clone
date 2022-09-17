

import 'dart:developer';

import 'package:barboraapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:barboraapp/bloc/auth_bloc/auth_state.dart';
import 'package:barboraapp/bloc/recipe_bloc/saved_recipe_bloc/saved_recipe_state.dart';
import 'package:barboraapp/data/models/recipe_model.dart';
import 'package:barboraapp/data/services/user_service.dart';
import 'package:bloc/bloc.dart';

class SavedRecipeBloc extends Cubit<SavedRecipeState>{

  SavedRecipeBloc(): super(NoSavedRecipeState()){
    AuthBloc().stream.listen((event) {
      if(event is UserState){
        UserService().savedRecipeStream(event.uid).listen((event) {
          if(event != null){
            emit(FetchedSavedRecipeState(savedRecipeList: event));
          }else{
            emit(NoSavedRecipeState());
          }
        });
      }
    });
  }

  saveRecipe(String uid, RecipeModel recipeModel) async{
    await UserService().saveFavRecipe(uid, recipeModel);
  }

  unSaveRecipe(String uid, String id) async{
    await UserService().unSaveRecipe(uid, id);
  }

  @override
  Future<void> close() async{
    // TODO: implement close
    //return super.close();
    return;
  }
}