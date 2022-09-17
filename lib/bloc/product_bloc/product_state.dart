
import 'package:barboraapp/data/models/product_model.dart';
import 'package:barboraapp/data/models/sort_model.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:equatable/equatable.dart';

class ProductState extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NoProductState extends ProductState{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchedProductState extends ProductState{

  List<ProductModel> products;

  SortEnum sortEnum;

  DiscountOptionsEnum discountOptionsEnum;

  String countryName;

  String brand;

  FetchedProductState({
    required this.products,
    required this.sortEnum,
    this.countryName = "",
    this.discountOptionsEnum = DiscountOptionsEnum.none,
    this.brand = ""
  });

  @override
  // TODO: implement props
  List<Object?> get props => [products, sortEnum, discountOptionsEnum, countryName, brand];
}

class ProductLoadingState extends ProductState{

}