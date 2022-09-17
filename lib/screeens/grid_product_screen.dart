import 'dart:developer';

import 'package:barboraapp/bloc/cart_bloc/cart_bloc.dart';
import 'package:barboraapp/bloc/filter_bloc/filter_bloc.dart';
import 'package:barboraapp/bloc/product_bloc/product_bloc.dart';
import 'package:barboraapp/bloc/product_bloc/product_state.dart';
import 'package:barboraapp/bloc/product_detail_bloc/product_detail_bloc.dart';
import 'package:barboraapp/data/models/discount_model.dart';
import 'package:barboraapp/data/models/filter_model.dart';
import 'package:barboraapp/data/models/sort_model.dart';
import 'package:barboraapp/data/services/product_service.dart';

import 'package:barboraapp/screeens/product_detail.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:barboraapp/screeens/widgets/product_grid_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/filter_bloc/filter_bloc_state.dart';
import '../bloc/home_bloc/search_bloc/search_bloc.dart';
import '../bloc/home_bloc/search_bloc/search_state.dart';
import '../data/models/filter_model.dart';
import '../l10n/generated_files/app_localizations.dart';


class GridProductScreen extends StatefulWidget {

  String screenName;

  GridProductScreen(this.screenName);

  @override
  _GridProductScreenState createState() => _GridProductScreenState();
}

class _GridProductScreenState extends State<GridProductScreen> with SingleTickerProviderStateMixin{

  late List<FilterModel> _filterList;
  late AnimationController _controller;
  late TextEditingController _searchController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));

    _filterList = [
      FilterModel("Discount", discountWidget(), FilterScreenEnum.discount),
      FilterModel("Country of origin", countryWidget(), FilterScreenEnum.country),
      FilterModel("Brand", brandWidget(), FilterScreenEnum.brand)
    ];

    BlocProvider.of<ProductDetailBloc>(context).getProducts(SortEnum.defaultSort);
  }

  final List<SortModel> _sortList = [
    SortModel(sortTitle: "Default", sortValue: SortEnum.defaultSort),
    SortModel(sortTitle: "Alphabetical order(A-Z)", sortValue: SortEnum.ascendingOrder),
    SortModel(sortTitle: "Alphabetical order(Z-A)", sortValue: SortEnum.descendingOrder),
    SortModel(sortTitle: "Price from lowest", sortValue: SortEnum.priceFromLowest),
    SortModel(sortTitle: "Price from Highest", sortValue: SortEnum.priceFromHighest),
    SortModel(sortTitle: "Without discount first", sortValue: SortEnum.withoutDiscountFirst),
    SortModel(sortTitle: "With discount first", sortValue: SortEnum.withDiscountFirst),
  ];

  final List<DiscountModel> discountOptions = [
    DiscountModel(optionName: "With discount", optionValue: DiscountOptionsEnum.withDiscount),
    DiscountModel(optionName: "With AČIŪ offers", optionValue: DiscountOptionsEnum.withoutAciuOffers),
    DiscountModel(optionName: "Without discount", optionValue: DiscountOptionsEnum.withoutDiscount)
  ];

  final List<String> brandOptions = [
    "AUGA",
    "AUGMA",
    "DIMDINI",
    "Family Garden",
    "FIT & EASY",
    "Ortomad",
    "Samsonas",
    "TastyHome",
    "SUNSTREAM"
  ];

  final List<String> countryOptions = [
    "Argentine",
    "Belgium",
    "Brazil",
    "Canada",
    "Chile",
    "China",
    "Columbia",
    "CostaRica",
    "Ecuador",
    "Egypt",
    "EuropeanUnion",
    "France",
    "GreatBritain",
    "Greece",
    "Holland",
    "India",
    "Iran",
    "Israel",
    "Italy",
    "Ivory Coast(South Africa)",
    "Kazakhstan",
    "Kenya",
    "Latvia",
    "Lithuania",
    "Mexico",
    "Morocco",
    "Peru",
    "Poland",
    "Portugal",
    "South Africa",
    "Spain",
    "Thailand",
    "Tunisia",
    "Turkey",
    "USA",
    "Vietnam"
  ];

  Widget discountWidget(){
    return ListView.builder(
      itemBuilder: (context, index){
        return BlocBuilder<FilterBloc, FilterBlocState>(
          builder: (context, state){
            return RadioListTile(
              groupValue: state.discountOptionsEnum,
              value: discountOptions[index].optionValue,
              activeColor: Colors.green,
              onChanged: (val){
                BlocProvider.of<FilterBloc>(context).changeDiscount(val as DiscountOptionsEnum);
              },
              title: Text(discountOptions[index].optionName),

            );
          },
        );
      },
      itemCount: discountOptions.length,
    );
  }

  Widget countryWidget(){
    return ListView.builder(
      itemBuilder: (context, index){
        return BlocBuilder<FilterBloc, FilterBlocState>(
          builder: (context, state){
            return RadioListTile(
              groupValue: state.country,
              value: index,
              activeColor: Colors.green,
              onChanged: (val){
                BlocProvider.of<FilterBloc>(context).changeCountry(index);
              },
              title: Text(countryOptions[index])
            );
          },
        );
      },
      itemCount: countryOptions.length,
    );
  }

  Widget brandWidget(){
    return ListView.builder(
      itemBuilder: (context, index){
        return BlocBuilder<FilterBloc, FilterBlocState>(
          builder: (context, state){
            return RadioListTile(
              groupValue: state.brand,
              value: index,
              activeColor: Colors.green,
              onChanged: (val){
                BlocProvider.of<FilterBloc>(context).changeBrand(index);
              },
              title: Text(brandOptions[index]),
            );
          },
        );
      },
      itemCount: brandOptions.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductState>(
      builder: (context, state){
        return state is FetchedProductState ? BlocBuilder<SearchBloc, SearchState>(
          builder: (searchContext, searchState){
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
                  widget.screenName,
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
                leading: getAppLeadingWidget(context),
                bottom: searchState is! SearchOnState ? PreferredSize(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    color: Colors.white,
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildHeaderButtons(context, "Sort", Icons.code, (){
                            showModalBottomSheet(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0))
                                ),
                                context: context,
                                builder: (bottomSheetContext){
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.65,
                                    child: Column(
                                      children: [
                                        buildBottomSheetHeader("Sort ", Icons.close, context),
                                        Expanded(
                                          child: ListView.separated(
                                            itemCount: _sortList.length,
                                            itemBuilder: (listContext, index){
                                              return GestureDetector(
                                                child: Padding(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(_sortList[index].sortTitle, style: const TextStyle(fontSize: 16.0),),
                                                      (state as FetchedProductState).sortEnum == _sortList[index].sortValue
                                                          ? Icon(Icons.check, color: Colors.green,)
                                                          : Text("")
                                                    ],
                                                  ),
                                                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                                ),
                                                onTap: (){
                                                  Navigator.pop(context);
                                                  BlocProvider.of<ProductDetailBloc>(context).getProducts(
                                                      _sortList[index].sortValue,
                                                      discountOptionsEnum: state.discountOptionsEnum,
                                                      country: state.countryName,
                                                      brand: state.brand
                                                  );
                                                },
                                              );
                                            },
                                            separatorBuilder: (context, index){
                                              return Divider();
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                            );
                          },
                              (state as FetchedProductState).sortEnum != SortEnum.defaultSort ? true: false
                          ),
                          const VerticalDivider(color: Colors.black87, width: 2.0,),
                          Expanded(
                            child: _buildHeaderButtons(context, "Filter", Icons.filter_list, (){

                              showModalBottomSheet(
                                  useRootNavigator: true,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0))
                                  ),
                                  context: context,
                                  builder: (bottomSheetContext){
                                    return BlocProvider.value(
                                        value: BlocProvider.of<FilterBloc>(context),
                                        child: BlocBuilder<FilterBloc, FilterBlocState>(
                                          builder: (filterContext, filterState){
                                            return SizedBox(
                                              height: MediaQuery.of(context).size.height * 0.7,
                                              child: Column(
                                                children: [
                                                  buildBottomSheetHeader(
                                                      "Filter ",
                                                      Icons.close,
                                                      bottomSheetContext,
                                                      leadingIcon: filterState.filterScreenEnum != FilterScreenEnum.startScreen,
                                                      onLeadingTap: (){
                                                        BlocProvider.of<FilterBloc>(context).changeScreen(FilterScreenEnum.startScreen);
                                                      }
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                      child: (filterState.filterScreenEnum == FilterScreenEnum.startScreen)
                                                          ? filterStartScreen(context)
                                                          :(filterState.filterScreenEnum == FilterScreenEnum.discount)
                                                          ? discountWidget()
                                                          :(filterState.filterScreenEnum == FilterScreenEnum.brand)
                                                          ? brandWidget()
                                                          : countryWidget(),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                                                    child: getConfirmationButton(
                                                        buttonName: "Clear all filter",
                                                        onPressed: (){

                                                        },
                                                        side: true,
                                                        buttonColor: Colors.transparent,
                                                        buttonNameColor: Colors.grey.shade700
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                                                    child: getConfirmationButton(
                                                      buttonName: "Filter",
                                                      onPressed: (){
                                                        Navigator.pop(bottomSheetContext);
                                                        BlocProvider.of<ProductDetailBloc>(context).getProducts(
                                                            state.sortEnum,
                                                            discountOptionsEnum: filterState.discountOptionsEnum,
                                                            country: filterState.country.isNegative ? " " : countryOptions[filterState.country],
                                                            brand: filterState.country.isNegative ? " " : brandOptions[filterState.brand]
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        )
                                    );
                                  }
                              );
                            },
                                (state.discountOptionsEnum != DiscountOptionsEnum.none || state.brand.isNotEmpty || state.countryName.isNotEmpty)
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  preferredSize: const Size(double.infinity, 45.0),
                ): null,
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
              ): BlocProvider.value(
                  value: CartBloc(),
                  child: ProductGridList(),
                ),
              );
          },
        ): const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.red,
              backgroundColor: Colors.green,
            ),
          ),
        );
      },
    );
  }

  Widget filterStartScreen(BuildContext context){
    return ListView.separated(
      itemCount: _filterList.length,
      itemBuilder: (listContext, index){
        return ListTile(
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          minVerticalPadding: 0.0,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          title: Text(
            _filterList[index].filterName
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 18.0,
          ),
          onTap: (){
            BlocProvider.of<FilterBloc>(context).changeScreen(_filterList[index].screenEnum);
          },
        );
      },
      separatorBuilder: (context, index){
        return Divider();
      },
    );
  }

  Widget _buildHeaderButtons(BuildContext context, String buttonName, IconData iconData, VoidCallback onTap, bool isUsed) => GestureDetector(
    child: SizedBox(
      width: MediaQuery.of(context).size.width /2,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Padding(
              child: Icon(iconData),
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
            ),
            Padding(
              child: Text(buttonName, style: const TextStyle(fontWeight: FontWeight.w600),),
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
            ),
            isUsed
            ? const Align(
              child: Padding(
                child: CircleAvatar(
                  radius: 3.0,
                  backgroundColor: Colors.red,
                ),
                padding: EdgeInsets.symmetric(vertical: 3.0),
              ),
              alignment: Alignment.topRight,
            ): const SizedBox(height: 0.0, width: 0.0,)
          ],
        ),
      ),
    ),
    onTap: onTap,
  );
}

