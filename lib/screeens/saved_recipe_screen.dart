import 'package:barboraapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:barboraapp/bloc/auth_bloc/auth_state.dart';
import 'package:barboraapp/bloc/recipe_bloc/saved_recipe_bloc/saved_recipe_state.dart';
import 'package:barboraapp/screeens/recipe_detail_screen.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/recipe_bloc/recipe_bloc.dart';
import '../bloc/recipe_bloc/saved_recipe_bloc/saved_recipe_bloc.dart';

class SavedRecipeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved recipes"),
        centerTitle: true,
        leading: getAppLeadingWidget(context),
        backgroundColor: const Color(0xffE32323)
      ),
      body: BlocBuilder<SavedRecipeBloc, SavedRecipeState>(
        builder: (context, state){
          return (state is FetchedSavedRecipeState && state.savedRecipeList.isNotEmpty)
              ? ListView.builder(
                itemBuilder: (context, index){
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      child: SizedBox(
                        height: 320.0,
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
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0)
                                    ),
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        state.savedRecipeList[index].image,
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
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.bookmark,
                                            size: 35.0,
                                            color: Colors.white,
                                          ),
                                          onPressed: (){
                                            BlocProvider.of<SavedRecipeBloc>(context).unSaveRecipe(
                                              (BlocProvider.of<AuthBloc>(context).state as UserState).uid,
                                              state.savedRecipeList[index].id
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                    child: Text(
                                      state.savedRecipeList[index].title,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                state.savedRecipeList[index].time != null
                                    ? Padding(
                                      child: Row(
                                        children: [
                                          Icon(Icons.timer, color: Colors.grey.shade500),
                                          Padding(
                                            child: Text(
                                              state.savedRecipeList[index].time!,
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
                                        Icons.work,
                                        color: Colors.grey.shade500
                                      ),
                                      Padding(
                                        child: Text(
                                          state.savedRecipeList[index].difficulty,
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
                    ),
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: SavedRecipeBloc(),
                            child: RecipeDetailScreen(recipeModel: state.savedRecipeList[index]),
                          )
                        )
                      );
                    },
                  );
                },
                itemCount:  state.savedRecipeList.length,
          )
          : (state is FetchedSavedRecipeState && state.savedRecipeList.isEmpty)
          ? Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.bookmark, size: 100.0, color: Colors.black54,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "No recipes saved!",
                    style: TextStyle(
                      fontSize: 25.0
                    ),
                  ),
                )
              ],
            ),
          )
          : const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
              backgroundColor: Colors.green,
            ),
          );
        },
      ),
    );
  }
}
