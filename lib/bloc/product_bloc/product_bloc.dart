
import 'package:barboraapp/bloc/product_bloc/product_state.dart';
import 'package:barboraapp/bloc/recipe_bloc/recipe_bloc.dart';
import 'package:barboraapp/data/models/product_model.dart';
import 'package:barboraapp/data/models/sort_model.dart';
import 'package:barboraapp/data/services/recipe_service.dart';
import 'package:barboraapp/data/services/product_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Cubit<ProductState>{

  late String collectionName;

  late String? where;

  ProductBloc({required this.collectionName, this.where}):super(NoProductState()){
    final subscription = ProductService(collectionName: collectionName).getProducts(where);

    //add Loading state
    subscription.listen((productList) {
      if(productList != null){
        emit(ProductLoadingState());
        if(isClosed) return;
        Future.delayed(const Duration(milliseconds: 200), (){
          emit(FetchedProductState(products: productList, sortEnum: SortEnum.defaultSort));
        });
      }else{
        emit(ProductLoadingState());
        emit(NoProductState());
      }
    });
  }

  @override
  Future<void> close() async{
    // TODO: implement close
    //return super.close();
    return;
  }


}