import 'dart:developer';

import 'package:barboraapp/bloc/address_bloc/address_bloc.dart';
import 'package:barboraapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:barboraapp/bloc/auth_bloc/auth_state.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_bloc.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_process_bloc/booking_process_bloc.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_process_bloc/booking_process_state.dart';
import 'package:barboraapp/bloc/booking_bloc/reservation_bloc/reservation_bloc.dart';
import 'package:barboraapp/bloc/cart_bloc/cart_bloc.dart';
import 'package:barboraapp/screeens/book_screen_auth.dart';
import 'package:barboraapp/screeens/book_screen_logged_in.dart';
import 'package:barboraapp/screeens/common_loggedout_screen.dart';
import 'package:barboraapp/screeens/widgets/common_bookin_loading_screen.dart';
import 'package:barboraapp/screeens/widgets/deliver_to_home.dart';
import 'package:barboraapp/screeens/widgets/will_pickup_myself.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/booking_bloc/booking_state.dart';

class BookScreen extends StatefulWidget {

  bool showProgressBar;

  BookScreen({this.showProgressBar = false});
  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {

  late BookingBloc bookingBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingBloc = BookingBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (blocContext, state){
        if(state is NoUserState){
          return CommonLoggedOutScreen(
            content: "To book a slot, register or log in",
            icon: Icons.calendar_today,
          );
        }else{
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: bookingBloc,
              ),
              BlocProvider.value(
                value: BlocProvider.of<BookingProcessBloc>(context),
              ),
              BlocProvider.value(
                value: CartBloc(),
              )
            ],
            child: BookScreenLoggedIn(widget.showProgressBar)
          );
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    bookingBloc.close();
    super.dispose();
  }
}
