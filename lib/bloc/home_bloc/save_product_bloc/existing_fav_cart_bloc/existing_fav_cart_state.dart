

import 'package:equatable/equatable.dart';

class ExistingFavCartState  extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchedExistingFavCartState  extends ExistingFavCartState{

  List existingFavCarts;

  FetchedExistingFavCartState({required this.existingFavCarts});

  @override
  // TODO: implement props
  List<Object?> get props => [existingFavCarts];
}

class LoadingExistingFavCart extends ExistingFavCartState{

}