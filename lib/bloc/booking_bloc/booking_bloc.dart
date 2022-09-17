

import 'dart:developer';

import 'package:barboraapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingBloc extends Cubit<BookingState>{

  BookingBloc():super(DeliverToHomeState());

  changeToDeliverToHome(){
    //if(isClosed) return;
    log("From booking bloc: change to DeliverHome called =================");
    emit(BookingLoadingState());
    Future.delayed(const Duration(milliseconds: 500), (){
      emit(DeliverToHomeState());
    });
  }

  changeToPickUpMyself(){
    //if(isClosed) return;
    log("From booking bloc: change to Pickup called =================");
    emit(BookingLoadingState());
    Future.delayed(const Duration(milliseconds: 500), (){
      emit(WillPickUpMyselfState());
    });

  }

}