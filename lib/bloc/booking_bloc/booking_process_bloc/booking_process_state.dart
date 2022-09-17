
import 'package:equatable/equatable.dart';

abstract class BookingProcessState extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ToBookState extends BookingProcessState{

  int dayValue;
  int timeValue;

  ToBookState({required this.dayValue, required this.timeValue});

  @override
  // TODO: implement props
  List<Object?> get props => [dayValue, timeValue];
}

class BookedState extends BookingProcessState{

  int dayValue;
  int timeValue;

  BookedState({
    required this.dayValue,
    required this.timeValue
  });

  @override
  // TODO: implement props
  List<Object?> get props => [dayValue, timeValue];
}


class ReBookState extends BookingProcessState{

  int dayValue;
  int timeValue;

  int newDayVal;
  int newTimeVal;

  ReBookState({
    required this.dayValue,
    required this.timeValue,
    required this.newDayVal,
    required this.newTimeVal
  });

  @override
  // TODO: implement props
  List<Object?> get props => [dayValue, timeValue, newDayVal, newTimeVal];
}
