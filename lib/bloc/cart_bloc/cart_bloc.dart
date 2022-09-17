

import 'package:barboraapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:barboraapp/bloc/auth_bloc/auth_state.dart';
import 'package:barboraapp/bloc/cart_bloc/cart_state.dart';
import 'package:barboraapp/data/models/product_model.dart';
import 'package:barboraapp/data/services/user_service.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class CartBloc extends Cubit<CartState>{

  CartBloc():super(CartLoadingState()){

    AuthBloc().stream.listen((authState){
      if(authState is UserState){
        UserService().getCart(authState.uid).listen((products) {
          if(isClosed) return;
          emit(CartFetchedState(cartProducts: products));
        });
      }else if(authState is LoadingState){
        emit(CartLoadingState());
      }else{
        if(isClosed) return;
        //emit(CartLoadingState());
        emit(NoCartState());
      }
    });
  }

  bool checkItem(String itemId){
    final resultList = (state as CartFetchedState).cartProducts.where((product){
      return product.id == itemId ? true: false;
    });

    if(resultList.isEmpty){
      return false;
    }else{
      return true;
    }
  }

  addProductToCart(String uid, ProductModel productModel) async{
    await UserService().storeCartData(uid, productModel);
  }

  removeProductFromCart(String uid, String productId) async{
    await UserService().removeProduct(uid: uid, productCode: productId);
  }

  updateSimilar(String uid, String productId, bool value) async{
    await UserService().updateProduct(
      uid: uid,
      productCode: productId,
      updatable: Updatable.similar,
      value: value
    );
  }

  addQuantity(String uid, String productId, double value) async{
    await UserService().updateProduct(
        uid: uid,
        productCode: productId,
        updatable: Updatable.add,
        value: value.toStringAsFixed(1)
    );
  }

  subtractQuantity(String uid, String productId, double value) async{
    await UserService().updateProduct(
        uid: uid,
        productCode: productId,
        updatable: Updatable.subtract,
        value: value.toStringAsFixed(1)
    );
  }

  ProductModel getSameProduct(String productId){
    return (state as CartFetchedState).cartProducts.firstWhere((product) => product.id == productId);
  }

  String getSingleItemCost(ProductModel productModel){
    if(productModel.isOffer){
      return getOfferedCost(productModel);
    }else{
      return getCost(productModel);
    }
  }

  String getOfferedCost(ProductModel productModel){
    return (double.parse(productModel.off_cost!) * productModel.measurement).toStringAsFixed(2);
  }

  String getCost(ProductModel productModel){
    return (double.parse(productModel.original_cost) * productModel.measurement).toStringAsFixed(2);
  }

  String getApproxAmount(List<ProductModel> productList){

    double approxAmount = 0;

    productList.map((products){
      approxAmount += double.parse(getCost(products));
    }).toList();

    return approxAmount.toStringAsFixed(2);
  }

  String getDiscount(List<ProductModel> productList){

    double discount = 0;

    List<ProductModel> offerProducts = productList.where((e) => e.isOffer).toList();

    offerProducts.map((product){
      discount += double.parse(getCost(product)) - double.parse(getOfferedCost(product));
    }).toList();

    return discount.toStringAsFixed(2);
  }


  String finalPrice(List<ProductModel> productList){
    return (double.parse(getApproxAmount(productList)) - double.parse(getDiscount(productList))).toStringAsFixed(2);
  }
  
  double getMinimumPercent(List<ProductModel> productList){
    return double.parse((double.parse(finalPrice(productList)) / 20.68).toStringAsFixed(2));
  }

  double getFreeDeliveryPercent(List<ProductModel> productList){
    return double.parse((double.parse(finalPrice(productList)) / 60.68).toStringAsFixed(2));
  }

  String getMinimumAmount(List<ProductModel> productList){
    return double.parse(finalPrice(productList)) > 20.68
      ? double.parse(finalPrice(productList)) > 60.68
        ? "We'll deliver your order for FREE!"
        :"€ ${(60.68 - double.parse(finalPrice(productList))).toStringAsFixed(2)} until free delivery"
      : "€ ${(20.68 - double.parse(finalPrice(productList))).toStringAsFixed(2)} to reach minimum order amount";
  }

  @override
  Future<void> close() async{
    // TODO: implement close
    //return super.close();
    return;
  }

}