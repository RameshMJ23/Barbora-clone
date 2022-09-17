
import 'package:barboraapp/bloc/cart_bloc/discount_field_bloc/discount_field_bloc.dart';
import 'package:barboraapp/l10n/generated_files/app_localizations.dart';
import 'package:barboraapp/screeens/product_detail.dart';
import 'package:barboraapp/screeens/widgets/product_carousel.dart';
import 'package:barboraapp/screeens/widgets/progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/auth_bloc/auth_state.dart';
import '../../bloc/cart_bloc/cart_bloc.dart';
import '../../bloc/cart_bloc/cart_state.dart';
import '../../bloc/home_bloc/save_product_bloc/check_bloc/check_bloc.dart';
import '../../bloc/home_bloc/save_product_bloc/existing_fav_cart_bloc/existing_fav_cart_bloc.dart';
import '../../bloc/home_bloc/save_product_bloc/save_product_bloc.dart';
import '../../bloc/product_bloc/product_bloc.dart';
import '../../data/models/product_model.dart';
import 'constants.dart';
import 'expandable_widget.dart';

class CartOrderListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState){
        return (cartState is CartFetchedState && cartState.cartProducts.isNotEmpty)
          ? ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      children: [
                        ProgressWidget(status: ProgressWidgetStatus.cart),
                        const Divider(thickness: 2.0,),
                        Column(
                          children: cartState.cartProducts.map((product){
                            return Column(
                              children: [
                                GestureDetector(
                                  child: Row(
                                    children: [
                                      Hero(
                                        child: Image.network(
                                          product.image,
                                          height: 70.0,
                                          width: 120.0,
                                        ),
                                        tag: "cart" + product.id,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                          child: Column(
                                            //mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(product.titleEn),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 3.0),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      child: Text(
                                                        "€" + product.original_cost,
                                                        style: const TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 16.0,
                                                          fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      padding: const EdgeInsets.only(right: 10.0),
                                                    ),
                                                    Text(
                                                      "€" + product.net_cost,
                                                      style: TextStyle(
                                                        color: Colors.grey.shade500,
                                                        fontSize: 14.0,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              itemCountButton(
                                                  textColor: Colors.grey.shade600,
                                                  horizontalPad: 2.0,
                                                  addButton: () async{
                                                    if(product.measurement >= double.parse(product.maxQuantity)){
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                          getSnackBar(context, "You have reached the maximum quantity for this product", topPadding: 250.0)
                                                      );
                                                    }else{
                                                      BlocProvider.of<CartBloc>(context).addQuantity(
                                                          (BlocProvider.of<AuthBloc>(context).state as UserState).uid,
                                                          product.id,
                                                          double.parse((product.measurement + product.stepMeasurement).toStringAsFixed(1))
                                                      );
                                                    }
                                                  },
                                                  subButton: () async{
                                                    if(product.measurement <= product.stepMeasurement){
                                                      BlocProvider.of<CartBloc>(context).removeProductFromCart(
                                                        (BlocProvider.of<AuthBloc>(context).state as UserState).uid,
                                                        product.id,
                                                      );
                                                    }else{
                                                      BlocProvider.of<CartBloc>(context).subtractQuantity(
                                                          (BlocProvider.of<AuthBloc>(context).state as UserState).uid,
                                                          product.id,
                                                          product.measurement - product.stepMeasurement
                                                      );
                                                    }
                                                  },
                                                  unit: product.unit == UnitType.kg ? "kg" : "units",
                                                  quantity: product.unit == UnitType.kg ? product.measurement.toString(): product.measurement.toInt().toString()
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Column(
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.clear,
                                                color: Colors.red,
                                              ),
                                              onPressed: (){
                                                BlocProvider.of<CartBloc>(context).removeProductFromCart(
                                                  (BlocProvider.of<AuthBloc>(context).state as UserState).uid,
                                                  product.id,
                                                );
                                              },
                                            ),
                                            Text(AppLocalizations.of(context)!.similar),
                                            Transform.scale(
                                              child: Checkbox(
                                                checkColor: Colors.white,
                                                fillColor: MaterialStateProperty.all(Colors.green),
                                                value: product.similar,
                                                side: const BorderSide(color: Colors.black87),
                                                onChanged: (val){
                                                  BlocProvider.of<CartBloc>(context).updateSimilar(
                                                    (BlocProvider.of<AuthBloc>(context).state as UserState).uid,
                                                    product.id,
                                                    val!
                                                  );
                                                },
                                              ),
                                              scale: 1.5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(productModel: product)));
                                  },
                                ),
                                const Divider(),
                              ],
                            );
                          }).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:  [
                              const Icon(
                                Icons.favorite_border
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                child: Text(
                                  AppLocalizations.of(context)!.saveCart
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    decoration: getContainerDecoration(),
                  ),
                  const SizedBox(height: 20.0,),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: BlocProvider.value(
                      value: DiscountFieldBloc(),
                      child: DiscountExpandable(),
                    ),
                    decoration: getContainerDecoration(),
                  ),
                  const SizedBox(height: 20.0,),
                  Container(
                    decoration: getContainerDecoration(),
                    padding:  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _amountBuilder("Approximate amount", "€ ${BlocProvider.of<CartBloc>(context).getApproxAmount(cartState.cartProducts)}"),
                        _amountBuilder("Donations price", "€ 0.00"),
                        _amountBuilder("Packing price", "€ 0.69"),
                        _amountBuilder("Discount", "-€ ${BlocProvider.of<CartBloc>(context).getDiscount(cartState.cartProducts)}", isBold: true),
                        _amountBuilder("Receive AČIŪ money", "€ 0.00", isBold: true),
                        const Divider(),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: _amountBuilder("Final price", "€${BlocProvider.of<CartBloc>(context).finalPrice(cartState.cartProducts)}", isBold: true),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: BlocProvider.of<CartBloc>(context).getMinimumPercent(cartState.cartProducts) < 1.0
                             ? _costIndicator(
                              context,
                              BlocProvider.of<CartBloc>(context).getMinimumPercent(cartState.cartProducts),
                              Colors.orange.shade500,
                              Colors.orange.shade100
                            )
                            : BlocProvider.of<CartBloc>(context).getFreeDeliveryPercent(cartState.cartProducts) > 1.0
                            ? _costIndicator(
                              context, 1.0,
                              Colors.green.shade500,
                              Colors.green.shade100
                            )
                           : _costIndicator(
                            context,
                            BlocProvider.of<CartBloc>(context).getFreeDeliveryPercent(cartState.cartProducts),
                            Colors.green.shade500,
                            Colors.green.shade100
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            BlocProvider.of<CartBloc>(context).getMinimumAmount(cartState.cartProducts),
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    child: Text(
                      "Recommendations",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  MultiBlocProvider(
                    providers: [
                      BlocProvider<ProductBloc>(create: (context) => ProductBloc(collectionName: "product_recommended")),
                      BlocProvider<CartBloc>(create: (context) => CartBloc()),
                      BlocProvider(create: (context) => SaveProductBloc()),
                      BlocProvider(create: (context) => ExistingFavCartBloc(uid: (BlocProvider.of<AuthBloc>(context).state as UserState).uid)),
                      BlocProvider(create: (context)=> CheckBloc())
                    ],
                    child: ProductCarousel(),
                  )
                ],
              ),
            ]
          ) : cartState is CartLoadingState
          ? const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.green,
              color: Colors.red,
            ),
          )
          : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/basket.svg",
                  color: Colors.grey.shade400,
                ),
                const Padding(
                  child: Text(
                    "Your cart is empty. We invite you to return to store",
                    style: TextStyle(
                        fontSize: 25.0
                    ),
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                )
              ],
            ),
         );
      },
    );
  }

  Widget _amountBuilder(String amountName, String amount, {bool isBold = false})=> Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            amountName,
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.w300
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            amount,
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.w300
            ),
          ),
        ),

      ],
    ),
  );

  Widget _costIndicator(BuildContext context, double percent, Color priColor, Color secColor) => LinearPercentIndicator(
    //width: double.infinity,
    lineHeight: 6.0,
    progressColor: priColor,
    percent: percent,
    backgroundColor: secColor,
    barRadius: const Radius.circular(10.0),
    padding: const EdgeInsets.symmetric(horizontal: 3.0),
  );
}
