
import 'package:equatable/equatable.dart';

class TimerState extends Equatable{

  String time;

  bool lastMinutes;

  bool isFinished;

  TimerState({
    required this.lastMinutes,
    required this.isFinished,
    required this.time
  });

  @override
  // TODO: implement props
  List<Object?> get props => [time, lastMinutes, isFinished];
}