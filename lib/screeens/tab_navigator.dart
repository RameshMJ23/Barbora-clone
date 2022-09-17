import 'package:barboraapp/bloc/address_bloc/address_bloc.dart';
import 'package:barboraapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:barboraapp/bloc/home_bloc/carousel_bloc.dart';
import 'package:barboraapp/bloc/home_bloc/search_bloc/search_bloc.dart';
import 'package:barboraapp/bloc/product_bloc/product_bloc.dart';
import 'package:barboraapp/bloc/recipe_bloc/saved_recipe_bloc/saved_recipe_bloc.dart';
import 'package:barboraapp/data/models/product_model.dart';
import 'package:barboraapp/screeens/book_screen.dart';
import 'package:barboraapp/screeens/cart_screen.dart';

import 'package:barboraapp/screeens/home_screen.dart';
import 'package:barboraapp/screeens/more_screen.dart';
import 'package:barboraapp/screeens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabNavigator extends StatefulWidget {

  String tabName;
  GlobalKey<NavigatorState> navigatorKey;

  @override
  _TabNavigatorState createState() => _TabNavigatorState();

  TabNavigator({
    required this.tabName, required this.navigatorKey
  });
}

class _TabNavigatorState extends State<TabNavigator> {
  @override

  late List<String> pageKey;
  late AuthBloc authBlocInstance;
  late CarouselBloc carouselBloc;
  late SearchBloc searchBloc;
  late SearchBloc productSearchBloc;

  @override
  void initState() {
    // TODO: implement initState
    pageKey = ["home", "products", "cart", "book", "more"];
    authBlocInstance = BlocProvider.of<AuthBloc>(context);
    carouselBloc = CarouselBloc();
    searchBloc = SearchBloc();
    productSearchBloc = SearchBloc();
    super.initState();
  }

  RectTween _createRectTween(Rect? begin, Rect? end){
    return MaterialRectArcTween(begin: begin, end: end);
  }

  @override
  Widget build(BuildContext context) {

    late Widget child;

    if(widget.tabName == "home"){
      child = MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: carouselBloc,
          ),
          BlocProvider.value(
            value: searchBloc,
          ),
          BlocProvider<SavedRecipeBloc>(
            create: (context) => SavedRecipeBloc(),
            lazy: false,
          )
        ],
        child: HomeScreen()
      );
    }else if(widget.tabName == "products"){
      child = BlocProvider.value(
        value: productSearchBloc,
        child: ProductScreen(),
      );
    }else if(widget.tabName == "cart"){
      child = BlocProvider.value(
        value: authBlocInstance,
        child: CartScreen(),
      );
    }else if(widget.tabName == "book"){
      child = MultiBlocProvider(
        providers: [
          BlocProvider.value(value: authBlocInstance,),
        ], 
        child: BookScreen()
      );
    }else if(widget.tabName == "more"){
      child = MoreScreen();
    }

    return HeroControllerScope(
      controller: MaterialApp.createMaterialHeroController(),
      child: Navigator(
        key: widget.navigatorKey,
        onGenerateRoute: (routeSettings){
          return MaterialPageRoute(
            builder: (_) => child,
            settings: routeSettings
          );
        },
      )
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    authBlocInstance.close();
    carouselBloc.close();
    searchBloc.close();
    super.dispose();
  }
}
