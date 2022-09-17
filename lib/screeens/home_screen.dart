

import 'dart:developer';

import 'package:barboraapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:barboraapp/bloc/auth_bloc/auth_state.dart';
import 'package:barboraapp/bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'package:barboraapp/bloc/cart_bloc/cart_bloc.dart';
import 'package:barboraapp/bloc/dummy_bloc.dart';
import 'package:barboraapp/bloc/home_bloc/carousel_bloc.dart';
import 'package:barboraapp/bloc/home_bloc/save_product_bloc/check_bloc/check_bloc.dart';
import 'package:barboraapp/screeens/recipe_screen.dart';
import '../../l10n/generated_files/app_localizations.dart';
import '../bloc/home_bloc/save_product_bloc/existing_fav_cart_bloc/existing_fav_cart_bloc.dart';
import 'package:barboraapp/bloc/home_bloc/save_product_bloc/save_product_bloc.dart';
import 'package:barboraapp/bloc/home_bloc/search_bloc/search_state.dart';
import 'package:barboraapp/bloc/product_bloc/product_bloc.dart';
import 'package:barboraapp/bloc/product_bloc/product_state.dart';
import 'package:barboraapp/bloc/recipe_bloc/recipe_bloc.dart';
import 'package:barboraapp/data/models/sort_model.dart';
import 'package:barboraapp/screeens/product_detail.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:barboraapp/screeens/widgets/product_carousel.dart';
import 'package:barboraapp/screeens/widgets/recipe_carosel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../bloc/home_bloc/search_bloc/search_bloc.dart';
import '../bloc/recipe_bloc/saved_recipe_bloc/saved_recipe_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  late CarouselController _carouselController;
  bool searchOn = false;
  late FocusNode searchFieldNode;
  late AnimationController _controller;
  late Tween<double> _searchTween;
  late TextEditingController _searchController;

  List<String> carousel_image = [
    "assets/carousel_1.jpg",
    "assets/carousel_2.jpg",
    "assets/carousel_3.jpg",
    "assets/carousel_4.jpg",
  ];

  List<String> reccom_image = [
    "assets/reccom_1.jpg",
    "assets/reccom_2.jpg",
    "assets/reccom_3.jpg",
    "assets/reccom_4.jpg",
    "assets/reccom_5.jpg",
    "assets/reccom_6.jpg",
  ];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _searchTween = Tween<double>(
      begin: 0, //MediaQuery.of(context).size.width * 0.95
      end: 65.0, // (MediaQuery.of(context).size.width * 0.95) -
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _searchController = TextEditingController();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    searchFieldNode = FocusNode();
    searchFieldNode.unfocus();
    _carouselController = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ColorfulSafeArea(
      color: Colors.red,
      child: WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: BlocBuilder<SearchBloc, SearchState>(
              builder: (searchContext, searchState){
                return productAppBar(
                  cancelText: AppLocalizations.of(context)!.cancel,
                  textEditingController: _searchController,
                  controller: _controller,
                  searchState: searchState is SearchOnState,
                  textFieldFunc: (){

                    BlocProvider.of<SearchBloc>(context).searchOn();
                    _controller.forward();
                  },
                  cancelFunc: (){
                    BlocProvider.of<SearchBloc>(context).searchOff();
                    _searchController.text = "";
                    _controller.reverse();
                    FocusManager.instance.primaryFocus!.unfocus();
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
                  widthValue: _searchTween,
                  hintText: AppLocalizations.of(context)!.productSearch
                );
              },
            ),
            centerTitle: true,
            backgroundColor: const Color(0xffE32323),
          ),
          body: BlocBuilder<SearchBloc, SearchState>(
            builder: (searchContext, searchState){
              return searchState is SearchOffState
                ? ListView(
                 children: [
                  Column(
                    children: [
                      CarouselSlider(
                        carouselController: _carouselController,
                        items: carousel_image.map((url) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: AssetImage(
                                  url,
                                ),
                                fit: BoxFit.fill
                              )
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 200,
                          aspectRatio: 16/9,
                          viewportFraction: 0.95,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: false,
                          scrollDirection: Axis.horizontal,
                          pageSnapping: true,
                          onPageChanged: (int page, _){
                            BlocProvider.of<CarouselBloc>(context).changePage(page);
                          }
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: BlocBuilder<CarouselBloc, int>(
                          builder: (context, index){
                            return AnimatedSmoothIndicator(
                              activeIndex: index,
                              count: carousel_image.length,
                              effect: ScaleEffect(
                                dotHeight: 8.0,
                                dotWidth: 8.0,
                                spacing: 25.0,
                                dotColor: Colors.grey.shade400,
                                activeDotColor: const Color(0xffE32323),
                              ),
                              onDotClicked: (int dot){
                                _carouselController.animateToPage(dot);
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)
                      ),
                      color: Colors.green,
                      elevation: 0.0,
                      highlightElevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 5.0, right: 8.0, left: 8.0),
                            child: Center(
                              child: Icon(Icons.calendar_today, color: Colors.white,),
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.bookASlot,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.0
                            ),
                          )
                        ],
                      ),
                      onPressed: (){
                        BlocProvider.of<BottomNavBloc>(context).changeBottomNavIndex(3);
                      },
                    ),
                  ),
                  _buildHeaders(heading: AppLocalizations.of(context)!.specialOffers, context: context, onPressed: (){

                  }),
                  MultiBlocProvider(
                    providers: [
                      BlocProvider<ProductBloc>(create: (context) => ProductBloc(collectionName: "product_spl")),
                      BlocProvider<CartBloc>(create: (context) => CartBloc()),
                      BlocProvider(create: (context) => SaveProductBloc()),
                      (BlocProvider.of<AuthBloc>(context).state is UserState)
                          ? BlocProvider(create: (context) => ExistingFavCartBloc(uid: (BlocProvider.of<AuthBloc>(context).state as UserState).uid))
                          : BlocProvider(create: (context) => DummyBloc()),
                      BlocProvider(create: (context)=> CheckBloc())
                    ],
                    child: ProductCarousel(),
                  ),
                  _buildHeaders(heading: AppLocalizations.of(context)!.ourRecommendation, context: context, onPressed: (){

                  }),
                  _recommendationCarousel(),
                  _buildHeaders(heading: AppLocalizations.of(context)!.popularProducts, context: context, onPressed: (){

                  }),
                  MultiBlocProvider(
                    providers: [
                      BlocProvider<ProductBloc>(create: (context) =>  ProductBloc(collectionName: "product_popular",)),
                      BlocProvider<CartBloc>(create: (context) => CartBloc()),
                      BlocProvider(create: (context) => SaveProductBloc()),
                      (BlocProvider.of<AuthBloc>(context).state is UserState)
                          ? BlocProvider(create: (context) => ExistingFavCartBloc(uid: (BlocProvider.of<AuthBloc>(context).state as UserState).uid))
                          : BlocProvider(create: (context) => DummyBloc()),
                      BlocProvider(create: (context)=> CheckBloc())

                    ],
                    child: ProductCarousel(),
                  ),
                  _buildHeaders(heading: AppLocalizations.of(context)!.recommendedPromo, context: context, onPressed: (){

                  }),
                  MultiBlocProvider(
                    providers: [
                      BlocProvider<ProductBloc>(create: (context) => ProductBloc(collectionName: "product_recommended",)),
                      BlocProvider<CartBloc>(create: (context) => CartBloc()),
                      BlocProvider(create: (context) => SaveProductBloc()),
                      (BlocProvider.of<AuthBloc>(context).state is UserState)
                          ? BlocProvider(create: (context) => ExistingFavCartBloc(uid: (BlocProvider.of<AuthBloc>(context).state as UserState).uid))
                          : BlocProvider(create: (context) => DummyBloc()),
                      BlocProvider(create: (context)=> CheckBloc())
                    ],
                    child: ProductCarousel(),
                  ),
                  _buildHeaders(heading: AppLocalizations.of(context)!.recipes, context: context, onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => BlocProvider.value(
                      value: SavedRecipeBloc(),
                      child: RecipeScreen(),
                    )));
                  }),
                   MultiBlocProvider(
                     providers: [
                       BlocProvider<RecipeBloc>.value(
                         value: RecipeBloc(type: "sriuba"),
                       ),
                       BlocProvider<SavedRecipeBloc>.value(
                         value: BlocProvider.of<SavedRecipeBloc>(context),
                       ),
                     ],
                     child: RecipeCarousel(),
                   )
                ],
              )
              : Container(
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
        onWillPop: willPopFunc,
      ),
    );
  }

  Widget _recommendationCarousel(){
    return CarouselSlider(
      items: reccom_image.map((url) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage(
                  url,
                ),
                fit: BoxFit.contain
              )
          ),
        );
      }).toList(),
      options: CarouselOptions(
          height: 120,
          aspectRatio: 16/9,
          viewportFraction: 0.45,
          initialPage: 0,
          enableInfiniteScroll: false,
          reverse: false,
          autoPlay: false,
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
          pageSnapping: false,
          padEnds: false
      ),
    );
  }

  Future<bool> willPopFunc() async{
    _controller.reverse();
    FocusManager.instance.primaryFocus!.unfocus();
    BlocProvider.of<SearchBloc>(context).searchOff();
    return Future.value(true);
  }

  Widget _buildHeaders({required String heading, required BuildContext context, required VoidCallback onPressed}) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            heading,
            style: TextStyle(
              fontSize: AppLocalizations.of(context)!.localeName.toLowerCase() == "ru" ? 15.0 : 18.0,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        TextButton(
          child: Text(
            AppLocalizations.of(context)!.viewAll,
            style: TextStyle(
              color: Colors.red,
              fontSize: AppLocalizations.of(context)!.localeName.toLowerCase() == "ru" ? 14.0 : 16.0,
              fontWeight: FontWeight.normal
            ),
          ),
          onPressed: onPressed,
        )
      ],
    ),
  );
}
