
import 'package:equatable/equatable.dart';

class ReservationState extends Equatable{

  int dayValue;

  int timeValue;

  ReservationState({required this.dayValue,required this.timeValue});

  @override
  // TODO: implement props
  List<Object?> get props => [dayValue, timeValue];
}