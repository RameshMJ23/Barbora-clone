

import 'dart:developer';

import 'package:barboraapp/data/models/address_model.dart';
import 'package:barboraapp/data/services/user_service.dart';
import 'package:barboraapp/data/shared_preference.dart';
import 'package:bloc/bloc.dart';

enum AddressBlocEnum{
  pickUpLocation,
  homeAddress
}

class SelectAddressBloc extends Cubit<int>{

  SelectAddressBloc(AddressBlocEnum blocFun):super(
      blocFun == AddressBlocEnum.homeAddress
       ? SharedPreference.getAddressIndex()
       : SharedPreference.getPickUpLocationIndex()
  );

  changeAddress(int index){
    emit(index);
  }

  saveIndex(int index){
    SharedPreference.setAddressIndex(index);
  }

  savePickLocationIndex(int index){
    SharedPreference.setPickupLocationIndex(index);
  }

}