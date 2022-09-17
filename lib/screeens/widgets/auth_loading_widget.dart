import 'dart:developer';

import 'package:barboraapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:barboraapp/bloc/auth_bloc/auth_state.dart';
import 'package:barboraapp/screeens/home_screen.dart';
import 'package:barboraapp/screeens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.green,
            color: Colors.red,
          ),
        ),
      ),
      listener: (context, state){
        log("From Auth Loading Widget =========" + state.toString());
        if(state is NoUserState || state is UserState){
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, primAnim, secAnim){
                return MainScreen();
              },
              transitionsBuilder: (context, primAnim, secAnim, child){

                final offsetTween = Tween(begin: const Offset(0,1), end: const Offset(0,0));

                return SlideTransition(
                  position: offsetTween.animate(
                      CurvedAnimation(
                        parent: primAnim,
                        curve: Curves.easeInQuint
                      )
                  ),
                  child: child,
                );
              },
              transitionDuration: const Duration(seconds: 2)
            )
          );
        }
      },
    );
  }
}
