
import 'package:barboraapp/bloc/register_bloc/city_phone_bloc/city_phone_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityPhoneBloc extends Cubit<CityPhoneState>{
  
  CityPhoneBloc():super(CityPhoneState(phoneNum: "+370", city: null));
  
  selectCity(String city){
    emit(CityPhoneState(phoneNum: state.phoneNum, city: city));
  }
  
  changePhoneCode(String phoneNum){
    emit(CityPhoneState(phoneNum: phoneNum, city: state.city));
  }
}