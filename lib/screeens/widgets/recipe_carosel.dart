import 'dart:developer';

import 'package:barboraapp/bloc/auth_bloc/auth_state.dart';
import 'package:barboraapp/bloc/recipe_bloc/saved_recipe_bloc/saved_recipe_bloc.dart';
import 'package:barboraapp/bloc/recipe_bloc/saved_recipe_bloc/saved_recipe_state.dart';
import 'package:barboraapp/data/models/recipe_model.dart';
import 'package:barboraapp/screeens/fonts/custom_icons_icons.dart';
import 'package:barboraapp/screeens/recipe_detail_screen.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/recipe_bloc/recipe_bloc.dart';
import '../../bloc/recipe_bloc/recipe_state.dart';

class RecipeCarousel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (recipeContext, state){
        if(state is FetchedRecipeState){
         log(state.recipeList.toString());
          return CarouselSlider.builder(
              itemCount: state.recipeList.length,
              itemBuilder: (carouselContext, itemIndex, pageIndex){
                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)
                      ),
                      elevation: 2.0,
                      child: Container(
                        //padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300
                            )
                          ]
                        ),
                        child: Column(
                          children: [
                            Hero(
                              tag: state.recipeList[itemIndex].id,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0)
                                  ),
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      state.recipeList[itemIndex].image,
                                    ),
                                    fit: BoxFit.cover
                                  )
                                ),
                                height: 170.0,
                                width: double.infinity,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 8.0,
                                      right: 15.0,
                                      child: BlocBuilder<AuthBloc, AuthState>(
                                        builder: (authContext, authState){
                                          return authState is UserState
                                            ? BlocBuilder<SavedRecipeBloc, SavedRecipeState>(
                                              builder: (context, savedRecipeState){

                                              bool isSaved = (savedRecipeState is FetchedSavedRecipeState)
                                                ? savedRecipeState.savedRecipeList.where((recipe){
                                                  return recipe.id == state.recipeList[itemIndex].id;
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
                                                      BlocProvider.of<RecipeBloc>(context).unSaveRecipe(
                                                          authState.uid,
                                                          state.recipeList[itemIndex].id
                                                      );
                                                    }else{
                                                      BlocProvider.of<RecipeBloc>(context).saveRecipe(
                                                          authState.uid,
                                                          state.recipeList[itemIndex]
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
                              )
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                child: Text(
                                  state.recipeList[itemIndex].title,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            state.recipeList[itemIndex].time != null
                                ? Padding(
                                  child: Row(
                                    children: [
                                      Icon(Icons.timer, color: Colors.grey.shade500),
                                      Padding(
                                        child: Text(
                                          state.recipeList[itemIndex].time!,
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.grey.shade500
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                 )
                                : const SizedBox(height: 1.0,),
                            Padding(
                              child: Row(
                                children: [
                                  Icon(
                                    CustomIcons.hard_hat,
                                    color: Colors.grey.shade500
                                  ),
                                  Padding(
                                    child: Text(
                                      state.recipeList[itemIndex].difficulty,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.grey.shade500
                                      )
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  )
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider<SavedRecipeBloc>.value(
                          value: BlocProvider.of<SavedRecipeBloc>(context),
                          child: RecipeDetailScreen(recipeModel: state.recipeList[itemIndex]),
                        )
                      )
                    );
                  },
                );
              },
              options: _getCarouselOptions()
          );
        }else{
          return CarouselSlider.builder(
              itemCount: 3,
              itemBuilder: (context, itemIndex, pageIndex){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                    elevation: 2.0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300
                            )
                          ]
                      ),
                      child: Column(
                        children: [
                          getShimmerWidget(height: 170, borderRadius: 0.0),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getShimmerWidget(height: 30),
                                  const Spacer(),
                                  getShimmerWidget(height: 20, width: 100),
                                  getShimmerWidget(height: 20, width: 100),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              options: _getCarouselOptions()
          );

        }
      },
    );
  }

  CarouselOptions _getCarouselOptions() => CarouselOptions(
      height: 350,
      aspectRatio: 16/9,
      viewportFraction: 0.85,
      initialPage: 0,
      enableInfiniteScroll: false,
      reverse: false,
      autoPlay: false,
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: false,
      scrollDirection: Axis.horizontal,
      pageSnapping: false,
      padEnds: false
  );
}
