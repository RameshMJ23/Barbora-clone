
import 'package:barboraapp/bloc/product_bloc/product_bloc.dart';
import 'package:barboraapp/bloc/product_bloc/product_state.dart';
import 'package:barboraapp/bloc/product_detail_bloc/product_detail_bloc.dart';
import 'package:barboraapp/screeens/product_detail.dart';
import 'package:barboraapp/screeens/widgets/offer_custom_paint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/auth_bloc/auth_state.dart';
import '../../bloc/cart_bloc/cart_bloc.dart';
import '../../bloc/cart_bloc/cart_state.dart';
import '../../data/models/product_model.dart';
import 'constants.dart';

class ProductGridList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductState>(
      builder: (context, state){
        return (state is FetchedProductState)
          ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 240.0
            ),
            itemBuilder: (context, index){
              return GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 0.5),
                    color: Colors.white
                  ),
                  height: 150.0,
                  child: Column(
                    //mainAxisSize: MainAxisSize.max,
                    children: [
                      Hero(
                        child:Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  state.products[index].image
                              ),
                              fit: BoxFit.contain
                            )
                          ),
                          child: SizedBox(
                            child: Stack(
                              children: _getTopPortionOfProduct(
                                state.products[index].isOffer,
                                state.products[index].off_percent
                              ),
                            ),
                            width: double.infinity,
                          ),
                          height: 110.0,
                        ),
                        tag: state.products[index].id,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    state.products[index].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                  ),
                                )
                              ),
                              Text(
                                "€ ${state.products[index].net_cost}",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey.shade600
                                ),
                              ),
                              Padding(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "€ ${state.products[index].original_cost}",
                                      style: const TextStyle(
                                        color:  Color(0xffE32323),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0
                                      ),
                                    ),
                                    state.products[index].off_cost != null
                                     ? Padding(
                                      child: Text(
                                        state.products[index].off_cost!,
                                        style: const TextStyle(
                                          decoration: TextDecoration.lineThrough,
                                          color: Colors.grey,
                                          fontSize: 12.0
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    )
                                     : const SizedBox(height: 0.0,width: 0.0,)
                                  ],
                                ),
                                padding: const EdgeInsets.only(bottom: 5.0),
                              ),
                              //const Spacer(),
                              SizedBox(
                                width: double.infinity,
                                child: BlocBuilder<CartBloc,CartState>(
                                  builder: (context, cartState){
                                    if(cartState is CartFetchedState){
                                      if(BlocProvider.of<CartBloc>(context).checkItem(state.products[index].id)){

                                        ProductModel cartProduct = BlocProvider.of<CartBloc>(context).getSameProduct(state.products[index].id);

                                        return itemCountButton(
                                            height: 35.0,
                                            radius: 5.0,
                                            textColor: Colors.grey.shade600,
                                            horizontalPad: 5.0,
                                            verticalPad: 6.5,
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
                                          state.products[index],
                                          radius: 8.0
                                        );
                                      }
                                    }else{
                                      return addToCartButton(
                                        context,
                                        state.products[index],
                                        radius: 8.0
                                      );
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ProductDetailScreen(
                        productModel: state.products[index]
                      )
                    )
                  );
                },
              );
            },
            itemCount: state.products.length,
        )
          : const Center(
            child: CircularProgressIndicator(),
        );
      },
    );
  }

  List<Widget> _getTopPortionOfProduct(bool isOffer, String? offPercent){
    return isOffer == true
        ? [
      const Positioned(
        child: Icon(
          Icons.favorite_border,
          color: Colors.grey,
        ),
        top: 15.0,
        right: 15.0,
      ),
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
    : const [
      Positioned(
        child: Icon(
          Icons.favorite_border,
          color: Colors.grey,
        ),
        top: 15.0,
        right: 15.0,
      )
    ];
  }
}
