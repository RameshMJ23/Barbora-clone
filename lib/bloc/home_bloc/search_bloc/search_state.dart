
import 'package:barboraapp/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

class SearchState extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchOnState extends SearchState{

  List<ProductModel> searchProducts;
  bool showSuffix;

  SearchOnState({required this.searchProducts, required this.showSuffix});

  @override
  // TODO: implement props
  List<Object?> get props => [searchProducts, showSuffix];
}

class SearchOffState extends SearchState{

  @override
  // TODO: implement props
  List<Object?> get props => [];

}
