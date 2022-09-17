import 'package:barboraapp/bloc/filter_bloc/filter_bloc.dart';
import 'package:barboraapp/bloc/product_bloc/product_bloc.dart';
import 'package:barboraapp/bloc/product_detail_bloc/product_detail_bloc.dart';
import 'package:barboraapp/screeens/grid_product_screen.dart';
import 'package:barboraapp/screeens/product_detail.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc/search_bloc/search_bloc.dart';
import '../bloc/home_bloc/search_bloc/search_state.dart';
import '../data/models/product_type_model.dart';
import '../l10n/generated_files/app_localizations.dart';


class VegAndFruitsScreen extends StatefulWidget {
  @override
  _VegAndFruitsScreenState createState() => _VegAndFruitsScreenState();
}

class _VegAndFruitsScreenState extends State<VegAndFruitsScreen> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late TextEditingController _searchController;

  final List<ProductTypeModel> _productTypeList = [
    ProductTypeModel(typeName: "All category products", isBold: true, nextScreen: BlocProvider.value(
      value: ProductDetailBloc(collectionName: "product_veg_n_fruits"),
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: FilterBloc(),
          ),
          BlocProvider.value(
            value: SearchBloc(),
          )
        ],
        child: GridProductScreen("Vegetables and fruits"),
      ),
    )),
    ProductTypeModel(typeName: "Vegetables"),
    ProductTypeModel(typeName: "Mushrooms", nextScreen: BlocProvider.value(
      value: ProductDetailBloc(collectionName: "product_veg_n_fruits", where: "mushroom"),
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: FilterBloc(),
          ),
          BlocProvider.value(
            value: SearchBloc(),
          )
        ],
        child: BlocProvider.value(
          value: FilterBloc(),
          child: GridProductScreen("Mushroom"),
        ),
      ),
    )),
    ProductTypeModel(typeName: "Fruits and berries")
  ];

  @override
  void initState() {
    // TODO: implement initState
    _searchController = TextEditingController();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (searchContext, searchState){
        return Scaffold(
          appBar: AppBar(
              leadingWidth: 35.0,
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
              ) : const Text(
                "Vegetables and fruits",
              ),
              centerTitle: true,
              backgroundColor: const Color(0xffE32323),
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
              leading: getAppLeadingWidget(context)
          ),
          body: searchState is SearchOnState
            ? Container(
              color: Colors.white,
              child: searchState.searchProducts.isNotEmpty
                  ?  ListView.builder(
                    itemBuilder: (context, index){
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              searchState.searchProducts[index].titleEn,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 14.0
                              ),
                            ),
                            leading: Image.network(
                              searchState.searchProducts[index].image
                            ),
                            trailing: Text(
                              "€" + searchState.searchProducts[index].original_cost,
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
                                      productModel: searchState.searchProducts[index]
                                    )
                                  )
                              );
                            },
                          ),
                          const Divider(thickness: 1.5,)
                        ],
                      );
                    },
                    itemCount: searchState.searchProducts.length,
                  )
              : const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                  backgroundColor: Colors.green,
                ),
              )

            )
          :ListView.separated(
            separatorBuilder: (context, index){
              return const Divider(height: 0.0,);
            },
            itemCount: _productTypeList.length,
            itemBuilder: (context, index){
              return buildProductItems(_productTypeList[index], context);
            },
          ),
        );
      },
    );
  }
}

