
import 'dart:developer';

import 'package:barboraapp/bloc/home_bloc/save_product_bloc/check_bloc/check_bloc_state.dart';
import 'package:bloc/bloc.dart';

class CheckBloc extends Cubit<CheckBlocState>{
  
  CheckBloc():super(CheckBlocState(checkList: []));

  checkBox(int value){
    final oldList = state.checkList;

    if(oldList.contains(value)){

      oldList.remove(value);
      log("Checklist value =============== ${oldList.toString()}");
      emit(CheckBlocState(checkList: oldList));
    }else{
      oldList.add(value);

      log("Checklist value =============== ${oldList.toString()}");
      emit(CheckBlocState(checkList: oldList));
    }
  }

  @override
  Future<void> close() async{
    // TODO: implement close
    return;
  }
}