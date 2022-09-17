
import 'package:equatable/equatable.dart';

class CheckBlocState extends Equatable{

  List<int> checkList;

  CheckBlocState({required this.checkList});

  @override
  // TODO: implement props
  List<Object?> get props => [checkList];
}