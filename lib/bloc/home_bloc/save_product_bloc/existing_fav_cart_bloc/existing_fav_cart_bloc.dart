

import 'dart:developer';

import 'package:barboraapp/bloc/home_bloc/save_product_bloc/existing_fav_cart_bloc/existing_fav_cart_state.dart';
import 'package:barboraapp/data/services/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExistingFavCartBloc extends Cubit<ExistingFavCartState>{

  String uid;

  ExistingFavCartBloc({required this.uid}):super(LoadingExistingFavCart()){
    UserService().getFavouriteProductCartNameStream(uid).listen((event) {
      if(event != null){
        emit(FetchedExistingFavCartState(existingFavCarts: (event.data() as Map)["nameList"]));
      }
    });
  }


  @override
  Future<void> close() async{
    // TODO: implement close
    //return super.close();
    return;
  }
}