

import 'package:barboraapp/bloc/recipe_bloc/recipe_state.dart';
import 'package:barboraapp/data/models/recipe_model.dart';
import 'package:barboraapp/data/services/recipe_service.dart';
import 'package:barboraapp/data/services/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeBloc extends Cubit<RecipeState>{

  String type;

  RecipeBloc({required this.type}):super(NoRecipeState()){
    RecipeServices().recipeData(type).listen((list) {
      if(list != null){
        if(isClosed) return;
        Future.delayed(Duration(milliseconds: 500), (){
          emit(FetchedRecipeState(recipeList: list));
        });

      }else{
        emit(NoRecipeState());
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