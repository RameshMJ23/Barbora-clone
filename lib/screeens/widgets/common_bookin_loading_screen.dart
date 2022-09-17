
import 'package:barboraapp/bloc/booking_bloc/booking_bloc.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_process_bloc/booking_process_bloc.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_state.dart';
import 'package:barboraapp/bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'package:barboraapp/data/models/booking_model.dart';
import 'package:barboraapp/screeens/book_screen_logged_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonBookingLoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingBloc, BookingState>(
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.red,
            color: Colors.green,
          ),
        ),
      ),
      listener: (context, state){
        if(state is DeliverToHomeState){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: BlocProvider.of<BookingBloc>(context),
                ),
                BlocProvider.value(
                  value: BlocProvider.of<BookingProcessBloc>(context),
                ),
              ],
              child: BlocBuilder<BottomNavBloc, int>(
                builder: (context, bottomNavIndex){
                  return BookScreenLoggedIn(
                    bottomNavIndex == 2,
                    defaultTab: 0,
                  );
                },
              )
            ))
          );
        }else if(state is WillPickUpMyselfState){
          Navigator.pushReplacement(
            context,
              MaterialPageRoute(builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: BlocProvider.of<BookingBloc>(context),
                  ),
                  BlocProvider.value(
                    value: BlocProvider.of<BookingProcessBloc>(context),
                  )
                ],
                child: BlocBuilder<BottomNavBloc, int>(
                  builder: (context, bottomNavIndex){
                    return BookScreenLoggedIn(
                      bottomNavIndex == 2,
                      defaultTab: 1,
                    );
                  },
                )
              ))
          );
        }
      },
    );
  }
}
