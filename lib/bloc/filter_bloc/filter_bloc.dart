

import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'filter_bloc_state.dart';



class FilterBloc extends Cubit<FilterBlocState>{

  FilterBloc():super(FilterBlocState(filterScreenEnum: FilterScreenEnum.startScreen));

  changeScreen(FilterScreenEnum screenEnum){
    emit(FilterBlocState(filterScreenEnum: screenEnum));
  }

  changeDiscount(DiscountOptionsEnum discountOptionsEnum){
    emit(FilterBlocState(filterScreenEnum: state.filterScreenEnum, discountOptionsEnum: discountOptionsEnum));
  }

  changeCountry(int index){
    emit(FilterBlocState(filterScreenEnum: state.filterScreenEnum, country: index));
  }

  changeBrand(int index){
    emit(FilterBlocState(filterScreenEnum: state.filterScreenEnum, brand: index));
  }
}