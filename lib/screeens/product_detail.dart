import 'package:barboraapp/bloc/product_bloc/product_bloc.dart';
import 'package:barboraapp/bloc/product_bloc/product_state.dart';
import 'package:barboraapp/data/models/product_model.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:barboraapp/screeens/widgets/offer_custom_paint.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc/auth_bloc.dart';
import '../bloc/auth_bloc/auth_state.dart';
import '../bloc/cart_bloc/cart_bloc.dart';
import '../bloc/cart_bloc/cart_state.dart';

class ProductDetailScreen extends StatelessWidget {

  ProductModel productModel;

  bool cartProduct;

  ProductDetailScreen({required this.productModel, this.cartProduct = false});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("About the product"),
        centerTitle: true,
        backgroundColor: const Color(0xffE32323),
        leading: getAppLeadingWidget(context),
      ),
      body: ListView(
        children: [
          Hero(
            tag: cartProduct ? "cart" + productModel.id : productModel.id,
            child: Container(
              child: Stack(
                children: [
                  Image.network(
                    productModel.image,
                    height: 250.0,
                    width: double.infinity,
                  ),
                  productModel.isOffer ? Positioned(
                    child: CustomPaint(
                      size: Size(50, (50*1).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                      painter: RPSCustomPainter(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        child: Text(
                          productModel.off_percent == null ? "%" : "${productModel.off_percent}%",
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.red,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    top: 0.0,
                    left: 20.0,
                  ): const SizedBox(height: 0.0,width: 0.0,),
                  Positioned(
                    right: 15.0,
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border,size: 30.0,color: Colors.grey,),
                      onPressed: (){

                      },
                    ),
                  )
                ],
              ),
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productModel.title.trim(),
                  style: const TextStyle(
                    fontSize: 20.0
                  ),
                ),
                productModel.validity != null
                  ? Padding(
                    child: Text(
                      "Offer valid until ${productModel.validity}",
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14.0
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                  )
                  : const SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: getCostWidget(productModel.isOffer),
                          ),
                          Text(
                            "€" + productModel.net_cost,
                            style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey[600]
                            ),
                          )
                        ],
                      ),
                    ),
                    //repeated
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: BlocBuilder<CartBloc,CartState>(
                        builder: (context, cartState){
                          if(cartState is CartFetchedState){
                            if(BlocProvider.of<CartBloc>(context).checkItem(productModel.id)){

                              ProductModel cartProduct = BlocProvider.of<CartBloc>(context).getSameProduct(productModel.id);

                              return itemCountButton(
                                height: 35.0,
                                //radius: 25.0,
                                  textColor: Colors.grey.shade600,
                                  horizontalPad: 2.0,
                                  addButton: () async{
                                    if(cartProduct.measurement >= double.parse(cartProduct.maxQuantity)){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          getSnackBar(context, "You have reached the maximum quantity for this product", topPadding: 250.0)
                                      );
                                    }else{
                                      BlocProvider.of<CartBloc>(context).addQuantity(
                                          (BlocProvider.of<AuthBloc>(context).state as UserState).uid,
                                          cartProduct.id,
                                          cartProduct.measurement + cartProduct.stepMeasurement
                                      );
                                    }
                                  },
                                  subButton: () async{

                                    if(cartProduct.measurement <= cartProduct.stepMeasurement){
                                      BlocProvider.of<CartBloc>(context).removeProductFromCart(
                                        (BlocProvider.of<AuthBloc>(context).state as UserState).uid,
                                        cartProduct.id,
                                      );
                                    }else{
                                      BlocProvider.of<CartBloc>(context).subtractQuantity(
                                          (BlocProvider.of<AuthBloc>(context).state as UserState).uid,
                                          cartProduct.id,
                                          cartProduct.measurement - cartProduct.stepMeasurement
                                      );
                                    }
                                  },
                                  unit: cartProduct.unit == UnitType.kg ? "kg" : "units",
                                  quantity: cartProduct.unit == UnitType.kg ? cartProduct.measurement.toString(): cartProduct.measurement.toInt().toString()
                              );
                            }else{
                              return addToCartButton(
                                context,
                                productModel,
                                radius: 5.0,
                                padding: 10.0
                              );
                            }
                          }else{
                            return addToCartButton(
                              context,
                              productModel,
                              radius: 5.0,
                                padding: 10.0
                            );
                          }
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 5.0,),
          (productModel.upperInfoTitleEn != null && productModel.upperInfoContentEn !=null)
          ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: productModel.upperInfoTitleEn!.mapIndexed((index, text) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        text + ":",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Text(
                      productModel.upperInfoContentEn![index],
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0
                      )
                    )
                  ],
                );
              }).toList(),
            ),
          )
          : SizedBox(),
          const Divider(thickness: 2.5,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: productModel.bottomInfoTitleEn.mapIndexed((index, text) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                            //fontWeight: FontWeight.w600,
                              fontSize: 15.0
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                            productModel.bottomInfoContentEn[index],
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15.0
                            )
                        )
                      ],
                    ),
                    Divider(thickness: 1.5,)
                  ],
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
  
  Widget getCostWidget(bool isOffer){
    return isOffer ? Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "€" + productModel.original_cost,
          style: TextStyle(
              decoration: TextDecoration.lineThrough,
              fontWeight: FontWeight.w700,
              color: Colors.grey[500],
              fontSize: 16.0
          ),
          textAlign: TextAlign.start,
        ),
        Text(
          "€" + productModel.off_cost!,
          style: const TextStyle(
            color: Color(0xffE32323),
            fontSize: 22.0,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.start,
        ),
      ],
    ): Text(
      "€" + productModel.original_cost,
      style: const TextStyle(
        color: Color(0xffE32323),
        fontSize: 25.0,
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.start,
    );
  }
}
