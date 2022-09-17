
import 'package:barboraapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:barboraapp/bloc/auth_bloc/auth_state.dart';
import 'package:barboraapp/bloc/cart_bloc/cart_bloc.dart';
import 'package:barboraapp/bloc/cart_bloc/cart_state.dart';
import 'package:barboraapp/bloc/home_bloc/search_bloc/search_bloc.dart';
import 'package:barboraapp/bloc/home_bloc/search_bloc/search_state.dart';
import 'package:barboraapp/bloc/product_bloc/product_bloc.dart';
import 'package:barboraapp/data/models/product_model.dart';
import 'package:barboraapp/data/models/sort_model.dart';

import 'package:barboraapp/screeens/book_screen.dart';
import 'package:barboraapp/screeens/product_detail.dart';
import 'package:barboraapp/screeens/widgets/cart_oderList_widget.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:barboraapp/screeens/widgets/expandable_widget.dart';
import 'package:barboraapp/screeens/widgets/product_carousel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../l10n/generated_files/app_localizations.dart';

class CartOrderScreen extends StatefulWidget {
  @override
  _CartOrderScreenState createState() => _CartOrderScreenState();
}

class _CartOrderScreenState extends State<CartOrderScreen> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late TextEditingController _searchController;

  @override
  void initState() {
    // TODO: implement initState
    _searchController = TextEditingController();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        FocusManager.instance.primaryFocus!.unfocus();
        BlocProvider.of<SearchBloc>(context).searchOff();
        return true;
      },
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, searchState){
          return Scaffold(
            appBar: AppBar(
              title: searchState is SearchOnState
                ? productAppBar(
                  cancelText: AppLocalizations.of(context)!.cancel,
                  hintText: AppLocalizations.of(context)!.productSearch,
                  textEditingController: _searchController,
                  controller: _controller,
                  searchState: searchState is SearchOnState,
                  textFieldFunc:  (){

                  },
                  queryFunc: (String queryText){
                    if(queryText.isEmpty){
                      BlocProvider.of<SearchBloc>(context).searchQuery(
                        (searchState as SearchOnState).searchProducts,
                        queryText.toLowerCase(),
                        false
                      );
                    }else{
                      BlocProvider.of<SearchBloc>(context).searchQuery(
                        (searchState as SearchOnState).searchProducts,
                        queryText.toLowerCase(),
                        true
                      );
                    }
                  },
                  iconButtonFunc: (){
                    BlocProvider.of<SearchBloc>(context).searchQuery(
                      (searchState as SearchOnState).searchProducts,
                      "",
                      false
                    );
                    _searchController.text = "";
                  },
                  cancelFunc: (){
                    BlocProvider.of<SearchBloc>(context).searchOff();
                    //_controller.reverse();
                    _searchController.text = "";
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  widthValue: null,
                  showIcon: (searchState is SearchOnState) ? searchState.showSuffix : false,
                  autoFocus: true
                ) : Text(
                  AppLocalizations.of(context)!.cart,
                ),
              centerTitle: true,
              actions: searchState is SearchOnState
                ? const [SizedBox()]
                : [
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: (){
                      BlocProvider.of<SearchBloc>(context).searchOn();
                    },
                  )
                ],
              backgroundColor: const Color(0xffE32323),
            ),
            persistentFooterButtons: (searchState is! SearchOnState)? [
              BlocBuilder<CartBloc, CartState>(
                builder: (context, cartState){
                  if(cartState is CartFetchedState && cartState.cartProducts.isNotEmpty){
                    return MaterialButton(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                AppLocalizations.of(context)!.buy,
                                style: const TextStyle(color: Colors.white, fontSize: 16.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                "€${BlocProvider.of<CartBloc>(context).finalPrice(cartState.cartProducts)}",
                                style: const TextStyle(color: Colors.white, fontSize: 16.0)),
                            ),
                          ],
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      color: const Color(0xffE32323),
                      onPressed: (){
                        if(double.parse(BlocProvider.of<CartBloc>(context).finalPrice(cartState.cartProducts)) > 20.68){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BookScreen(showProgressBar: true)
                            )
                          );
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            getSnackBar(context, BlocProvider.of<CartBloc>(context).getMinimumAmount(cartState.cartProducts))
                          );
                        }
                      },
                    );
                  }else{
                    return const SizedBox(height: 0.0, width: 0.0,);
                  };
                },
              ),
            ]: [],
            body: searchState is SearchOnState
                ? Container(
                  color: Colors.white,
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state){
                      return (state is SearchOnState && state.searchProducts.isNotEmpty)
                          ?  ListView.builder(
                            itemBuilder: (context, index){
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      state.searchProducts[index].titleEn,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 14.0
                                      ),
                                    ),
                                    leading: Image.network(
                                      state.searchProducts[index].image
                                    ),
                                    trailing: Text(
                                      "€" + state.searchProducts[index].original_cost,
                                      style: const TextStyle(
                                        color: Color(0xffE32323),
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetailScreen(
                                            productModel: state.searchProducts[index]
                                          )
                                        )
                                      );
                                    },
                                  ),
                                  const Divider(thickness: 1.5,)
                                ],
                              );
                            },
                            itemCount: state.searchProducts.length,
                          )
                          : const Center(
                            child: CircularProgressIndicator(
                              color: Colors.red,
                              backgroundColor: Colors.green,
                          ),
                      );
                    },
                  ),
               )
              : BlocProvider(
                create: (context) => BlocProvider.of<CartBloc>(context),
                child: CartOrderListWidget(),
            ),
          );
        },
      ),
    );
  }
}
