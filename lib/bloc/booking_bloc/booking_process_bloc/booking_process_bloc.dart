
import 'dart:developer';

import 'package:barboraapp/bloc/booking_bloc/booking_process_bloc/booking_process_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class BookingProcessBloc extends HydratedCubit<BookingProcessState>{
  BookingProcessBloc():super(ToBookState(dayValue: 0, timeValue: 0));

  changeReservation(int dayValue, int timeValue){
    emit(ToBookState(dayValue: dayValue, timeValue: timeValue));
  }

  changeToBooked(int dayValue, int timeValue){
    emit(BookedState(dayValue: dayValue, timeValue: timeValue));
  }

  reBook(int dayValue, int timeValue){
    emit(ReBookState(dayValue: dayValue, timeValue: timeValue, newDayVal: dayValue, newTimeVal: timeValue));
  }

  reBookNewVal(int newDayVal, int newTimeVal){
    emit(
      ReBookState(
        dayValue: (state as ReBookState).dayValue,
        timeValue: (state as ReBookState).timeValue,
        newDayVal: newDayVal,
        newTimeVal: newTimeVal
      )
    );
  }

  @override
  Map<String, dynamic>? toJson(BookingProcessState state) {

    log("Data stored in Booking process bloc ${state.toString()}");

    if(state is BookedState){
      return {
        "value" : "BookedState()",
        "dayValue": state.dayValue,
        "timeValue": state.timeValue
      };
    }else if(state is ReBookState){
      return {
        "value" : "ReBookState()",
        "dayValue": state.dayValue,
        "timeValue": state.timeValue,
        "newDayVal": state.newDayVal,
        "newTimeVal": state.newTimeVal
      };
    }else{
      return null;
    }
  }


  @override
  BookingProcessState fromJson(Map<String, dynamic> json) {

    log("Data retrieved from Booking process bloc ${json["value"]}");

    if(json["value"] == "BookedState()"){
      log("Booked state is retrieved ${json["value"]}");
      return BookedState(dayValue: json["dayValue"], timeValue: json["timeValue"]);
    }else{
      log("Reebok State is retrieved ${json["value"]}");
      return ReBookState(
        dayValue: json["dayValue"],
        timeValue: json["timeValue"],
        newDayVal: json["newDayVal"],
        newTimeVal: json["newTimeVal"]
      );
    }
  }

  @override
  Future<void> close() async{
    // TODO: implement close
    log("+++++++++++++ From booking process bloc ========= stream is closed");
    return;
  }
}