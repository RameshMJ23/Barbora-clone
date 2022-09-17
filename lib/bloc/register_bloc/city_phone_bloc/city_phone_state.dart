
import 'package:equatable/equatable.dart';

class CityPhoneState extends Equatable{
  String? city;
  String phoneNum;

  CityPhoneState({required this.phoneNum, this.city});

  @override
  // TODO: implement props
  List<Object?> get props => [city, phoneNum];
}

