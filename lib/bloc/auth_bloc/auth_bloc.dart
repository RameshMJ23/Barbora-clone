

import 'dart:developer';

import 'package:barboraapp/bloc/auth_bloc/auth_state.dart';
import 'package:barboraapp/data/models/address_model.dart';
import 'package:barboraapp/data/services/auth/auth_service.dart';
import 'package:barboraapp/data/services/user_service.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc extends Cubit<AuthState> {

  final AuthService _authService = AuthService();

  AuthBloc() :super(LoadingState()){
    _authService.authState().listen((user) {
      if(user != null){
        emit(LoadingState());
        Future.delayed(const Duration(seconds: 1), (){
          log("From AuthBloc ============ UserState ======");
          emit(UserState(uid: user.uid));
        });
      }else{
        log("From AuthBloc ============ NoUserState ======");
        emit(LoadingState());
        Future.delayed(const Duration(seconds: 1), (){
          log("From AuthBloc ============ NoUserState ======");
          emit(NoUserState());
        });
      }
    });
  }

  singInWithGoogleBl() async{
    await _authService.signInWithGoogleAccount();
  }

  logOut() async{
    await _authService.logOutUser();
  }

  signInWithEmailAndPassBl(String email, String password) async{
    await _authService.signInUser(email, password);
  }

  Future<UserCredential?> registerUserWithEmailAndPassBl(
      String email,
      String password,
      String firebaseAddressId,
      AddressModel address
  ) async{
    await _authService.registerUser(email, password).then((value) async{
      if(value != null){
        await UserService().setNewUserAddress(
          value.user!.uid,
          firebaseAddressId,
          address
        );

        await UserService().createFavouriteProductNameList(value.user!.uid, []);
      }
    });
  }

  setNewUserData(
    String uid,
    String firebaseAddressId,
    AddressModel address
  ) async{
    await UserService().setNewUserAddress(uid, firebaseAddressId, address);
  }

}