

import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeModel{

  String about;

  String about_en;

  String? company;

  String difficulty;

  String difficulty_en;

  String image;

  List<dynamic> ingredients_name;

  List<dynamic> ingredients_name_en;

  String num_items;

  List<dynamic> prep;

  List<dynamic> prep_en;

  String prep_steps;

  List<dynamic> quantity;

  List<dynamic> quantity_en;

  String? servings;

  String title;

  String title_en;

  String type;

  String? time;

  String id;

  RecipeModel({
    required this.about,
    required this.about_en,
    required this.company,
    required this.difficulty,
    required this.difficulty_en,
    required this.image,
    required this.ingredients_name,
    required this.ingredients_name_en,
    required this.num_items,
    required this.prep,
    required this.prep_en,
    required this.prep_steps,
    required this.quantity,
    required this.quantity_en,
    required this.servings,
    required this.title,
    required this.title_en,
    required this.type,
    required this.time,
    required this.id
  });

  factory RecipeModel.recipeModelFromFirebaseData(DocumentSnapshot snapshot){
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

  static Map<String, dynamic> recipeToFirebaseData(RecipeModel recipeModel){
    return {
      "about": recipeModel.about,
      "about_en": recipeModel.about_en,
      "company": recipeModel.company,
      "difficulty": recipeModel.difficulty,
      "difficulty_en": recipeModel.difficulty_en,
      "image": recipeModel.image,
      "ingredients_name": recipeModel.ingredients_name,
      "ingredients_name_en": recipeModel.ingredients_name_en,
      "num_items": recipeModel.num_items,
      "prep": recipeModel.prep,
      "prep_en": recipeModel.prep_en,
      "prep_steps": recipeModel.prep_steps,
      "quantity": recipeModel.quantity,
      "quantity_en": recipeModel.quantity_en,
      "servings": recipeModel.servings,
      "title": recipeModel.title,
      "title_en": recipeModel.title_en,
      "type": recipeModel.type,
      "time": recipeModel.time,
      "id": recipeModel.id,
    };
  }

}