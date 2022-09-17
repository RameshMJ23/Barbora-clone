
import 'package:barboraapp/data/models/recipe_model.dart';
import 'package:barboraapp/screeens/fonts/custom_icons_icons.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc/auth_bloc.dart';
import '../bloc/auth_bloc/auth_state.dart';
import '../bloc/recipe_bloc/recipe_bloc.dart';
import '../bloc/recipe_bloc/saved_recipe_bloc/saved_recipe_bloc.dart';
import '../bloc/recipe_bloc/saved_recipe_bloc/saved_recipe_state.dart';

class RecipeDetailScreen extends StatelessWidget {

  RecipeModel recipeModel;

  RecipeDetailScreen({required this.recipeModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About the recipe"),
        centerTitle: true,
        backgroundColor: const Color(0xffE32323),
        leading: getAppLeadingWidget(context),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Stack(
                  children: [
                    Hero(
                      flightShuttleBuilder: (context, anim, heroDirection, fromHeroContext, toHeroContext){
                        if(heroDirection == HeroFlightDirection.pop){
                          return fromHeroContext.widget;
                        }else{
                          return toHeroContext.widget;
                        }
                      },
                      child: SizedBox(
                        height: 250.0,
                        child: Image.network(
                          recipeModel.image,
                          fit: BoxFit.cover,
                        ),
                        width: double.infinity,
                      ),
                      tag: recipeModel.id,
                    ),
                    Positioned(
                      top: 8.0,
                      right: 15.0,
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (authContext, authState){
                          return authState is UserState
                              ? BlocBuilder<SavedRecipeBloc, SavedRecipeState>(
                                builder: (blocContext, savedRecipeState){

                                  bool isSaved = (savedRecipeState is FetchedSavedRecipeState)
                                      ? savedRecipeState.savedRecipeList.where((recipe){
                                        return recipe.id == recipeModel.id;
                                      }).isNotEmpty
                                      : false;

                                  return IconButton(
                                    icon: Icon(
                                      isSaved ? Icons.bookmark : Icons.bookmark_outline,
                                      size: 35.0,
                                      color: Colors.white,
                                    ),
                                    onPressed: (){
                                      if(isSaved){
                                        BlocProvider.of<SavedRecipeBloc>(context).unSaveRecipe(
                                          authState.uid,
                                          recipeModel.id
                                        );
                                      }else{
                                        BlocProvider.of<SavedRecipeBloc>(context).saveRecipe(
                                          authState.uid,
                                          recipeModel
                                        );
                                      }
                                    },
                                  );
                                },
                              )
                              : Text("");
                        },
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        child: Text(
                          recipeModel.title,
                          style: const TextStyle(
                            fontSize: 22.0
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Column(
                          children: [
                            recipeModel.time != null
                                ? Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.timer,
                                        color: Colors.grey.shade500,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                        child: Text(
                                          "Cooking time: " + recipeModel.time!,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                                : const SizedBox(height: 0,width: 0,),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Row(
                                children: [
                                  Icon(
                                    CustomIcons.hard_hat,
                                    color: Colors.grey.shade500,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Text(
                                        "Difficulty: " + recipeModel.difficulty,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.grey.shade500,
                                        )
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10.0,),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "About the recipe",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    recipeModel.about,
                    style: const TextStyle(
                      fontSize: 14.0,
                    )
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0,),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
            color: Colors.white,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Ingredients",
                    style:  TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.green,
                  ),
                  child: const Center(
                    child: Text(
                      "Buy ingredients",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                      "Number of servings: " + (recipeModel.servings ?? "-")
                  ),
                ),
                Column(
                  children: recipeModel.ingredients_name_en.mapIndexed((index, ingredient) {
                    return Column(
                      children: [
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                ingredient,
                                style: const TextStyle(
                                  fontSize: 15.0
                                ),
                              ),
                              Text(
                                recipeModel.quantity_en[index],
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.grey.shade500
                                )
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                )
              ],
            ),
          ),
          const SizedBox(height: 10.0,),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Preparation",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: recipeModel.prep_en.mapIndexed((index, step){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            child: Text(
                              (index + 1).toString(),
                              style: const TextStyle(
                                  color: Colors.black87
                              ),
                            ),
                            radius: 20.0,
                            backgroundColor: Colors.grey.shade400,
                          ),
                          const SizedBox(width: 20.0,),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  step,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

