
import 'package:barboraapp/data/models/recipe_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeServices{
  
  final CollectionReference _recipeRef = FirebaseFirestore.instance.collection("receipe");

  RecipeModel _recipeFromSnapshot(DocumentSnapshot snapshot){
    final data = (snapshot.data() as Map);
    return RecipeModel(
        about: data['about'],
        about_en: data['about_en'],
        company: data['company'],
        difficulty: data['difficulty'],
        difficulty_en: data['difficulty_en'],
        image: data['image'],
        ingredients_name: data['ingredients_name'],
        ingredients_name_en: data['ingredients_name_en'] ,
        num_items: data['num_items'],
        prep: data['prep'],
        prep_en: data['prep_en'] ,
        prep_steps: data['prep_steps'],
        quantity: data['quantity'] ,
        quantity_en: data['quantity_en'] ,
        servings: data['servings'],
        title: data['title'],
        title_en: data['title_en'],
        type: data['type'],
        time: data['time'],
       id: data['id']
    );
  }

  List<RecipeModel> _recipeListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map(_recipeFromSnapshot).toList();
  }

  Stream<List<RecipeModel>> recipeData(String type){
    /*return _recipeRef.doc().snapshots().where((recipe){
      if((recipe.data() as Map)["type"] == type){
        return true;
      }else{
        return false;
      }
    }).map(_recipeFromSnapshot);*/
    return _recipeRef.where("type", isEqualTo: type).snapshots().map(_recipeListFromSnapshot);
  }

}