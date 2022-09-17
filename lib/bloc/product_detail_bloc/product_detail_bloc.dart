
import 'package:barboraapp/bloc/product_bloc/product_bloc.dart';
import 'package:barboraapp/bloc/product_bloc/product_state.dart';
import 'package:barboraapp/data/models/sort_model.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/product_model.dart';

class ProductDetailBloc extends Cubit<ProductState>{

  String collectionName;

  String? where;

  ProductDetailBloc({required this.collectionName,this.where}):super(NoProductState());

  getProducts(
    SortEnum sortEnum, {
    DiscountOptionsEnum discountOptionsEnum = DiscountOptionsEnum.none,
    String country = "",
    String brand = ""
  }){
    ProductBloc(collectionName: collectionName, where: where).stream.listen((state) {
      if(state is FetchedProductState){

        final realList = (discountOptionsEnum != DiscountOptionsEnum.none) ? state.products.where((e){
          return e.isOffer;
        }).toList() : state.products;

        switch(sortEnum){
          case SortEnum.defaultSort:
            emit(
              FetchedProductState(
                products: realList,
                sortEnum: SortEnum.defaultSort,
                discountOptionsEnum: discountOptionsEnum,
                countryName: country,
                brand: brand
              )
            );
            break;
          case SortEnum.ascendingOrder:
            emit(
              FetchedProductState(
                products: _sortAscending(realList),
                sortEnum: SortEnum.ascendingOrder,
                discountOptionsEnum: discountOptionsEnum,
                countryName: country,
                brand: brand
              )
            );
            break;
          case SortEnum.descendingOrder:
            emit(
              FetchedProductState(
                products: _sortDescending(realList),
                sortEnum: SortEnum.descendingOrder,
                discountOptionsEnum: discountOptionsEnum,
                countryName: country,
                brand: brand
              )
            );
            break;
          case SortEnum.priceFromLowest:
            emit(
              FetchedProductState(
                products: _priceFromLowest(realList),
                sortEnum: SortEnum.priceFromLowest,
                discountOptionsEnum: discountOptionsEnum,
                countryName: country,
                brand: brand
              )
            );
            break;
          case SortEnum.priceFromHighest:
            emit(
              FetchedProductState(
                products: _priceFromHighest(realList),
                sortEnum: SortEnum.priceFromHighest,
                discountOptionsEnum: discountOptionsEnum,
                countryName: country,
                brand: brand
              )
            );
            break;
          case SortEnum.withoutDiscountFirst:
            emit(
              FetchedProductState(
                products: _withoutDiscountFirst(realList),
                sortEnum: SortEnum.withoutDiscountFirst,
                discountOptionsEnum: discountOptionsEnum,
                countryName: country,
                brand: brand
              )
            );
            break;
          case SortEnum.withDiscountFirst:
            emit(
              FetchedProductState(
                products: _withDiscountFirst(realList),
                sortEnum: SortEnum.withDiscountFirst,
                discountOptionsEnum: discountOptionsEnum,
                countryName: country,
                brand: brand
              )
            );
            break;
          default:
            emit(
              FetchedProductState(
                products: state.products,
                sortEnum: SortEnum.defaultSort,
                discountOptionsEnum: discountOptionsEnum,
                countryName: country,
                brand: brand
              )
            );
            break;
        }
      }else{
        emit(NoProductState());
      }
    });
  }

  List<ProductModel> _sortAscending(List<ProductModel> list){
    list.sort((a,b) => a.title.trim().compareTo(b.title));

    return list;
  }

  List<ProductModel> _sortDescending(List<ProductModel> list){
    list.sort((b,a) => a.title.trim().compareTo(b.title));

    return list;
  }

  List<ProductModel> _priceFromLowest(List<ProductModel> list){
    list.sort((a,b) => double.parse(a.original_cost).compareTo(double.parse(b.original_cost)));

    return list;
  }

  List<ProductModel> _priceFromHighest(List<ProductModel> list){
    list.sort((b,a) => double.parse(a.original_cost).compareTo(double.parse(b.original_cost)));

    return list;
  }

  List<ProductModel> _withDiscountFirst(List<ProductModel> list){
    final discountList = list.where((product) => product.isOffer == true).toList();

    final nonDiscountList = list.where((product) => product.isOffer == false).toList();

    //discountList.addAll(nonDiscountList);

    return List.from(discountList)..addAll(nonDiscountList);

    //return discountList;
  }

  List<ProductModel> _withoutDiscountFirst(List<ProductModel> list){
    final discountList = list.where((product) => product.isOffer == true).toList();

    final nonDiscountList = list.where((product) => product.isOffer == false).toList();

    //nonDiscountList.addAll(discountList);

    return List.from(nonDiscountList)..addAll(discountList);

    //return nonDiscountList;
  }
}