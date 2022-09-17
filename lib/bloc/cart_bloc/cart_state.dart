

import 'package:barboraapp/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CartLoadingState extends CartState{

}

class CartFetchedState extends CartState{

  List<ProductModel> cartProducts;

  CartFetchedState({required this.cartProducts});

  @override
  // TODO: implement props
  List<Object?> get props => [cartProducts];
}

class NoCartState extends CartState{

  @override
  // TODO: implement props
  List<Object?> get props => super.props;
}