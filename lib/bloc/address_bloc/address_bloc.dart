
import 'dart:developer';

import 'package:barboraapp/bloc/address_bloc/address_state.dart';
import 'package:barboraapp/data/models/address_model.dart';
import 'package:barboraapp/data/services/user_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class AddressBloc extends Cubit<AddressState>{

  AddressBloc():super(AddressState(citySelected: null, iconIndex: 0));

  changeCitySelected(String val){
    emit(AddressState(citySelected: val, iconIndex: state.iconIndex));
  }

  changeIconIndex(int index){
    emit(AddressState(citySelected: state.citySelected, iconIndex: index));
  }

  Future<int> getAddressLength(String uid) async{
    return await UserService().getUserAddresses(uid).length;
  }

  addUserAddress({
    required String uid,
    required String addressId,
    required AddressModel address
  }) async{
    await UserService().setUserAddress(uid, addressId, address);
  }

  updateUserAddress({
    required String uid,
    required String addressId,
    required AddressModel address
  }) async{
     await UserService().updateUserAddress(uid, addressId, address);
  }

  removeUserAddress(String uid, String addressId) async{
    await UserService().deleteUserAddress(uid, addressId);
  }

  Future<String> getAddressId(String uid) async{

    log("From address Bloc length of saved address: ${(await getAddressLength(uid)).toString()}");
    return "address_${(await getAddressLength(uid)).toString()}";
  }
}