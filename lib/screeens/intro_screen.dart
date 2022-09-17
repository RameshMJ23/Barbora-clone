import 'package:barboraapp/bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'package:barboraapp/bloc/cart_bloc/cart_bloc.dart';
import 'package:barboraapp/screeens/home_screen.dart';
import 'package:barboraapp/screeens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with SingleTickerProviderStateMixin{

  late AnimationController _lottieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lottieController = AnimationController(vsync: this);

    _lottieController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        Navigator.pushReplacement(
          context,
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xffFF0000),
      body: Lottie.asset(
        "assets/barbora.json",
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.fill,
        onLoaded: (comp){
          _lottieController..duration = comp.duration..forward();
        },
        controller: _lottieController
      ),
    );
  }
}


