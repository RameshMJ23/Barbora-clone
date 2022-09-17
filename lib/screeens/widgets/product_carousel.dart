import 'dart:developer';

import 'package:barboraapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:barboraapp/bloc/auth_bloc/auth_state.dart';
import 'package:barboraapp/bloc/cart_bloc/cart_bloc.dart';
import 'package:barboraapp/bloc/cart_bloc/cart_state.dart';
import 'package:barboraapp/bloc/home_bloc/save_product_bloc/check_bloc/check_bloc.dart';
import 'package:barboraapp/bloc/home_bloc/save_product_bloc/check_bloc/check_bloc_state.dart';
import 'package:barboraapp/bloc/home_bloc/save_product_bloc/existing_fav_cart_bloc/existing_fav_cart_state.dart';
import 'package:barboraapp/bloc/home_bloc/save_product_bloc/save_product_bloc.dart';
import 'package:barboraapp/data/models/product_model.dart';
import 'package:barboraapp/data/services/user_service.dart';
import 'package:barboraapp/screeens/product_detail.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:barboraapp/screeens/widgets/offer_custom_paint.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/home_bloc/save_product_bloc/existing_fav_cart_bloc/existing_fav_cart_bloc.dart';
import '../../bloc/product_bloc/product_bloc.dart';
import '../../bloc/product_bloc/product_state.dart';

class ProductCarousel extends StatelessWidget {

  final GlobalKey<FormFieldState> _textFieldValidator = GlobalKey<FormFieldState>();

  final TextEditingController _saveProductTextFieldController = TextEditingController();

  ProductModel? cartProduct;

  bool? productInCart;

  @override
  Widget build(BuildContext mainContext) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (productContext, state){
        return BlocBuilder<CartBloc,CartState>(
          builder: (context, cartState){
            if(state is FetchedProductState && (cartState is CartFetchedState || cartState is NoCartState)){
              return CarouselSlider.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index, pageIndex){

                  if(cartState is CartFetchedState){
                     productInCart = BlocProvider.of<CartBloc>(context).checkItem(state.products[index].id);

                    if(productInCart!){
                      cartProduct = BlocProvider.of<CartBloc>(context).getSameProduct(state.products[index].id);
                    }
                  }

                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: Container(
                        width: 180.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                offset: const Offset(1,1),
                                blurRadius: 5.0
                              )
                            ]
                        ),
                        child: Column(
                          children: [
                            Hero(
                              child: Container(
                                height: 120.0,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0) ),
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      state.products[index].image
                                    )
                                  )
                                ),
                                child: Stack(
                                  children: _getTopPortionOfProduct(
                                    state.products[index].isOffer,
                                    state.products[index].off_percent,
                                    mainContext,
                                    (){
                                      showSaveCartBottomSheet(mainContext, state.products[index]);
                                    }
                                  )
                                ),
                              ),
                              tag: state.products[index].id,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        state.products[index].titleEn,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 14.0
                                        ),
                                        maxLines: 2,
                                      ),
                                    ),
                                    _costWidget(
                                        isOffer: state.products[index].isOffer,
                                        originalCost: state.products[index].original_cost,
                                        offerCost: state.products[index].off_cost
                                    ),
                                    Text(
                                      "€" + state.products[index].net_cost,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey[600]
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: (productInCart != null && productInCart!)
                                            ? itemCountButton(
                                              height: 30.0,
                                              radius: 25.0,
                                              textColor: Colors.grey.shade600,
                                              horizontalPad: 2.0,
                                              addButton: () async{
                                                if(cartProduct!.measurement >= double.parse(cartProduct!.maxQuantity)){
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                      getSnackBar(context, "You have reached the maximum quantity for this product", topPadding: 250.0)
                                                  );
                                                }else{
                                                  BlocProvider.of<CartBloc>(context).addQuantity(
                                                      (BlocProvider.of<AuthBloc>(context).state as UserState).uid,
                                                      cartProduct!.id,
                                                      cartProduct!.measurement + cartProduct!.stepMeasurement
                                                  );
                                                }
                                              },
                                              subButton: () async{

                                                if(cartProduct!.measurement <= cartProduct!.stepMeasurement){
                                                  BlocProvider.of<CartBloc>(context).removeProductFromCart(
                                                    (BlocProvider.of<AuthBloc>(context).state as UserState).uid,
                                                    cartProduct!.id,
                                                  );
                                                }else{
                                                  BlocProvider.of<CartBloc>(context).subtractQuantity(
                                                      (BlocProvider.of<AuthBloc>(context).state as UserState).uid,
                                                      cartProduct!.id,
                                                      cartProduct!.measurement - cartProduct!.stepMeasurement
                                                  );
                                                }
                                              },
                                              unit: cartProduct!.unit == UnitType.kg ? "kg" : "units",
                                              quantity: cartProduct!.unit == UnitType.kg ? cartProduct!.measurement.toString(): cartProduct!.measurement.toInt().toString()
                                          ) : addToCartButton(
                                            context,
                                            state.products[index],
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: (){

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailScreen(productModel: state.products[index])
                          )
                      );
                    },
                  );
                },
                options: _carouselOptions(),
              );
            }else{
              return CarouselSlider.builder(
                itemCount: 3,
                itemBuilder: (context, index, pageIndex){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      width: 180.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade400,
                                offset: Offset(1,1),
                                blurRadius: 5.0
                            )
                          ]
                      ),
                      child: Column(
                        children: [
                          getShimmerWidget(height: 120.0, borderRadius: 5),
                          Expanded(
                            child: Column(
                              children: [
                                getShimmerWidget(),
                                getShimmerWidget(),
                                const Spacer(),
                                getShimmerWidget()
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                options: _carouselOptions(),
              );
            }
          },
        );
      },
    );
  }

  Widget _costWidget({required bool isOffer, required String originalCost, String? offerCost}){
    if(isOffer){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Text(
              "€" + originalCost,
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                fontWeight: FontWeight.w700,
                color: Colors.grey[500],
                fontSize: 16.0
              ),
            ),
          ),
          Text(
              "€" + offerCost!,
              style: const TextStyle(
                color: Color(0xffE32323),
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              )
          )
        ],
      );
    }else{
      return Text(
          "€" + originalCost,
          style: const TextStyle(
            color: Color(0xffE32323),
            fontSize: 17.0
          )
      );
    }
  }

  List<Widget> _getTopPortionOfProduct(bool isOffer, String? offPercent, BuildContext context, VoidCallback onPressed){
    return isOffer == true
        ? [
      getFavouriteWidget(onPressed),
      Positioned(
        child: CustomPaint(
          size: Size(45, (45*1).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: RPSCustomPainter(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            child: Text(
              offPercent == null ? "%" : "$offPercent%",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.red,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
        top: 0.0,
        left: 10.0,
      )
    ]
    : [
      getFavouriteWidget(onPressed)
    ];
  }

  getFavouriteWidget(VoidCallback onPressed) => Positioned(
    child: BlocBuilder<AuthBloc, AuthState>(
      builder: (context,state){
        return (state is UserState) ? IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.favorite_border,
            color: Colors.grey,
          )
        ): Text("");
      },
    ),
    top: 5.0,
    right: 5.0,
  );

  showSaveCartBottomSheet(BuildContext mainContext, ProductModel productModel){
    showModalBottomSheet(
        useRootNavigator: true,
        context: mainContext,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))
        ),
        builder: (context){
          return BlocProvider(
            create: (context) => BlocProvider.of<SaveProductBloc>(mainContext),
            child: BlocProvider(
              create: (context) => BlocProvider.of<ExistingFavCartBloc>(mainContext),
              child: BlocProvider(
                create: (context) =>  BlocProvider.of<CheckBloc>(mainContext),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildBottomSheetHeader(
                        "Save product",
                        Icons.close,
                        context
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "Select saved cart",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Column(
                                    children: [
                                      BlocBuilder<ExistingFavCartBloc, ExistingFavCartState>(
                                        builder: (context, state){
                                          return (state is FetchedExistingFavCartState) ? Column(
                                            children: state.existingFavCarts.mapIndexed((index, e){
                                              return BlocBuilder<CheckBloc, CheckBlocState>(
                                                builder: (context, checkList){
                                                  return ListTile(
                                                    contentPadding: EdgeInsets.zero,
                                                    leading: SizedBox(
                                                      height: 25.0,
                                                      width: 25.0,
                                                      child: Transform.scale(
                                                        child:  Checkbox(
                                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                          value: checkList.checkList.contains(index),
                                                          activeColor: Colors.green,
                                                          checkColor: Colors.white,
                                                          onChanged: (val){

                                                          },
                                                          shape: const RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(3.0)),
                                                          ),
                                                          side: BorderSide(width: 0.5, color: Colors.grey.shade700),
                                                        ),
                                                        scale: 1.5,
                                                      ),
                                                    ),
                                                    title: Text(e, style: const TextStyle(fontSize: 14.0),),
                                                    onTap: (){
                                                      BlocProvider.of<CheckBloc>(context).checkBox(index);
                                                    },
                                                  );
                                                },
                                              );
                                            }).toList(),
                                          )
                                          : const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: BlocBuilder<SaveProductBloc, bool>(
                                          builder: (context, state){
                                            return  ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              leading: SizedBox(
                                                height: 25.0,
                                                width: 25.0,
                                                child: Transform.scale(
                                                  child:  Checkbox(
                                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                    value: state,
                                                    activeColor: Colors.green,
                                                    checkColor: Colors.white,
                                                    onChanged: (val){

                                                    },
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(3.0)),
                                                    ),
                                                    side: BorderSide(width: 0.5, color: Colors.grey.shade700),
                                                  ),
                                                  scale: 1.5,
                                                ),
                                              ),
                                              title: const Text("Create a new saved cart", style: TextStyle(fontSize: 14.0),),
                                              subtitle: state
                                                  ? TextFormField(
                                                key: _textFieldValidator,
                                                validator: (val) => val!.isEmpty ? "Enter the name of the cart" : null,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(50),
                                                ],
                                                controller: _saveProductTextFieldController,
                                                decoration: InputDecoration(
                                                    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                    hintText: "Saved cart name",
                                                    focusColor: Colors.grey.shade700,
                                                    counterText: "${_saveProductTextFieldController.text.length}/50"
                                                ),
                                                style: const TextStyle(
                                                    fontSize: 13.0
                                                ),
                                              ): null,
                                              onTap: (){
                                                BlocProvider.of<SaveProductBloc>(context).checkOption(!state);
                                              },
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 3.0),
                                child: getConfirmationButton(
                                    buttonName: "Save product",
                                    onPressed: (){
                                      if(_textFieldValidator.currentState!.validate()){
                                        Navigator.pop(context);
                                        BlocProvider.of<SaveProductBloc>(mainContext).createFavourites(
                                            (BlocProvider.of<AuthBloc>(context).state as UserState).uid,
                                            _saveProductTextFieldController.text,
                                            productModel
                                        );
                                        _saveProductTextFieldController.text = "";
                                      }
                                    }
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ),
          );
        }
    );
  }

  CarouselOptions _carouselOptions() => CarouselOptions(
      height: 270,
      aspectRatio: 16/9,
      viewportFraction: 0.5,
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


