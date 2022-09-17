

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BottomNavBloc extends Cubit<int>{

  BottomNavBloc():super(0);

  changeBottomNavIndex(int index){

    log("From Nav Bloc: $index");
    emit(index);
  }
}