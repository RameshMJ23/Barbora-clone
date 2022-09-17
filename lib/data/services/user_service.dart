

import 'dart:developer';
import 'package:barboraapp/data/models/address_model.dart';
import 'package:barboraapp/data/models/product_model.dart';
import 'package:barboraapp/data/models/recipe_model.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class UserService{

  final CollectionReference _userRef = FirebaseFirestore.instance.collection("user_data");

  storeCartData(String uid, ProductModel productModel) async{
    await _userRef.doc(uid).collection("cart").doc(productModel.id).set({
      "bottom_info_content": {
        "lt": productModel.bottomInfoContent,
        "en": productModel.bottomInfoContentEn
      },
      "bottom_info_title": {
        "lt": productModel.bottomInfoTitle,
        "en": productModel.bottomInfoTitleEn
      },
      "image": productModel.image,
      "isOffer": productModel.isOffer,
      "net_cost": productModel.net_cost,
      "off_cost": productModel.off_cost,
      "off_percent": productModel.off_percent,
      "original_cost": productModel.original_cost,
      "title": productModel.title,
      "title_en": productModel.titleEn,
      "upper_info_content": {
        "lt": productModel.upperInfoContent,
        "en": productModel.upperInfoContentEn
      },
      "upper_info_title": {
        "lt": productModel.upperInfoTitle,
        "en": productModel.upperInfoTitleEn
      },
      "validity": productModel.validity,
      "max_quantity": productModel.maxQuantity,
      "id": productModel.id,
      "unit": (productModel.unit == UnitType.kg) ? "kg": "unit",
      "measurement": (productModel.measurement + productModel.stepMeasurement).toStringAsFixed(1),
      "step_measurement": productModel.stepMeasurement.toString(),
      "similar": productModel.similar
    });
  }

  List<ProductModel> _getCartListFromSnapshot(QuerySnapshot snapshot){
    if(snapshot.docs.isNotEmpty){
      return snapshot.docs.map(ProductModel.productFromList).toList();
    }else{
      return [];
    }
  }

  Stream<List<ProductModel>> getCart(String uid) {
    return _userRef.doc(uid).collection("cart").snapshots().map(_getCartListFromSnapshot);
  }

  Future removeProduct({required String uid,required String productCode}) async{
    await _userRef.doc(uid).collection("cart").doc(productCode).delete();
  }

  Future updateProduct({
    required String uid,
    required String productCode,
    required Updatable updatable,
    required var value
  }) async{

    String field = _getField(updatable);

    await _userRef.doc(uid).collection("cart").doc(productCode).update({
      field: value
    });
  }

  String _getField(Updatable updatable){
    switch(updatable){
      case Updatable.similar:
        return "similar";
      case Updatable.add:
        return "measurement";
      case Updatable.subtract:
        return "measurement";
    }
  }

  Future setUserAddress(String uid, String firebaseAddressId, AddressModel address) async{

    log(uid);
    log("From address bloc: new address added");
    return await _userRef.doc(uid)
        .collection("address")
        .doc(firebaseAddressId)
        .set(AddressModel.addressModelToFireData(address));
  }

  Future updateUserAddress(String uid, String firebaseAddressId, AddressModel address) async{

    log("From User SErvice update method ========== $firebaseAddressId");
    return await _userRef.doc(uid)
        .collection("address")
        .doc(firebaseAddressId)
        .update(AddressModel.addressModelToFireData(address));
  }


  Future setNewUserAddress(String uid, String firebaseAddressId, AddressModel address) async{
    log(uid);
    log("From address bloc: new address added ===========================");
    return await _userRef.doc(uid).collection("address").doc(firebaseAddressId).set(
        AddressModel.addressModelToFireData(address)
    );
  }

  Future deleteUserAddress(String uid, String firebaseAddressId) async{
    return await _userRef.doc(uid).collection("address").doc(firebaseAddressId).delete();
  }

  List<AddressModel> _addressFromFirebase(QuerySnapshot querySnapshot){
    return querySnapshot.docs.map(AddressModel.fromFireDataToModel).toList();
  }

  Stream<List<AddressModel>> getUserAddresses(String uid){
    return _userRef.doc(uid).collection("address").snapshots().map(_addressFromFirebase);
  }

  Future createFavouriteProducts(String uid, String cartName, ProductModel productModel) async{
    return await _userRef.doc(uid).collection("favourite").doc("products").collection(cartName).add(
      ProductModel.productModelToFirebaseData(productModel)
    );
  }

  Future createFavouriteProductNameList(String uid, List cartList) async{
    return await _userRef.doc(uid).collection("favourite").doc("products").collection("names").doc("name_list").set({
      "nameList" : cartList
    });
  }

  Future<DocumentSnapshot> getFavouriteProductCartNameList(String uid){
    return _userRef.doc(uid).collection("favourite").doc("products").collection("names").doc("name_list").get();
  }

  Stream<DocumentSnapshot> getFavouriteProductCartNameStream(String uid){
    return _userRef.doc(uid).collection("favourite").doc("products").collection("names").doc("name_list").snapshots();
  }

  //To save recipes
  Future saveFavRecipe(String uid, RecipeModel recipeModel) async{
    return await _userRef.doc(uid).collection("favourite").doc("recipe").collection("saved_recipe").doc(recipeModel.id).set(
      RecipeModel.recipeToFirebaseData(recipeModel)
    );
  }

  //Stream of saved recipes
  Stream<List<RecipeModel>> savedRecipeStream(String uid){
    return _userRef.doc(uid).collection("favourite").doc("recipe").collection("saved_recipe").snapshots().map(firebaseDataToRecipeModel);
  }

  Future unSaveRecipe(String uid, String id){
    return _userRef.doc(uid).collection("favourite").doc("recipe").collection("saved_recipe").doc(id).delete();
  }

  List<RecipeModel> firebaseDataToRecipeModel(QuerySnapshot snapshot){
    return snapshot.docs.map((e) => RecipeModel.recipeModelFromFirebaseData(e)).toList();
  }
}
