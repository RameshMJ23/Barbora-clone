
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscountFieldBloc extends Cubit<bool>{

  DiscountFieldBloc():super(false);

  enableButton(bool value){
    if(value != state) emit(value);
  }
}