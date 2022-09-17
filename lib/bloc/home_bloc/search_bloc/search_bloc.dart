

import 'package:barboraapp/bloc/home_bloc/search_bloc/search_state.dart';
import 'package:barboraapp/bloc/product_bloc/product_bloc.dart';
import 'package:barboraapp/bloc/product_bloc/product_state.dart';
import 'package:barboraapp/data/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Cubit<SearchState>{

  SearchBloc():super(SearchOffState());

  searchOn(){
    ProductBloc(collectionName: "product_veg_n_fruits").stream.listen((event){
      if(event is FetchedProductState){
        emit(SearchOnState(searchProducts: event.products, showSuffix: false));
      }else{
        emit(SearchOnState(searchProducts: [], showSuffix: false));
      }
    });
  }

  searchQuery(List<ProductModel> searchedProduct, String query, bool showSuffix){
    query.isNotEmpty 
      ? emit(SearchOnState(searchProducts: searchedProduct.where((e){
        return e.titleEn.toLowerCase().trim().contains(query) ? true : false;
      }).toList(), showSuffix: showSuffix))
      : searchOn();
  }

  searchOff(){
    emit(SearchOffState());
  }
}