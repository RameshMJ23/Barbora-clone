import 'dart:developer';

import 'package:barboraapp/bloc/auth_bloc/auth_state.dart';
import 'package:barboraapp/bloc/recipe_bloc/recipe_bloc.dart';
import 'package:barboraapp/bloc/recipe_bloc/saved_recipe_bloc/saved_recipe_bloc.dart';
import 'package:barboraapp/bloc/recipe_bloc/saved_recipe_bloc/saved_recipe_state.dart';
import 'package:barboraapp/screeens/saved_recipe_screen.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:barboraapp/screeens/widgets/recipe_carosel.dart';
import 'package:barboraapp/screeens/widgets/recipe_categories_expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc/auth_bloc.dart';


class RecipeScreen extends StatefulWidget {
  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipes", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xffE32323),
        leading: getAppLeadingWidget(context),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 100.0, left: 20.0),
              child: RecipeCategoriesExpandable(),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white
            ),
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState){
              return authState is UserState
                ? GestureDetector(
                child: Card(
                  elevation: 0.0,
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.bookmark,
                          color: Colors.black87,
                        ),
                        const Text(
                            " Saved receipes ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0
                            )
                        ),
                        BlocBuilder<SavedRecipeBloc, SavedRecipeState>(
                          builder: (context, savedRecipeState){

                            String savedItemCount = (savedRecipeState is FetchedSavedRecipeState)
                                ? "(${savedRecipeState.savedRecipeList.length.toString()})"
                                : "(0)";

                            return Text(
                                savedItemCount,
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.0
                                )
                            );
                          },
                        )
                      ],
                    ) ,
                  ),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)
                  ),
                ),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<SavedRecipeBloc>(context),
                        child: SavedRecipeScreen(),
                      ))
                  );
                },
              )
              : const SizedBox(height: 0.0,width: 0.0,);
            },
          ),
          recipeTitle("Pagrindiniai patiekalai"),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState){
              return authState is UserState
                ? MultiBlocProvider(
                  providers: [
                    BlocProvider<RecipeBloc>.value(
                      value: RecipeBloc(type: "pagpat"),
                    ),
                    BlocProvider<SavedRecipeBloc>.value(
                      value: BlocProvider.of<SavedRecipeBloc>(context),
                    ),
                  ],
                  child: RecipeCarousel(),
                )
                : BlocProvider<RecipeBloc>.value(
                  value: RecipeBloc(type: "pagpat"),
                  child: RecipeCarousel(),
                );
            },
          ),
          const Divider(),
          recipeTitle("Sriubos"),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState){
              return authState is UserState
                ? MultiBlocProvider(
                  providers: [
                    BlocProvider<RecipeBloc>.value(
                      value: RecipeBloc(type: "sriuba"),
                    ),
                    BlocProvider<SavedRecipeBloc>.value(
                      value: BlocProvider.of<SavedRecipeBloc>(context),
                    ),
                  ],
                  child: RecipeCarousel(),
                )
                : BlocProvider<RecipeBloc>.value(
                  value: RecipeBloc(type: "sriuba"),
                  child: RecipeCarousel(),
                );
            },
          ),
          const Divider(),
          recipeTitle("Desertai"),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState){
              return authState is UserState
                ? MultiBlocProvider(
                  providers: [
                    BlocProvider<RecipeBloc>.value(
                      value: RecipeBloc(type: "pagpat"),
                    ),
                    BlocProvider<SavedRecipeBloc>.value(
                      value: BlocProvider.of<SavedRecipeBloc>(context),
                    ),
                  ],
                  child: RecipeCarousel(),
                )
                : BlocProvider<RecipeBloc>.value(
                  value: RecipeBloc(type: "pagpat"),
                  child: RecipeCarousel(),
                );
            },
          ),
          const Divider(),
          recipeTitle("Beatos virtuve"),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState){
              return authState is UserState
                ? MultiBlocProvider(
                  providers: [
                    BlocProvider<RecipeBloc>.value(
                      value: RecipeBloc(type: "pagpat"),
                    ),
                    BlocProvider<SavedRecipeBloc>.value(
                      value: BlocProvider.of<SavedRecipeBloc>(context),
                      ),
                    ],
                  child: RecipeCarousel(),
                )
                : BlocProvider<RecipeBloc>.value(
                  value: RecipeBloc(type: "pagpat"),
                  child: RecipeCarousel(),
                );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget recipeTitle(String title){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 17.0
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextButton(
            onPressed: (){

            },
            child: const Text(
              "All recipe",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black87
              ),
            )
          ),
        )
      ],
    );
  }
}
