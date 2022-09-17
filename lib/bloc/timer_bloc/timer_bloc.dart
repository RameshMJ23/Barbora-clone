

import 'dart:async';
import 'dart:developer';

import 'package:barboraapp/bloc/booking_bloc/booking_process_bloc/booking_process_bloc.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_process_bloc/booking_process_state.dart';
import 'package:barboraapp/bloc/timer_bloc/timer_state.dart';
import 'package:bloc/bloc.dart';

class TimerBloc extends Cubit<TimerState>{
  
  TimerBloc():super(TimerState(time: "", lastMinutes: false, isFinished: false));
  
  Duration bookingDuration = Duration(minutes: 40);


  Timer? countDownTimer;
  
  startTimer(){
    countDownTimer = Timer.periodic(const Duration(seconds: 1), (timer) => countDownFunc());
  }

  stopTimer(){
    if(countDownTimer != null){
      countDownTimer!.cancel();
    }
  }

  restartTimer(){
    stopTimer();
    bookingDuration = Duration(minutes: 40);
    startTimer();
  }

  countDownFunc(){
    if(bookingDuration.inSeconds <= 0){
      stopTimer();
    }else{
      bookingDuration = Duration(seconds: bookingDuration.inSeconds - 1);
      if(bookingDuration.inSeconds > 1){
        if(bookingDuration.inSeconds < 300){
          emit(
            TimerState(
              lastMinutes: true,
              isFinished: false,
              time: "${bookingDuration.inMinutes.toString()}:${getSeconds(bookingDuration.inSeconds.remainder(60).toString())}"
            )
          );
        }else{
        emit(
            TimerState(
              lastMinutes: false,
              isFinished: false,
              time: "${bookingDuration.inMinutes.toString()}:${getSeconds(bookingDuration.inSeconds.remainder(60).toString())}"
            )
          );
        }
      }else{
        emit(TimerState(lastMinutes: true, isFinished: true, time: ""));
      }
    }
  }

  stopTimerForLeavingOut(){
    stopTimer();
    emit(TimerState(time: "", lastMinutes: true, isFinished: true));
  }
  
  String getSeconds(String seconds){
    return seconds.length >= 2 ? seconds : seconds.padLeft(2, "0");
  }
  
}