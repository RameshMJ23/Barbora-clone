
import 'dart:convert';
import 'dart:developer';

import 'package:barboraapp/data/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/product_model.dart';

class SaveProductBloc extends Cubit<bool>{

  SaveProductBloc():super(false);

  checkOption(bool value){
    emit(value);
  }

  createFavourites(String uid, String name, ProductModel productModel) async{

    List oldList = await getNameList(uid);

    bool existingCartName = oldList.contains(name);

    await UserService().createFavouriteProducts(uid, name, productModel).then((value){
      if(!existingCartName) {
        oldList.add(name);
        UserService().createFavouriteProductNameList(uid, oldList);
      }
    });
  }


  Future<List> getNameList(String uid) async{
    DocumentSnapshot nameList = await UserService().getFavouriteProductCartNameList(uid);

    return (nameList.data() as Map)["nameList"];

  }

  @override
  Future<void> close() async{
    // TODO: implement close
    return;
  }


}