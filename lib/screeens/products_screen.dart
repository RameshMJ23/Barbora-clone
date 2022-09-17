
import 'dart:developer';

import 'package:barboraapp/bloc/address_bloc/address_bloc.dart';
import 'package:barboraapp/bloc/home_bloc/search_bloc/search_bloc.dart';
import 'package:barboraapp/data/models/product_type_model.dart';
import '../../l10n/generated_files/app_localizations.dart';
import 'package:barboraapp/screeens/product_detail.dart';
import 'package:barboraapp/screeens/veg_n_fruits_screen.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc/search_bloc/search_state.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Tween<double> _searchTween;
  late TextEditingController _searchController;

  final List<ProductTypeModel> _productTypeList = [
    ProductTypeModel(typeName: "Special offers", isBold: true),
    ProductTypeModel(typeName: "Organic products", isBold: true),
    ProductTypeModel(typeName: "My items", isBold: true),
    ProductTypeModel(
        typeName: "Our recommendations",
        otherWidgets: CircleAvatar(
          radius: 10.0,
          child: const Text("N",style: TextStyle(color: Colors.white, fontSize: 10.0),),
          backgroundColor: Colors.green.shade800,
        ),
        isBold: true
    ),
    ProductTypeModel(typeName: "Vegetables and fruits", nextScreen: BlocProvider.value(
      value: SearchBloc(),
      child: VegAndFruitsScreen(),
    )),
    ProductTypeModel(typeName: "Dairy products and eggs"),
    ProductTypeModel(typeName: "Bread products and confectionary"),
    ProductTypeModel(typeName: "Meat, fish and culinary preparations"),
    ProductTypeModel(typeName: "Groceries"),
    ProductTypeModel(typeName: "Frozen foods"),
    ProductTypeModel(typeName: "Drinks"),
    ProductTypeModel(typeName: "Baby and kids goods"),
    ProductTypeModel(typeName: "Cosmetics and hygiene"),
    ProductTypeModel(typeName: "Cleanliness and pet goods"),
    ProductTypeModel(typeName: "Home and leisure")
  ];

  @override
  void initState() {
    // TODO: implement initState

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _searchTween = Tween<double>(begin: 0, end: 60.0);
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, searchState){
                return productAppBar(
                  cancelText: AppLocalizations.of(context)!.cancel,
                  hintText: AppLocalizations.of(context)!.productSearch,
                  textEditingController: _searchController,
                  controller: _controller,
                  searchState: searchState is SearchOnState,
                  textFieldFunc: (){
                    BlocProvider.of<SearchBloc>(context).searchOn();
                    _controller.forward();
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
                  showIcon: (searchState is SearchOnState) ? searchState.showSuffix : false,
                  cancelFunc: (){
                    _controller.reverse();
                    BlocProvider.of<SearchBloc>(context).searchOff();
                    _searchController.text = "";
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  widthValue: _searchTween
                );
              }
          ),
          centerTitle: true,
          backgroundColor: const Color(0xffE32323),
        ),
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, searchState){
            return (searchState is! SearchOnState)
              ? ListView.separated(
                separatorBuilder: (context, index){
                  return const Divider(height: 0.0,);
                },
                itemCount: _productTypeList.length,
                itemBuilder: (context, index){
                  return buildProductItems(_productTypeList[index], context);
                },
              )
              : Container(
                color: Colors.white,
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state){
                    return (state is SearchOnState && state.searchProducts.isNotEmpty)
                      ? ListView.builder(
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
                                        builder: (context) => ProductDetailScreen(productModel: state.searchProducts[index])
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
              );
          },
        ),
      ),
      onWillPop: willPopFunc
    );
  }

  Future<bool> willPopFunc() async{
    _controller.reverse();
    FocusManager.instance.primaryFocus!.unfocus();
    BlocProvider.of<SearchBloc>(context).searchOff();
    return Future.value(true);
  }
}
