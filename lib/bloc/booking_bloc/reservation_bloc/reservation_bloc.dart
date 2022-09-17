
import 'package:barboraapp/bloc/booking_bloc/reservation_bloc/reservation_state.dart';
import 'package:barboraapp/data/shared_preference.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//class ReservationBloc extends Cubit<ReservationState>{
//
//  ReservationBloc():super(
//    ReservationState(
//      dayValue: SharedPreference.getReservationDayValue(),
//      timeValue: SharedPreference.getReservationTimeValue()
//    )
//  );
//
//  bookTime(int dayValue, int timeValue){
//    SharedPreference.setReservationValue(dayValue, timeValue);
//    emit(ReservationState(dayValue: dayValue, timeValue: timeValue));
//  }
//}